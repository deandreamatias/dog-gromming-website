import 'package:dog_gromming_website/domain/models/contact_client.dart';
import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/styles/sizes.dart';
import 'package:dog_gromming_website/ui/utils/validators_util.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/buttons/primary_button.dart';
import 'package:dog_gromming_website/ui/widgets/components/cards/outlined_card.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/body_m_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatefulWidget {
  const ContactCard({super.key});

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String contactMethod = '';
  String name = '';
  String petName = '';
  bool whatsappCheckbox = false;
  String petSize = '';
  String message = '';
  bool privacyPolicyCheckbox = false;

  @override
  Widget build(BuildContext context) {
    final List<Widget> firstFormPart = [
      TextFormField(
        decoration: InputDecoration(
          hintText: 'home.contact_form.contact_method'.tr(),
        ),
        onSaved: (newValue) {
          contactMethod = newValue ?? '';
        },
        validator: (value) {
          // Required field
          if (ValidatorsUtil.isEmpty(value)) {
            return 'home.contact_form.contact_method_error'.tr();
          }

          // Verify is email or (phone) number
          return ValidatorsUtil.isEmail(value!) ||
                  ValidatorsUtil.isNumber(value)
              ? null
              : 'home.contact_form.contact_method_error'.tr();
        },
      ),
      BoxSpacer.v16(),
      TextFormField(
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          hintText: 'home.contact_form.name'.tr(),
        ),
        onSaved: (newValue) {
          name = newValue ?? '';
        },
        validator: (value) {
          // Required field
          return ValidatorsUtil.isEmpty(value)
              ? 'home.contact_form.name_error'.tr()
              : null;
        },
      ),
      BoxSpacer.v16(),
      TextFormField(
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          hintText: 'home.contact_form.pet_name'.tr(),
        ),
        onSaved: (newValue) {
          petName = newValue ?? '';
        },
      ),
      BoxSpacer.v16(),
      _DropdownPetSizeForm(
        onSaved: (newValue) {
          petSize = newValue ?? '';
        },
      ),
    ];
    final List<Widget> secondFormPart = [
      _CheckboxForm(
        title: 'home.contact_form.whatsapp_checkbox'.tr(),
        initialValue: whatsappCheckbox,
        onSaved: (newValue) {
          if (newValue != null && whatsappCheckbox != newValue) {
            whatsappCheckbox = newValue;
          }
        },
      ),
      BoxSpacer.v16(),
      TextFormField(
        maxLines: null,
        minLines: 3,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: 'home.contact_form.message'.tr(),
        ),
        onSaved: (newValue) {
          message = newValue ?? '';
        },
      ),
      BoxSpacer.v16(),
      _CheckboxForm(
        title: 'home.contact_form.privacy_policy_checkbox'.tr(),
        initialValue: privacyPolicyCheckbox,
        onSaved: (newValue) {
          if (newValue != null && privacyPolicyCheckbox != newValue) {
            privacyPolicyCheckbox = newValue;
          }
        },
        validator: (value) {
          // Required true field
          return value != true
              ? 'home.contact_form.privacy_policy_checkbox_error'.tr()
              : null;
        },
      ),
      BoxSpacer.v16(),
      Align(
        alignment: Alignment.centerRight,
        child: PrimaryButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final contactClient = ContactClient(
                contactMethod: contactMethod,
                name: name,
                petName: petName,
                whatsappCheckbox: whatsappCheckbox,
                petSize: petSize,
                message: message,
                privacyPolicyCheckbox: privacyPolicyCheckbox,
              );
              debugPrint(contactClient.toString());
              return;
            }
            setState(() {
              _autovalidateMode = AutovalidateMode.onUserInteraction;
            });
          },
          label: 'home.contact_form.submit'.tr(),
        ),
      ),
    ];

    return OutlinedCard(
      child: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > Sizes.m.width) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(child: SizedBox.shrink()),
                  Expanded(
                    child: constraints.maxWidth > Sizes.xl.width
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  children: firstFormPart,
                                ),
                              ),
                              BoxSpacer.h16(),
                              Expanded(
                                child: Column(
                                  children: secondFormPart,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              ...firstFormPart,
                              BoxSpacer.v16(),
                              ...secondFormPart,
                            ],
                          ),
                  ),
                  const Flexible(child: SizedBox.shrink()),
                ],
              );
            }
            return Column(
              children: [
                ...firstFormPart,
                BoxSpacer.v16(),
                ...secondFormPart,
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DropdownPetSizeForm extends StatefulWidget {
  final void Function(String?)? onSaved;
  const _DropdownPetSizeForm({this.onSaved});

  @override
  State<_DropdownPetSizeForm> createState() => _DropdownPetSizeFormState();
}

class _DropdownPetSizeFormState extends State<_DropdownPetSizeForm> {
  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      decoration: InputDecoration(
        hintText: 'home.contact_form.pet_size'.tr(),
      ),
      value: _selectedValue,
      onChanged: (value) {
        setState(() {
          _selectedValue = value;
        });
      },
      onSaved: (newValue) {
        widget.onSaved?.call(_getLabel(newValue));
      },
      items: [
        DropdownMenuItem(
          value: 0,
          child: Text(_getLabel(0)),
        ),
        DropdownMenuItem(
          value: 1,
          child: Text(_getLabel(1)),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text(_getLabel(2)),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text(_getLabel(3)),
        ),
      ],
    );
  }

  String _getLabel(int? value) {
    switch (value) {
      case 0:
        return 'home.contact_form.pet_size_small'.tr();
      case 1:
        return 'home.contact_form.pet_size_medium'.tr();
      case 2:
        return 'home.contact_form.pet_size_big'.tr();
      case 3:
        return 'home.contact_form.pet_size_giant'.tr();
      default:
        return '';
    }
  }
}

class _CheckboxForm extends FormField<bool> {
  _CheckboxForm({
    required String title,
    super.onSaved,
    super.validator,
    super.initialValue,
  }) : super(
          builder: (FormFieldState<bool> state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Builder(
                      builder: (context) {
                        return Checkbox(
                          value: state.value,
                          onChanged: state.didChange,
                          side: state.hasError
                              ? BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                  width: 2,
                                )
                              : null,
                        );
                      },
                    ),
                    BoxSpacer.h8(),
                    Expanded(
                      child: BodyMText(title, textAlign: TextAlign.start),
                    ),
                  ],
                ),
                if (state.hasError)
                  Builder(
                    builder: (context) {
                      return Padding(
                        padding: Insets.h8,
                        child: Text(
                          state.errorText ?? '',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        );
}
