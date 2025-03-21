import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../utils/global_images.dart';

class CarouselSliderComponent extends StatelessWidget {
  const CarouselSliderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    // List of image paths for the carousel, dynamically provided from GlobalImages utility
    final List<String> imagePaths = [
      GlobalImages.image1,
      GlobalImages.image2,
      GlobalImages.image3,
      GlobalImages.image4,
      GlobalImages.image5,
      GlobalImages.image6,
      GlobalImages.image7,
      GlobalImages.image8,
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
