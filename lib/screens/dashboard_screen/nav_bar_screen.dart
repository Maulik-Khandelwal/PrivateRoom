import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parallax_rain/parallax_rain.dart';
import 'package:privateroom/screens/dashboard_screen/add_room_screen.dart';
import 'package:privateroom/screens/dashboard_screen/top_bar.dart';
import 'package:privateroom/screens/dashboard_screen/widgets/nav_item.dart';
import 'package:privateroom/utility/ui_constants.dart';

class NavBarScreen extends StatelessWidget {
  final onPressed;

  NavBarScreen({
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final shrinkSizedBox = Expanded(
      child: SizedBox.shrink(),
    );

    final headingText = Text(
      'Menu',
      style: kHeadingTextStyle.copyWith(fontSize: 30, color: kImperialRed),
      textAlign: TextAlign.center,
    );

    final sizedBox10 = SizedBox(height: 10);
    final sizedBox30 = SizedBox(height: 30);

    final navItemClose = NavItem(
      onTap: onPressed,
      title: 'Close Nav Bar',
      iconData: FontAwesomeIcons.times,
    );

    final navItemAddRoom = NavItem(
      onTap: () {
        final route = MaterialPageRoute(builder: (ctx) => AddRoomScreen());
        Navigator.push(context, route);
      },
      title: 'New Room',
      iconData: FontAwesomeIcons.users,
      subTitle: 'Add a new room and invite your friends.',
    );

    final navItemAbout = NavItem(
      onTap: () {
        // todo: add github repo link
      },
      title: 'About',
      iconData: FontAwesomeIcons.info,
      subTitle: 'All info you need about Private Room',
    );

    final navItemReportBug = NavItem(
      onTap: () {
        // todo: add github repo link
      },
      title: 'Report a bug',
      iconData: FontAwesomeIcons.bug,
      subTitle: 'File an issue on the Github Repo',
    );

    return Stack(
      children: [
        Container(
        color: Colors.white,
        child: Stack(
          children: [
            // ParallaxRain(dropColors: [kSteelBlue, Color(0xff65eaea)], dropHeight: 10,),
            Row(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    sizedBox30,
                    // headingText,
                    sizedBox30,
                    sizedBox30,
                    navItemClose,
                    sizedBox30,
                    navItemAddRoom,
                    sizedBox30,
                    navItemAbout,
                    sizedBox30,
                    navItemReportBug,
                  ],
                ),
              ),
              shrinkSizedBox,
            ],
          ),
          ]
        ),
      ),
      Align(child: RotatedBox(child: TopBar(height: 150,), quarterTurns: 2,), alignment: Alignment.bottomCenter,)
      ],
    );
  }
}
