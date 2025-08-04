// 4 dots version with wave + rebound effect
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/global_colors.dart';

class DotLoaderWidget extends StatefulWidget {
  const DotLoaderWidget({super.key});

  @override
  DotLoaderWidgetState createState() => DotLoaderWidgetState();
}

class DotLoaderWidgetState extends State<DotLoaderWidget> with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;
  late Timer _timer;

  int activeIndex = 0;

  @override
  void initState() {
    super.initState();

    // Animation controller for bounce effect
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..repeat();

    // Cyclic timer to change the active index every Xms
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (!mounted) return;
      setState(() {
        activeIndex = (activeIndex + 1) % 4; // Creation of a cyclic infinite loop
      });
    });
    
  }

  @override  
  void dispose() {
    _bounceController.dispose();
    _timer.cancel();
    super.dispose();
  }

  Widget buildDot(int index) {
    final isActive = index == activeIndex;
    
    return AnimatedBuilder(
      animation: _bounceController, 
      builder: (_, __) {
        final bounce = isActive ? sin(_bounceController.value * pi) * -6 : 0.0; // Create a smooth bounce by animating the vertical position of a circle 

        return Transform.translate(
          offset: Offset(0, bounce),
           child: Container(
            height: 30.0,
            width: 60.0,
            padding: EdgeInsets.all(4.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: isActive ? 14.0 : 10.0,
                width: isActive ? 14.0 : 10.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive
                      ? GlobalColors.orangeColor
                      : GlobalColors.fourthColor.withValues(alpha: 0.4),
                ),
              ),
            )
           ) 
        );
      }
    );
  }     
  

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 350.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, buildDot),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Envoi du message en cours...',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    ); 
  }
}





// // 3 dots version with wave effect
// import 'dart:async';
// import 'package:flutter/material.dart';
// import '../utils/global_colors.dart';

// class DotLoaderWidget extends StatefulWidget {
//   const DotLoaderWidget({super.key});

//   @override
//   State<DotLoaderWidget> createState() => _DotLoaderWidgetState();
// }

// class _DotLoaderWidgetState extends State<DotLoaderWidget> {
//   int activeIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     // Cyclic timer to change the active index every Xms
//     Timer.periodic(const Duration(milliseconds: 300), (timer) {
//       setState(() {
//         activeIndex = (activeIndex + 1) % 3; // Creation of a cyclic infinite loop
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(3, (index) {
//             final isActive = index == activeIndex;
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 4.0),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 height: isActive ? 14.0 : 10.0,
//                 width: isActive ? 14.0 : 10.0,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: isActive
//                       ? GlobalColors.fourthColor
//                       : GlobalColors.fourthColor.withValues(alpha: 0.4),
//                 ),
//               ),
//             );
//           }),
//         ),
//         const SizedBox(height: 16.0),
//         const Text(
//           'Envoi du message en cours...',
//           style: TextStyle(fontSize: 16.0),
//         ),
//       ],
//     );
//   }
// }


