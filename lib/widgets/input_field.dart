import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData icon;
  final bool obscureText;
  final bool isPasswordField;
  final String hintText;
  final EdgeInsetsGeometry margin;
  String? Function(String?)? validator;
  final VoidCallback? onChangeVisibility;
  final TextInputType keyboardType;

  InputField(
      {super.key,
      required this.icon,
      this.hintText = '',
      this.obscureText = false,
      this.isPasswordField = false,
      this.margin = const EdgeInsets.symmetric(vertical: 8),
      this.validator,
      this.keyboardType = TextInputType.text,
      this.onChangeVisibility});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: const Color(0xFF000000).withOpacity(0.2),
          offset: Offset(0, 0),
          blurRadius: 14,
          spreadRadius: -7,
        ),
      ]),
      child: TextFormField(
        autocorrect: false,
        keyboardType: keyboardType,
        obscureText: (isPasswordField == false) ? obscureText : !obscureText,
        validator: validator,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.black,
            ),
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            suffixIcon: (isPasswordField)
                ? IconButton(
                    icon: Icon(
                      (obscureText)
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
