import 'package:dlsu_grade_calculator/global_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<TextEditingController> tabOneCourseControllers = [];
List<TextEditingController> tabOneUnitControllers = [];
List<TextEditingController> tabOneGradeControllers = [];

List<TextEditingController> tabTwoCategoryControllers = [];
List<TextEditingController> tabTwoWeightControllers = [];
List<TextEditingController> tabTwoGradeControllers = [];

Widget roundedButton(String? text, Color? color, double? radius,
    TextStyle? textStyle, double? width, double? height, Function? function) {
  text ??= "Add";
  color ??= primaryColor;
  radius ??= 8;
  textStyle ??= primaryStyle(16, Colors.white, FontWeight.w500);

  return Material(
    color: color,
    borderRadius: BorderRadius.circular(radius),
    child: InkWell(
      hoverColor: tertiaryColor,
      onTap: () {
        if (function == null) {
          print("no function");
        } else {
          function();
        }
      },
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    ),
  );
}
