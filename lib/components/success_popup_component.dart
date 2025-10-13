// Design : more personalized with SliderCaptcha and animation success
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:slider_captcha/slider_captcha.dart';
import '../widgets/my_captcha_widget.dart';
import '../widgets/my_dot_loader_widget.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';

class SuccessPopupComponent extends StatefulWidget {
  final VoidCallback resetForm; // Callback to reset the form
  final VoidCallback? launchSendingMessage;
  final Function(bool) setIsSending;
  final ValueNotifier<bool> isMessageSendingValidated;
  
  const SuccessPopupComponent({
    super.key, 
    required this.resetForm,
    this.launchSendingMessage,
    required this.setIsSending,
    required this.isMessageSendingValidated,
  });

  @override
  SuccessPopupComponentState createState() => SuccessPopupComponentState();
}

class SuccessPopupComponentState extends State<SuccessPopupComponent> {
  // Controller used to regenerate the captcha (SliderCaptcha.create())
  final SliderController _captchaController = SliderController(); 
  bool _isCaptchaValidated = false; // Successfully solves the puzzle
  bool _hasTriedCaptcha = false;  // Interacts with the slider (even if incorrect)
  Timer? _autoCloseTimer;
  final ValueNotifier<bool> _hasTimeOut = ValueNotifier(false);


  void _startAutoCloseTimer() {
    _autoCloseTimer = Timer(const Duration(seconds: 7), () {
      if (!widget.isMessageSendingValidated.value) {
        _hasTimeOut.value = true;
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            Navigator.of(context).pop(false);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _autoCloseTimer?.cancel();
    super.dispose();
  }    
   
  @override
  Widget build(BuildContext context) {
    final maxWidth = GlobalScreenSizes.screenWidth(context) * 0.5;
    bool isMobile = GlobalScreenSizes.isMobileScreen(context);
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
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
                      // Allows to display the captcha or the success animation
                      _isCaptchaValidated = value;
                      // Hide error if validation succeeded
                      if (value) _hasTriedCaptcha = false; // Hide the captcha error
                    });

                    // When the captcha is validated it returns true and allows calling ContactFormService.submitContactForm in the parent ContactScreen
                    if (value) {
                      widget.launchSendingMessage?.call();
                      _startAutoCloseTimer();
                    } 
                  },
                  onCaptchaAttempted: () { // The child returns TRUE if an attempt has been made
                    // Display the error if validation not succeeded
                    setState(() {
                      _hasTriedCaptcha = true; // Display the captcha error
                    });
                  },
                  hasTriedCaptcha: _hasTriedCaptcha,
                  setIsSending: widget.setIsSending,
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
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                      ),
                      onPressed: () async{
                        Navigator.of(context).pop(false);  // Close the popup and send to the parent 'false'
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
              ],
              // Success 
              ValueListenableBuilder(
                valueListenable: widget.isMessageSendingValidated, 
                builder: (context, validated, _) {
                  if (_isCaptchaValidated && validated) {
                    return Container(
                      constraints: BoxConstraints(maxHeight: isMobile ? 450.0 : 350.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          // Animation
                          SizedBox(
                            height: 150.0,
                            child: Lottie.asset(
                              GlobalImages.successAnimation,
                              repeat: false,
                              animate: true,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          // Title
                          Text(
                            'Succès !',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          // Message
                          Text(
                            'Votre message a bien été envoyé.\n'
                            'Vous recevrez une copie de votre message dans votre boîte mail dans quelques instants.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          const Spacer(),
                          // Close button
                          Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              width: 100.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: GlobalColors.fourthColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                                ),
                                onPressed: () async{
                                  widget.resetForm(); // Call the parent’s resetForm() callback for reset the form when OK is pressed
                                  Navigator.of(context).pop(true);  // Close the popup and send to the parent 'true'
                                },
                                child: const Text(
                                  'Fermer',
                                  style: TextStyle(
                                    color: GlobalColors.secondColor,
                                    fontSize: 16.0, 
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ), 
                          )
                        ],
                      )
                    ); 
                  } else if (_isCaptchaValidated && !validated) {
                    return DotLoaderWidget(
                      hasTimeOut: _hasTimeOut,
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }
              )
            ]
          ),
        ),
      ),
    );
  }
}