import 'package:flutter/material.dart';
import 'package:task_manager/ui/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: AppColors.strongGreen(),
        ),
      ),
    );
  }
}