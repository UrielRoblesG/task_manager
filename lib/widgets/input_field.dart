import 'package:flutter/material.dart';

/**
 * Componente que genera un TextField.
 * Muy customizable, 
 */
class InputField extends StatelessWidget {
  final IconData? icon;
  final bool? obscureText;
  final bool isPasswordField;
  final String hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final EdgeInsetsGeometry margin;
  String? Function(String?)? validator;
  final VoidCallback? onChangeVisibility;
  final TextInputType keyboardType;
  final Widget? label;
  final int? maxLines;
  final bool enabled;
  final Widget? suffix;
  final VoidCallback? onTap;
  final String? initialValue;

  InputField(
      {super.key,
      this.controller,
      this.icon,
      this.hintText = '',
      this.obscureText,
      this.isPasswordField = false,
      this.label,
      this.suffix,
      this.maxLines = 1,
      this.enabled = true,
      this.onTap,
      this.initialValue,
      this.margin = const EdgeInsets.symmetric(vertical: 8),
      this.validator,
      this.keyboardType = TextInputType.text,
      this.onChangeVisibility,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: const Color(0xFF000000).withOpacity(0.2),
          offset: const Offset(0, 0),
          blurRadius: 14,
          spreadRadius: -7,
        ),
      ]),
      child: TextFormField(
        controller: controller,
        autocorrect: false,
        style: const TextStyle(color: Colors.black),
        keyboardType: keyboardType,
        obscureText:
            (isPasswordField == false) ? obscureText ?? false : !obscureText!,
        validator: validator,
        initialValue: initialValue,
        maxLines: maxLines,
        onChanged: onChanged,
        onTap: onTap,
        enabled: enabled,
        decoration: InputDecoration(
            suffix: suffix,
            label: label,
            enabled: enabled,
            prefixIcon: (icon != null)
                ? Icon(
                    icon,
                    color: Colors.black,
                  )
                : null,
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            suffixIcon: (isPasswordField)
                ? IconButton(
                    icon: Icon(
                      (obscureText ?? false)
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: Colors.black,
                    ),
                    onPressed: onChangeVisibility,
                  )
                : null,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(25),
            )),
      ),
    );
  }
}
