import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle buttonStyle(
          {FontWeight fontWeight = FontWeight.w400,
          double fontSize = 20,
          Color color = Colors.black}) =>
      TextStyle(fontWeight: fontWeight, fontSize: fontSize, color: color);

  static TextStyle cardTitle(
          {FontWeight fontWeight = FontWeight.w500,
          double fontSize = 25,
          TextOverflow overflow = TextOverflow.clip}) =>
      TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: Colors.black,
          overflow: overflow);
  static TextStyle cardDescription(
          {FontWeight fontWeight = FontWeight.w400,
          double fontSize = 18,
          TextOverflow overflow = TextOverflow.ellipsis}) =>
      TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        overflow: overflow,
        color: Colors.grey.shade700,
      );
}
