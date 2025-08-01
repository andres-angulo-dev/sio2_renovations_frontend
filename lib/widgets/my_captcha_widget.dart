import 'package:flutter/material.dart';
import 'package:slider_captcha/slider_captcha.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';

class MyCaptchaWidget extends StatefulWidget {
  final double sizeWidth;
  final SliderController captchaController;
  final ValueChanged<bool> onCaptchaValidated;
  final bool isCaptchaValidated;
  final VoidCallback onCaptchaAttempted;
  final bool hasTriedCaptcha;
  
  const MyCaptchaWidget({
    super.key, 
    this.sizeWidth = 500.0,
    required this.captchaController,
    required this.onCaptchaValidated,
    required this.isCaptchaValidated,
    required this.onCaptchaAttempted,
    required this.hasTriedCaptcha,
  });

  @override
  MyCaptchaWidgetState createState() => MyCaptchaWidgetState();
}

class MyCaptchaWidgetState extends State<MyCaptchaWidget> {

  @override
  Widget build(BuildContext context) {
  bool mobile = GlobalScreenSizes.isMobileScreen(context);

    return Align(
      child: SizedBox(
        width: widget.sizeWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Merci de compléter ce puzzle pour sécuriser votre demande.',
              style: TextStyle(
                fontSize: mobile ? GlobalSize.mobileSizeText : GlobalSize.webSizeText,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12.0),
            SliderCaptcha(
              title: widget.hasTriedCaptcha && !widget.isCaptchaValidated ? 'Échec du captcha – veuillez réessayer' : "Veuillez glisser la pièce du puzzle pour valider le captcha",
              titleStyle: TextStyle(
                color: widget.hasTriedCaptcha ? Colors.red[900] : GlobalColors.secondColor,
              ),
              controller: widget.captchaController,
              image: Image.asset(
                GlobalImages.imageCaptha, 
                fit: BoxFit.fitWidth,
              ),
              colorCaptChar: GlobalColors.thirdColor, // Puzzle
              colorBar: GlobalColors.fourthColor, // Slide bar
              onConfirm: (value) async {
                widget.onCaptchaAttempted();
                widget.onCaptchaValidated(value);
                // Allows to automatically recreate a new captcha puzzle right after an attempt
                if (!value && mounted) {
                  Future.delayed(const Duration(seconds: 1)).then((_) {
                    widget.captchaController.create();
                  });
                }
              },
            ),
            const SizedBox(height: 12.0),
          ]
        ),  
      ),
    );
  }
}
