import 'package:flutter/material.dart';
import 'package:interseguroapp/commons/state_enum.dart';

import 'package:interseguroapp/presentation/commons/theme/app_color.dart';
import 'package:interseguroapp/presentation/provider/auth_bloc.dart';
import 'package:provider/provider.dart';

import '../login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AuthBloc>(context, listen: false).getIsRemeber();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Interseguro",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                var provider = Provider.of<AuthBloc>(context, listen: false);
                await provider.getOnlogout();
                if (provider.logoutState == RequestState.loaded) {
                  if (!mounted) return;
                  provider.resetIsRemember();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                }
              },
              icon: const Icon(Icons.logout))
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[AppColors.primary, AppColors.secondary])),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Empleado logueado:"),
            Consumer<AuthBloc>(builder: (context, provider, child) {
              if (provider.user == null) {
                return const Text("--");
              } else {
                return Text(provider.user!.name);
              }
            }),
            const SizedBox(
              height: 20,
            ),
            const Text("¿Mantener sesion iniciada?"),
            Consumer<AuthBloc>(builder: (context, provier, child) {
              return Text(provier.isRemember.toString());
            }),
          ],
        ),
      ),
    );
  }
}
