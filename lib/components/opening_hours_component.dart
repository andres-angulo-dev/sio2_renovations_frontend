import 'package:flutter/material.dart';
import '../utils/global_others.dart';
import '../utils/global_colors.dart';

class OpeningHoursComponent extends StatelessWidget{
  const OpeningHoursComponent({
    super.key,
    this.mainAxisPosition = MainAxisAlignment.start,
    this.crossAxisPosition = CrossAxisAlignment.start,
  });

  final MainAxisAlignment mainAxisPosition;
  final CrossAxisAlignment crossAxisPosition;

  @override   
  Widget build(BuildContext context) {

    final List<Map<String, String>> scheduleData = [
      {"day": "Lun - Ven", "hour": "9h - 18h"},
      {"day": "Sam", "hour": "10h - 18h"},
      {"day": "Dim", "hour": "Fermé"},
    ];
      
    return 
    Column(
      crossAxisAlignment: crossAxisPosition,
      children: [
        Text(
          "Heures d'ouverture",
          style: TextStyle(
            fontSize: GlobalSize.footerWebTitle,
            fontWeight: FontWeight.bold,
            color: GlobalColors.firstColor,
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          height: 1,
          width: 350.0,
          color: GlobalColors.firstColor,
        ),
        const SizedBox(height: 20.0),
        Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(scheduleData.length, (index) { // Generating each element to be displayed
            final item = scheduleData[index]; // Each element

            return Column(
              children: [
                Row(
                  mainAxisAlignment: mainAxisPosition,
                  children: [
                    const SizedBox(width: 4.0),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 1.5, horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: GlobalColors.orangeColor,
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        item["day"]!,
                        style: TextStyle(
                          color: GlobalColors.firstColor,
                          fontSize: GlobalSize.footerWebText,
                        )
                      )
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      item["hour"]!,
                      style: TextStyle(
                        color: GlobalColors.firstColor,
                        fontSize: GlobalSize.footerWebText,
                      )
                    ),
                  ],
                ),
                if (index < scheduleData.length - 1) const SizedBox(height: 4.0), // Adds spacing except after the last element
              ],
            );
          })
        )
      ],
    );
  }
}