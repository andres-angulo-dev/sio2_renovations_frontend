import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../utils/global_others.dart';

class CarouselSliderComponent extends StatelessWidget {
  const CarouselSliderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    // List of image paths for the carousel, dynamically provided from GlobalImages utility
    final List<String> imagePaths = [
      GlobalOthers.image1,
      GlobalOthers.image2,
      GlobalOthers.image3,
      GlobalOthers.image4,
      GlobalOthers.image5,
      GlobalOthers.image6,
      GlobalOthers.image7,
      GlobalOthers.image8,
    ];

    return CarouselSlider(
      // Map each image path to a Container with design and display logic
      items: imagePaths.map((path) => Builder(
        builder: (BuildContext context) {
          return Container(
            width: 800.0, // Fixed width for the carousel items
            margin: const EdgeInsets.symmetric(horizontal: 5.0), // Horizontal spacing between items
            decoration: BoxDecoration(
              color: Colors.transparent, // Background color set to transparent
              borderRadius: BorderRadius.circular(10.0), // Rounded corners for the container
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0), // Ensures image corners match container radius
              child: Image.asset(
                path, // Load the image asset dynamically
                fit: BoxFit.cover, // Ensure image covers the container without distortion
              ),
            ),
          );
        },
      )).toList(), // Convert the mapped widgets into a list
      options: CarouselOptions(
        height: 690.0, // Height of the carousel
        autoPlay: true, // Automatically cycle through images
        autoPlayInterval: const Duration(seconds: 3), // Duration before switching to the next image
        enlargeCenterPage: true, // Highlight the image in the center of the carousel
        aspectRatio: 16 / 9, // Aspect ratio for the images
      ),
    );
  }
}
