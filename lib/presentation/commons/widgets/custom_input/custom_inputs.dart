import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interseguroapp/presentation/commons/theme/app_color.dart';

import 'validators_form.dart';

class CustomInputs {
  CustomInputs();

  static Widget entryReactiveTextField(context,
      {required String title,
      required TextEditingController formControlname,
      Map<ValidatorsType, String>? validationMessage,
      List<ValidatorsForm>? validators,
      ValueChanged<String>? onChange,
      int textArea = 1,
      String? hint,
      TextInputType? texType,
      bool isPassword = false,
      TextCapitalization textCapitalization = TextCapitalization.none,
      List<TextInputFormatter>? inputFormatters}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title,
            ),
          ),
          const SizedBox(
            height: 0,
          ),
          TextFormField(
              controller: formControlname,
              /* validationMessages: validationMessage == null
                  ? null
                  : (control) => validationMessage, */
              textCapitalization: textCapitalization,
              minLines: textArea,
              maxLines: textArea,
              validator: (value) {
                ValidatorsForm? re;
                if (validators == null) {
                  return null;
                }
                if (validators.isEmpty) {
                  return null;
                }
                for (var item in validators) {
                  if (!item.valid(value)) {
                    re = item;
                    break;
                  }
                }
                return re == null
                    ? null
                    : (validationMessage == null
                        ? ''
                        : validationMessage[re.validator]);
              },
              onChanged: (value) {
                if (onChange != null) {
                  onChange(value);
                }
              },
              keyboardType: texType,
              inputFormatters: inputFormatters,
              obscureText: isPassword,
              //style: const TextStyle(fontSize: 12),
              decoration: InputDecoration(
                //label: Text(title),
                hintText: hint,
                /* labelStyle: const TextStyle(fontSize: 14, color: Colors.black), */
                /* floatingLabelStyle:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold), */
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: AppColors.tertiary),
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: AppColors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                isDense: true,
                contentPadding: const EdgeInsets.only(
                    left: 10, bottom: 10, top: 10, right: 10),
              ))
        ],
      ),
    );
  }
}
