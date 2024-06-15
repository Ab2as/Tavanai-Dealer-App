import 'package:flutter/material.dart';

class MyTextFormField1 extends StatefulWidget {
  final TextEditingController myController;
  final String fieldName;
  final IconData myIcon;
  final Color iconColor;
  final TextInputType keyboard;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final String errorMessage;
  final bool obscureText;
  final IconData suffixIcon;

  MyTextFormField1({
    required this.myController,
    required this.fieldName,
    required this.myIcon,
    required this.iconColor,
    required this.keyboard,
    this.validator,
    this.onSaved,
    required this.errorMessage,
    required this.obscureText,
    required this.suffixIcon,
  });

  @override
  _MyTextFormField1State createState() => _MyTextFormField1State();
}

class _MyTextFormField1State extends State<MyTextFormField1> {
  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.myController,
      keyboardType: widget.keyboard,
      obscureText: widget.obscureText,
      validator: widget.validator,
      onSaved: widget.onSaved,
      enabled: isEditable,
      decoration: InputDecoration(
        labelText: widget.fieldName,
        prefixIcon: Icon(widget.myIcon, color: widget.iconColor),
        suffixIcon: IconButton(
          icon: Icon(widget.suffixIcon),
          onPressed: () {
            setState(() {
              isEditable = !isEditable;
              if (!isEditable) {
                widget.onSaved!(widget.myController.text);
              }
            });
          },
        ),
        errorText: widget.errorMessage.isNotEmpty ? widget.errorMessage : null,
      ),
    );
  }
}
