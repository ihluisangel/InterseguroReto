import 'package:flutter/material.dart';

import '../../../commons/theme/app_color.dart';
import '../../../commons/utils/custom_icons.dart';
import '../widgets/social_icon_button_widget.dart';

class SocialComponent extends StatelessWidget {
  const SocialComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _divider(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Social Login",
                style: TextStyle(fontSize: 17),
              ),
            ),
            _divider()
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialIconButtonWidget(
                icon: CustomSocialIcons.facebook,
                gradient: const LinearGradient(
                  colors: [AppColors.faceDarkBlue, AppColors.faceLightCyan],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                url: Uri.parse('https://web.facebook.com/')),
            SocialIconButtonWidget(
                icon: CustomSocialIcons.google,
                gradient: const LinearGradient(
                  colors: [AppColors.googleDarkRed, AppColors.googleLightRed],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                url: Uri.parse('https://www.google.com')),
            SocialIconButtonWidget(
                icon: CustomSocialIcons.twitter,
                gradient: const LinearGradient(
                  colors: [
                    AppColors.twitterLightCyan,
                    AppColors.twitterDartCyan
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                url: Uri.parse('https://www.twitter.com')),
            SocialIconButtonWidget(
                icon: CustomSocialIcons.linkedin,
                gradient: const LinearGradient(
                  colors: [AppColors.inLightCyan, AppColors.inDarkCyan],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                url: Uri.parse('https://www.linkedin.com')),
          ],
        )
      ],
    );
  }

  _divider() {
    return Container(
      height: 2,
      width: 90,
      color: Colors.grey,
    );
  }
}
