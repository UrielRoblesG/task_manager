import 'package:flutter/material.dart';
import 'package:task_manager/ui/app_colors.dart';

/**
 * Componente que solo genera un Circular progress indicator
 */
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
