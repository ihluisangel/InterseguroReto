import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class AppTheme {
  const AppTheme();

  static TextTheme _buildTextTheme(TextTheme base) {
    final b = GoogleFonts.nunitoSansTextTheme(base);
    return b;
  }

  static ThemeData buildLightTheme() {
    const Color primaryColor = AppColors.primary;
    Color secondaryColor = AppColors.secondary;
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: AppColors.tertiary);
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      // ignore: deprecated_member_use
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      // ignore: deprecated_member_use
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      backgroundColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.white,

      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      appBarTheme: const AppBarTheme(
          elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.light),

      textTheme: _buildTextTheme(
        base.textTheme, // If this is not set, then ThemeData.light().textTheme is used.
      ),
      primaryTextTheme: _buildTextTheme(
        base.primaryTextTheme,
        // If this is not set, then ThemeData.light().textTheme is used.
      ),
      platform: TargetPlatform.iOS,
    );
  }
}
