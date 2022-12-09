import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../commons/theme/app_color.dart';

class SocialIconButtonWidget extends StatelessWidget {
  final IconData icon;

  final LinearGradient? gradient;
  final Uri url;

  const SocialIconButtonWidget(
      {super.key, required this.icon, this.gradient, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        )) {
          print('Could not launch $url');
        }
      },
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(shape: BoxShape.circle, gradient: gradient),
        child: Center(
            child: Icon(
          icon,
          color: AppColors.white,
          size: 28,
        )),
      ),
    );
  }
}
