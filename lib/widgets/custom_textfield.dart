import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconButton? icon;
  const CustomTextField({Key? key, required this.controller, required this.hintText, required this.obscureText, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText:obscureText,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        suffixIcon:icon,
        fillColor: Theme.of(context).colorScheme.primary,
        border: InputBorder.none,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color:Theme.of(context).colorScheme.secondary,)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:  BorderSide(color: Colors.grey.shade500,width: 1.5)
        ),
      ),
    ) ;
  }
}
