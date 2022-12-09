import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../commons/state_enum.dart';
import '../../../commons/widgets/custom_button.dart';
import '../../../commons/widgets/custom_snackbar.dart';
import '../../../provider/auth_bloc.dart';
import '../../home/home_screen.dart';

class SendConponent extends StatefulWidget {
  const SendConponent({super.key});

  @override
  State<SendConponent> createState() => _SendConponentState();
}

class _SendConponentState extends State<SendConponent> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthBloc>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                provider.changeRemember();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Consumer<AuthBloc>(builder: (context, provider, child) {
                      if (provider.isRemember == true) {
                        return const Icon(Icons.radio_button_checked);
                      } else {
                        return const Icon(Icons.radio_button_unchecked);
                      }
                    }),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Remember me")
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<AuthBloc>(builder: (context, provider, child) {
              if (provider.userState == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return CustomButton(
                    color: BUTTON_COLORS.gradient,
                    size: BUTTON_SIZE.large,
                    onPressed: () {
                      if (!provider.formLogin.currentState!.validate()) {
                        return;
                      }
                      _pressLogin(context);
                    },
                    text: "SINGIN");
              }
            }),
          )
        ],
      ),
    );
  }

  _pressLogin(BuildContext context) async {
    FocusScope.of(context).unfocus();
    var provider = Provider.of<AuthBloc>(context, listen: false);

    await provider.login();

    if (provider.userState == RequestState.loaded) {
      if (!mounted) return;
      provider.username.clear();
      provider.password.clear();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    }
    if (provider.userState == RequestState.error) {
      if (!mounted) return;
      CustomSnackBar.showSnackBar(context,
          title: provider.message, type: SNACKBAR_TYPE.error);
    }
  }
}
