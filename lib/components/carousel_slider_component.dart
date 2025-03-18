import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../utils/global_images.dart';

class CarouselSliderComponent extends StatelessWidget {
  const CarouselSliderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    // List of image paths for the carous
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
      items: imagePaths.map((path) => Builder(
        builder: (BuildContext context) {
          return Container(
            width: 800.0,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                path,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      )).toList(),
      options: CarouselOptions(
        height: 690.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
      ),
    );
  }
}
