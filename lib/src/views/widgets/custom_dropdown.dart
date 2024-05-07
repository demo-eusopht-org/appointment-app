 import 'package:appointment_management/src/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String? hintText;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  final Color dropdownColor;

  const CustomDropdownFormField({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.dropdownColor,
    this.hintText,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButtonFormField<String>(
        hint: hintText != null
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: textWidget(
                    text: hintText!, fSize: 10.0, fWeight: FontWeight.w400),
              )
            : null,
        dropdownColor: dropdownColor,
        icon: Icon(Icons.keyboard_arrow_down_outlined),
        value: value,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 15, left: 12, right: 12),
          isDense: true,
          filled: true,
          fillColor: dropdownColor,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(38),
          ),
        ),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(top: 4, left: 10, right: 10),
              child: textWidget(
                  text: value, fSize: 10.0, fWeight: FontWeight.w400),
            ),
          );
        }).toList(),
      ),
    );
  }
}
