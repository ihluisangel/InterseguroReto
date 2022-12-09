// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import '../theme/app_color.dart';

enum BUTTON_COLORS {
  primary,
  secondary,
  tertiary,
  cuaternary,
  gradient,
  gradient2
}

enum BUTTON_SIZE { small, medium, large }

enum POSITION_ICON { right, left }

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed; // no usar function ya que se llama al compilar

  final String text;
  final TextStyle? textStyle;
  final BUTTON_COLORS color;
  final bool? outline;
  final IconData? icon;

  final BUTTON_SIZE size;
  final POSITION_ICON positionIcon;
  final Image? imageIcon;

  const CustomButton(
      {Key? key,
      required this.onPressed,
      this.color = BUTTON_COLORS.primary,
      required this.text,
      this.icon,
      this.textStyle,
      this.size = BUTTON_SIZE.medium,
      this.outline,
      this.positionIcon = POSITION_ICON.right,
      this.imageIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color col = AppColors.primary;
    double h = 40.0; //40 medium, 50 large, 20, small
    double iconSize = 20;
    double fontSize = 12;
    EdgeInsets padding =
        const EdgeInsets.symmetric(horizontal: 20, vertical: 0);
    switch (size) {
      case BUTTON_SIZE.large:
        h = 70;
        iconSize = 25;
        fontSize = 20;
        break;
      case BUTTON_SIZE.small:
        h = 30;
        iconSize = 15;
        fontSize = 10;
        break;
      case BUTTON_SIZE.medium:
        h = 40;
        iconSize = 24;
        fontSize = 12;
        break;
      default:
    }

    switch (color) {
      case BUTTON_COLORS.primary:
        col = Theme.of(context).primaryColor;

        break;
      case BUTTON_COLORS.secondary:
        col = Theme.of(context).colorScheme.secondary;

        break;
      case BUTTON_COLORS.tertiary:
        col = AppColors.tertiary;

        break;
      case BUTTON_COLORS.cuaternary:
        col = AppColors.cuaternary;
        break;
      default:
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.black12,
        onTap: () {
          onPressed();
        },
        child: Ink(
          //width: double.infinity,
          padding: padding,
          decoration: BoxDecoration(
            border: Border.all(
                width: color == BUTTON_COLORS.gradient ? 0 : 1, color: col),
            gradient: color == BUTTON_COLORS.gradient
                ? const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: (color == BUTTON_COLORS.gradient)
                ? null
                : (outline == true ? Colors.white : col),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
              height: h,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null && positionIcon == POSITION_ICON.left)
                    Icon(icon,
                        color: outline == null ? Colors.white : col,
                        size: iconSize),
                  if (icon != null && positionIcon == POSITION_ICON.left)
                    const SizedBox(width: 5),
                  if (imageIcon != null)
                    Container(
                      height: iconSize,
                      margin: const EdgeInsets.only(right: 5),
                      child: imageIcon,
                    ),
                  Text(text,
                      style: textStyle ??
                          TextStyle(
                              color: outline == null ? Colors.white : col,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize)),
                  if (icon != null && positionIcon == POSITION_ICON.right)
                    const SizedBox(width: 5),
                  if (icon != null && positionIcon == POSITION_ICON.right)
                    Icon(icon,
                        color: outline == null ? Colors.white : col,
                        size: iconSize),
                ],
              )),
        ),
      ),
    );
  }
}
