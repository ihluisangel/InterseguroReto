import 'package:flutter/material.dart';

import 'package:interseguroapp/presentation/pages/login/components/form_component.dart';
import 'package:interseguroapp/presentation/pages/login/components/send_component.dart';

import 'components/social_component.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool remenber = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: SafeArea(
                child: Image.asset(
                  "assets/images/image_header.png",
                ),
              ),
            ),
            Positioned(
              right: 14,
              bottom: 0,
              child: Image.asset("assets/images/image_footer.png"),
            ),
            GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(context),
                  const SizedBox(
                    height: 90,
                  ),
                  Expanded(
                      flex: 10,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildForm(context),
                            _buildSectionSend(context),
                            const SizedBox(
                              height: 10,
                            ),
                            _buildSocialButtons(context)
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ],
        ));
  }

  _buildHeader(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        children: [
          Image.asset("assets/images/logo.png"),
          Text(
            "Interseguro",
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    ));
  }

  _buildForm(BuildContext context) {
    return const FormComponent();
  }

  _buildSectionSend(BuildContext context) {
    return const SendConponent();
  }

  _buildSocialButtons(BuildContext context) {
    return const SocialComponent();
  }
}
