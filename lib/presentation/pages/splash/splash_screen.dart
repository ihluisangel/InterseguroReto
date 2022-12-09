import 'package:flutter/material.dart';
import 'package:interseguroapp/commons/state_enum.dart';
import 'package:interseguroapp/presentation/pages/home/home_screen.dart';
import 'package:interseguroapp/presentation/provider/auth_bloc.dart';
import 'package:provider/provider.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<AuthBloc>(context, listen: false)
          .onGetUser()
          .whenComplete(() => _toPage());
    });
    super.initState();
  }

  _toPage() async {
    var provider = Provider.of<AuthBloc>(context, listen: false);
    await Future.delayed(const Duration(milliseconds: 100));
    if (provider.userState == RequestState.error) {
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    } else {
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}
