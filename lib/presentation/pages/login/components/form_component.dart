import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../commons/theme/app_color.dart';
import '../../../commons/widgets/custom_input/custom_inputs.dart';
import '../../../commons/widgets/custom_input/validators_form.dart';
import '../../../provider/auth_bloc.dart';

class FormComponent extends StatelessWidget {
  const FormComponent({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthBloc>(context, listen: false);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(10),
      height: 345,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 12,
            spreadRadius: 7,
            offset: const Offset(0, 0), // Shadow position
          ),
        ],
      ),
      child: Form(
        key: provider.formLogin,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "Login",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomInputs.entryReactiveTextField(context,
                title: "Username",
                formControlname: provider.username,
                validators: [
                  ValidatorsForm.required(),
                  ValidatorsForm.minLeng(minLenght: 3),
                  ValidatorsForm.maxLeng(maxLenght: 8),
                ],
                validationMessage: {
                  ValidatorsType.required: "Username required",
                  ValidatorsType.minLenght: "Minimun 3 characters",
                  ValidatorsType.maxLenght: "Maximun 8 characters",
                }),
            CustomInputs.entryReactiveTextField(context,
                title: "Password",
                formControlname: provider.password,
                isPassword: true,
                validators: [
                  ValidatorsForm.required(),
                  ValidatorsForm.minLeng(minLenght: 6),
                  ValidatorsForm.regex(
                      regex: RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!+@#\$&*~]).{6,}$')),
                ],
                validationMessage: {
                  ValidatorsType.required: "Password required",
                  ValidatorsType.minLenght: "Minimun 6 characters",
                  ValidatorsType.regex: "Invalid password"
                }),
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: AppColors.tertiary, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
