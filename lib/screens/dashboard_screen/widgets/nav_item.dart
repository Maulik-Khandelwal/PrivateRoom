import 'package:flutter/material.dart';
import 'package:privateroom/retro/back_button.dart';
import 'package:privateroom/utility/ui_constants.dart';

import '../../../retro/StackedView.dart';

class NavItem extends StatelessWidget {
  final title;
  final iconData;
  final subTitle;
  final onTap;

  NavItem({
    @required this.title,
    @required this.iconData,
    @required this.subTitle,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: kTitleTextStyle.copyWith(color: kBlack, fontSize: 20),
      ),
      leading: RelicBazaarStackedView(
        upperColor: kImperialRed,
        width: 50,
        height: 50,
        borderColor: Colors.white,
        child: IconButton(
          icon: Icon(
            iconData,
            color: Colors.white,
            size: 30,
          ),
          onPressed: onTap,
        ),
      ),
      subtitle: subTitle != null
          ? Text(
              subTitle,
              style: kLightLabelTextStyle.copyWith(color: kBlack),
            )
          : null,
    );
  }
}
