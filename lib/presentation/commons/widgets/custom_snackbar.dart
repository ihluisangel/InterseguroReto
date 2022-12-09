import 'package:flutter/material.dart';

// ignore: camel_case_types
enum SNACKBAR_TYPE {
  success,
  info,

  error,
  warning
}

class CustomSnackBar {
  static showSnackBar(BuildContext context,
      {SNACKBAR_TYPE type = SNACKBAR_TYPE.success,
      required String title,
      String? subtitle,
      bool dismiss = false}) {
    var snackBar = SnackBar(
      content: Wrap(
        direction: Axis.vertical,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
          if (subtitle != null) Text(subtitle),
        ],
      ),
      backgroundColor: CustomSnackBar._getColorSnack(type),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
      elevation: 30,
      action: dismiss == false
          ? null
          : SnackBarAction(
              label: 'Close',
              disabledTextColor: Colors.white,
              textColor: Colors.yellow,
              onPressed: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                //Do whatever you want
              },
            ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Color _getColorSnack(SNACKBAR_TYPE type) {
    Color color;
    switch (type) {
      case SNACKBAR_TYPE.success:
        color = Colors.teal;
        break;
      case SNACKBAR_TYPE.info:
        color = Colors.blueAccent;
        break;
      case SNACKBAR_TYPE.error:
        color = Colors.redAccent;
        break;
      case SNACKBAR_TYPE.warning:
        color = Colors.yellowAccent;
        break;
      default:
        color = Colors.teal;
    }
    return color;
  }
}
