import 'package:flutter/material.dart';
import 'package:task_manager/ui/app_colors.dart';

/** 
 * Clase con el estilo global de los botones de la app
 */
class ButtonStyles {
  static ButtonStyle simple(
          {Color backgroundColor = const Color(0xFF63d67a),
          Gradient? gradient}) =>
      ElevatedButton.styleFrom();
}
