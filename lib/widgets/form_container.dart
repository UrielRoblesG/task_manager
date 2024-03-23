import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const FormContainer(
      {super.key,
      required this.height,
      required this.width,
      this.child = const SizedBox(),
      this.margin = const EdgeInsets.symmetric(horizontal: 24),
      this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 16)});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        padding: padding,
        height: height,
        width: width,
        child: child);
  }
}
