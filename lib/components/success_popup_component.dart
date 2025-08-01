// Design : more personalized with SliderCaptcha and animation success
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:slider_captcha/slider_captcha.dart';
import '../widgets/my_captcha_widget.dart';
import '../utils/global_colors.dart';
import '../utils/global_screen_sizes.dart';

class SuccessPopupComponent extends StatefulWidget {
  final VoidCallback resetForm; // Callback to reset the form
  
  const SuccessPopupComponent({
    super.key, 
    required this.resetForm,
  });

  @override
  SuccessPopupComponentState createState() => SuccessPopupComponentState();
}

class SuccessPopupComponentState extends State<SuccessPopupComponent> {
  // Controller used to regenerate the captcha (SliderCaptcha.create())
  final SliderController _captchaController = SliderController(); 
  bool _isCaptchaValidated = false; // Successfully solves the puzzle
  bool _hasTriedCaptcha = false;  // Interacts with the slider (even if incorrect)

  @override
  Widget build(BuildContext context) {
    final maxWidth = GlobalScreenSizes.screenWidth(context) * 0.5;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      elevation: 0,
      backgroundColor: Colors.white,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Captcha
              if (!_isCaptchaValidated) ...[
                MyCaptchaWidget(
                  captchaController: _captchaController,
                  isCaptchaValidated: _isCaptchaValidated,
                  onCaptchaValidated: (value) {  // The child returns true when the puzzle is completed and changes variables
                    setState(() {
                      _isCaptchaValidated = value;
                      // Hide error if validation succeeded
                      if (value) _hasTriedCaptcha = false; // When he tried he did not succeed
                    });
                  },
                  onCaptchaAttempted: () { // The child returns TRUE if an attempt has been made.
                    // Display the error if validation not succeeded
                    setState(() {
                      _hasTriedCaptcha = true; // Display the captcha error
                    });
                  },
                  hasTriedCaptcha: _hasTriedCaptcha,
                ),
               // Close button
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 100.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalColors.fourthColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () async{
                        Navigator.of(context).pop(false);  // Close the popup and send to the parent 'true'
                      },
                      child: const Text(
                        'Retour',
                        style: TextStyle(
                          color: GlobalColors.secondColor,
                          fontSize: 16, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ), 
                )
              ]
              // Success 
              else ...[
                // Animation
                SizedBox(
                  height: 150,
                  child: Lottie.asset(
                    'assets/success.json',
                    repeat: false,
                    animate: true,
                  ),
                ),
                const SizedBox(height: 16),
                // Title
                Text(
                  'Succès !',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 8),
                // Message
                Text(
                  'Votre message a bien été envoyé.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 24),
                // Close button
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 100.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalColors.fourthColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () async{
                        widget.resetForm(); // Call the parent’s resetForm() callback for reset the form when OK is pressed.
                        Navigator.of(context).pop(true);  // Close the popup and send to the parent 'true'
                      },
                      child: const Text(
                        'Fermer',
                        style: TextStyle(
                          color: GlobalColors.secondColor,
                          fontSize: 16, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ), 
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}