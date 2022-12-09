import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/commons/theme/theme.dart';
import 'presentation/pages/splash/splash_screen.dart';

import 'injection.dart' as di;
import 'presentation/provider/auth_bloc.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<AuthBloc>(),
        ),
      ],
      child: MaterialApp(
          title: 'Interseguro App',
          theme: AppTheme.buildLightTheme(),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen()),
    );
  }
}
