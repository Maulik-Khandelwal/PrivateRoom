import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:privateroom/utility/ui_constants.dart';
import 'StackedView.dart';
import 'app_icons.dart';

Widget searchBar(BuildContext context) {
  final double height = MediaQuery.of(context).size.height;
  final double width = MediaQuery.of(context).size.width;
  return RelicBazaarStackedView(
    height: height * 0.06,
    width: width * 0.9,
    child: Container(
      height: height * 0.06,
      width: width * 0.9,
      color: kSteelBlue,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: () =>
              {},
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  const Text(
                    'Search for room name, room id ...',
                    style: TextStyle(
                      // fontFamily: 'pix M 8pt',
                      fontSize: 15,
                      color: kBlack,
                      fontWeight: FontWeight.w100
                    ),
                  ),
                ],
              ),
            ),
            const Icon(CupertinoIcons.search, size: 35,),
          ],
        ),
      ),
    ),
  );
}