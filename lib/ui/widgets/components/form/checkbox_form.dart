import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/body_m_text.dart';
import 'package:flutter/material.dart';

class CheckboxForm extends FormField<bool> {
  CheckboxForm({
    super.key,
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
                         style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
