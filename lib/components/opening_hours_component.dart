import 'package:flutter/material.dart';
import '../utils/global_others.dart';
import '../utils/global_colors.dart';
import '../utils/global_screen_sizes.dart';

class OpeningHoursComponent extends StatelessWidget{
  const OpeningHoursComponent({
    super.key,
    this.mainAxisPosition = MainAxisAlignment.start,
    this.crossAxisPosition = CrossAxisAlignment.start,
    this.mobileTitleSize = GlobalSize.footerMobileTitle,
    this.webTitleSize = GlobalSize.footerWebTitle,
    this.mobileTextSize = GlobalSize.footerMobileText,
    this.webTextSize = GlobalSize.footerWebText,
    this.widthDivider = 350.0,
    this.heightDivider = 1.0,
    this.color = GlobalColors.firstColor,
    this.squareColor = GlobalColors.orangeColor,
    this.responsiveThreshold,
  });

  final MainAxisAlignment mainAxisPosition;
  final CrossAxisAlignment crossAxisPosition;
  final double mobileTitleSize;
  final double webTitleSize;
  final double mobileTextSize;
  final double webTextSize;
  final double widthDivider;
  final double heightDivider;
  final Color color;
  final Color squareColor;
  final double? responsiveThreshold;

  @override   
  Widget build(BuildContext context) {
    final bool mobile = responsiveThreshold == null  ? GlobalScreenSizes.isMobileScreen(context) : GlobalScreenSizes.isCustomSize(context, responsiveThreshold!);

    final List<Map<String, String>> scheduleData = [
      {"day": "Lun - Ven", "hour": "9h - 18h"},
      {"day": "Sam", "hour": "10h - 18h"},
      {"day": "Dim", "hour": "Fermé"},
    ];
      
    return 
    Column(
      crossAxisAlignment: mobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          "Heures d'ouverture",
          style: TextStyle(
            fontSize: mobile ? mobileTitleSize : webTitleSize,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: mobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 6.0),
        Container(
          height: heightDivider,
          width: widthDivider,
          color: color,
        ),
        const SizedBox(height: 20.0),
        Column (
          crossAxisAlignment: mobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: List.generate(scheduleData.length, (index) { // Generating each element to be displayed
            final item = scheduleData[index]; // Each element

            return Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (!mobile) const SizedBox(width: 4.0),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 1.5, horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: squareColor,
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        item["day"]!,
                        style: TextStyle(
                          color: color,
                          fontSize: mobile ? mobileTextSize : webTextSize,
                        )
                      )
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      item["hour"]!,
                      style: TextStyle(
                        color: color,
                        fontSize: mobile ? mobileTextSize : webTextSize,
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