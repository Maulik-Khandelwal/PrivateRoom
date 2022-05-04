import 'package:flutter/material.dart';

import 'StackedView.dart';

Widget appBarBackButton(BuildContext context, Icon icon, Function onTap, double height, double width) {
  return RelicBazaarStackedView(
    upperColor: Colors.white,
    width: width,
    height: height,
    borderColor: Colors.white,
    child: IconButton(
      icon: icon,
      onPressed: onTap,
    ),
  );
}