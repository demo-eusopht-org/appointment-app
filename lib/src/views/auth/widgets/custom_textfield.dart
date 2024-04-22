import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool showPasswordIcon;
  final TextStyle? textStyle;

  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.obscureText = false,
      this.showPasswordIcon = false,
      this.textStyle})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText ? _obscureText : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.showPasswordIcon && widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
