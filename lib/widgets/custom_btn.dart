import 'package:flutter/material.dart';
import 'package:task_manager/ui/app_colors.dart';

class CustomBtn extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback onPressed;
  final Widget child;
  const CustomBtn(
      {super.key,
      this.borderRadius,
      required this.child,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final br = borderRadius ?? BorderRadius.circular(20);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: br,
          gradient: LinearGradient(
              colors: [AppColors.strongGreen(), AppColors.lightGreen()])),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: br)),
          onPressed: onPressed,
          child: child),
    );
  }
}
