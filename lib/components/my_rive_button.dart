import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class MyRiveButton extends StatefulWidget {
  const MyRiveButton({
  super.key,
  this.enableCursor = true,
  this.onPressed, 
  required this.buttonPath,
  });

  final bool enableCursor; // enable cursor click 
  final VoidCallback? onPressed; // Callback for the button tap event
  final String buttonPath; // Path to the Rive animation file

  @override
  MyRiveButtonState createState() => MyRiveButtonState();
}

class MyRiveButtonState extends State<MyRiveButton> {
  late StateMachineController _controller; // Controller for the State Machine in Rive
  late SMIInput<bool> _isHovered; // Input to track hover state
  bool _isLoaded = false; 

  @override
  void initState() {
    super.initState();
    _loadRiveFile(); // Loads the Rive file and configures the State Machine
  }

  void _loadRiveFile() {
    rootBundle.load(widget.buttonPath).then((data) {
      // Import the Rive file from assets
      final file = RiveFile.import(data);
      // Get the main Artboard from the imported file
      final artboard = file.mainArtboard;
      // Initialize the State Machine Controller using the State Machine name
      final tempController = StateMachineController.fromArtboard(
        artboard,
        'StateMachine1', // Name of State Machine
      );

      // Verif if the controller was created
      if (tempController != null) {
        // Assign the controller and add it to the Artboard
        _controller = tempController;
        artboard.addController(_controller); // Attach the controller to the artboard
        // Retrieve the hover input from the State Machine
        _isHovered = _controller.findInput<bool>('isHovered')!;
        setState(() {
          _isLoaded = true; // Mark as loaded and ready
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Display a placeholder while the animation is loading
    if (!_isLoaded) {
      return const SizedBox(); // Placeholder while loading (can be a spinner)
    }

    return MouseRegion(
      cursor: widget.enableCursor ? SystemMouseCursors.click : MouseCursor.defer,
      // Triggered when the mouse enters the button area
      onEnter: (_) {
        setState(() {
          _isHovered.value = true; // Activate hover animation
        });
      },
      // Triggered when the mouse exits the button area
      onExit: (_) {
        setState(() {
          _isHovered.value = false; // Deactivate hover animation
        });
      },
      child: GestureDetector(
        onTap: widget.onPressed, // Executes the action on button click
        child: SizedBox(
          height: 100, // Button height
          width: 150, // Button width
          child: Rive(
            artboard: _controller.artboard!, // Displays the Rive animation
          ),
        ),
      ),
    );
  }
}





// // Interactive Hover and Tap Button with Rive Animation and Dynamic Scaling in Flutter
// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart';

// class MyRiveButton extends StatefulWidget {
//   const MyRiveButton({
//     super.key, 
//     required this.onPressed, // Callback for what happens when the button is pressed
//     required this.buttonPath, // Path to the Rive animation file
//   });

//   final VoidCallback onPressed; // Allows passing a function to handle button tap
//   final String buttonPath; // Stores the location of the Rive file being used

//   @override  
//   MyRiveButtonState createState() => MyRiveButtonState(); // Creates the state for this widget
// }

// class MyRiveButtonState extends State<MyRiveButton> {
//   double _scale = 1.0; // Tracks the scaling of the button (default size)

//   @override   
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       // Detects when the mouse enters or exits the button area
//       cursor: SystemMouseCursors.click, // Sets the cursor to a "click" pointer style
//       onEnter: (_) { // Triggered when the mouse enters the button area
//         setState(() {
//           _scale = 1.05; // Slightly enlarges the button (scale factor: 105%)
//         });
//       },
//       onExit: (_) { // Triggered when the mouse exits the button area
//         setState(() {
//           _scale = 1.0; // Resets the button scale back to normal (100%)
//         });
//       },
//       child: GestureDetector(
//         // Detects taps on the button
//         onTap: widget.onPressed, // Executes the provided callback function when tapped
//         child: AnimatedContainer(
//           // Animates changes to its size or transform smoothly
//           duration: const Duration(milliseconds: 150), // Defines animation duration
//           transform: Matrix4.identity()..scale(_scale), // Applies scaling transformation based on _scale
//           child: Stack(
//             // Allows layering of child widgets
//             alignment: Alignment.center, // Centers all children in the stack
//             children: [
//               SizedBox(
//                 // Specifies the size of the button
//                 height: 100, // Height of the button
//                 width: 150, // Width of the button
//                 child: RiveAnimation.asset(
//                   widget.buttonPath, // Loads the Rive animation file from the provided path
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
