import 'package:flutter/material.dart';
import 'package:privateroom/utility/ui_constants.dart';

import 'StackedView.dart';

Widget addressTextField(BuildContext context,
    {IconData icon,
      String hint,
      TextEditingController text,
      TextInputType type, Color color = kSteelBlue}) {
  final double height = MediaQuery.of(context).size.height;
  final double width = MediaQuery.of(context).size.width;
  return RelicBazaarStackedView(
    height: height * 0.06,
    width: width * 0.85,
    child: TextFormField(
      textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.bottom,
        style: const TextStyle(
          // fontFamily: 'pix M 8pt',
          fontSize: 16,
          color: Colors.black,
        ),
        keyboardType: type,
        controller: text,
        decoration: textFieldDecoration(hintText: hint, icon: Icon(icon, color: Colors.black,), color: color)),
  );
}

InputDecoration textFieldDecoration({String hintText, Icon icon, IconButton suffixIcon, Color color}) {
  return InputDecoration(
      prefixIcon: icon,
      hintText: hintText,
      filled: true,
      fillColor: color,
      border: InputBorder.none,
      suffixIcon: suffixIcon
  );
}