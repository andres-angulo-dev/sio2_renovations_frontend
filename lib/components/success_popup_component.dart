// Design : more personalized wit animation
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/global_colors.dart';
import '../utils/global_screen_sizes.dart';
class SuccessPopupComponent extends StatelessWidget {
  final VoidCallback resetForm; // Callback to reset the form
   
  const SuccessPopupComponent({super.key, required this.resetForm,});

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
              // Button
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
                    onPressed: () {
                      resetForm(); // Call the parent’s resetForm() callback for reset the form when OK is pressed.
                      Navigator.of(context).pop(true);  // Close the popup and send to the parent 'true'
                    },
                    child: const Text(
                      'OK',
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
          ),
        ),
      ),
    );
  }
}




// // Design : with simple AlertDialog
// import 'package:flutter/material.dart';
//
// class SuccessPopupComponent extends StatelessWidget {
//   // final VoidCallback onOkPressed; // Callback for the OK button press.
//   final VoidCallback resetForm; // Callback to reset the form

//   const SuccessPopupComponent({ super.key, required this.resetForm });

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       // Title of the dialog.
//       title: Row(
//         children: [
//           const Icon(Icons.check_circle, color: Colors.green),
//           const SizedBox(width: 8),
//           const Text('Succès'),
//         ],
//       ),
//       // Message content of the dialog.
//       content: Semantics(
//         label: 'Confirmation d’envoi de message',
//         child: Text('Votre message a bien été envoyé !'),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             resetForm(); // Call the parent’s resetForm() callback for reset the form when OK is pressed.
//             Navigator.of(context).pop(true); // Close the popup and send to the parent 'true'
//             // Navigator.of(context).pushReplacement(
//             //   MaterialPageRoute(
//             //     builder: (context) => const ContactScreen(), // Navigate to ContactScreen.
//             //   ),
//             // );
//           }, 
//           child: const Text('OK'), // Label for the button.
//         ),
//       ],
//     );
//   }
// }
