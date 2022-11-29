import 'package:flutter/material.dart';

class CategoryValuesWithBar extends StatelessWidget {
  final double spaceWidth;
  final double barWidth;
  final double barHeight;
  final Color barColor;

  final String categoryName;
  final double categoryFontSize;
  final Color categoryFontColor;
  final String values;
  final double valueFontSize;
  final Color valueFontColor;

  CategoryValuesWithBar(
      this.spaceWidth,
      this.barWidth,
      this.barHeight,
      this.barColor,
      this.values,
      this.valueFontSize,
      this.valueFontColor,
      this.categoryName,
      this.categoryFontSize,
      this.categoryFontColor
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget> [
        SizedBox(width: spaceWidth),
        Container(
          width: barWidth,
          height: barHeight,
          color: barColor,
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              values,
              style: TextStyle(
                fontFamily: "IBM",
                color: valueFontColor,
                fontSize: valueFontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              categoryName,
              style: TextStyle(
                fontFamily: "IBM",
                color: categoryFontColor,
                fontSize: categoryFontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )
      ],
    );
  }
}
