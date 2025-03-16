// ignore_for_file: use_build_context_synchronously

import 'package:dog_gromming_website/di/di.dart';
import 'package:dog_gromming_website/domain/models/contact_client.dart';
import 'package:dog_gromming_website/domain/use_cases/send_email_use_case.dart';
import 'package:dog_gromming_website/ui/styles/sizes.dart';
import 'package:dog_gromming_website/ui/utils/validators_util.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/buttons/primary_button.dart';
import 'package:dog_gromming_website/ui/widgets/components/cards/outlined_card.dart';
import 'package:dog_gromming_website/ui/widgets/components/form/checkbox_form.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/title_l_text.dart';
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
    final List<Widget> leftFormPart = [
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
        decoration: InputDecoration(hintText: 'home.contact_form.name'.tr()),
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
    final List<Widget> rightFormPart = [
      CheckboxForm(
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
        decoration: InputDecoration(hintText: 'home.contact_form.message'.tr()),
        onSaved: (newValue) {
          message = newValue ?? '';
        },
      ),
      BoxSpacer.v16(),
      CheckboxForm(
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
          onPressed: () async {
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
              final useCase = getIt<SendEmailUseCase>();
              useCase(contactClient: contactClient).then((value) {
                if (value.isLeft) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('home.contact_form.error'.tr()),
                      backgroundColor: Theme.of(context).colorScheme.error,
                      duration: const Duration(seconds: 6),
                    ),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('home.contact_form.success'.tr()),
                    duration: const Duration(seconds: 6),
                  ),
                );
                _formKey.currentState?.reset();
              });
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
      child: Column(
        children: [
          TitleLText('home.contact_form.title'.tr()),
          BoxSpacer.v16(),
          Form(
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
                        child:
                            constraints.maxWidth > Sizes.xl.width
                                ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(children: leftFormPart),
                                    ),
                                    BoxSpacer.h16(),
                                    Expanded(
                                      child: Column(children: rightFormPart),
                                    ),
                                  ],
                                )
                                : Column(
                                  children: [
                                    ...leftFormPart,
                                    BoxSpacer.v16(),
                                    ...rightFormPart,
                                  ],
                                ),
                      ),
                      const Flexible(child: SizedBox.shrink()),
                    ],
                  );
                }
                return Column(
                  children: [
                    ...leftFormPart,
                    BoxSpacer.v16(),
                    ...rightFormPart,
                  ],
                );
              },
            ),
          ),
        ],
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
      decoration: InputDecoration(hintText: 'home.contact_form.pet_size'.tr()),
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
        DropdownMenuItem(value: 0, child: Text(_getLabel(0))),
        DropdownMenuItem(value: 1, child: Text(_getLabel(1))),
        DropdownMenuItem(value: 2, child: Text(_getLabel(2))),
        DropdownMenuItem(value: 3, child: Text(_getLabel(3))),
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
