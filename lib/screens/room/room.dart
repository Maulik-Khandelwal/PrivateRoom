import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privateroom/retro/retro_button.dart';
import 'package:privateroom/retro/stylized_text.dart';
import 'package:privateroom/screens/dashboard_screen/dashboard_screen.dart';
import 'package:privateroom/screens/dashboard_screen/foreground_screen.dart';
import 'package:privateroom/utility/firebase_constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../retro/back_button.dart';
import '../../utility/ui_constants.dart';
import '../dashboard_screen/top_bar.dart';
import '../messaging_screen/messaging_screen.dart';
import 'home_page.dart';

class Room extends StatefulWidget {
  final roomData;
  final password;
  final name;

  const Room({
    Key key,
    @required this.roomData,
    @required this.password,
    @required this.name,
  }) : super(key: key);

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  void showLoginDialog(var context) {
    final alertBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
      side: BorderSide(
        width: 2.0,
        color: Colors.black,
      ),
    );

    final alertStyle = AlertStyle(
      backgroundColor: kWhite,
      animationType: AnimationType.fromTop,
      isCloseButton: true,
      isOverlayTapDismiss: false,
      alertBorder: alertBorder,
      titleStyle: kHeadingTextStyle.copyWith(color: kImperialRed, fontSize: 30),
    );

    final alertContent = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 5),
        Text(
          'Are you sure want to leave your private room, rest of the world is not secure enough !',
          style: kLabelTextStyle.copyWith(color: kBlack),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
      ],
    );

    final dialogButton = DialogButton(
      border: Border.all(color: Colors.black, width: 2),
      radius: BorderRadius.circular(0),
      height: 40,
      width: 120,
      color: kSteelBlue,
      onPressed: () => Navigator.push(context, MaterialPageRoute(
        builder: (ctx) => DashboardScreen(),)),
      child: Text(
        "Confirm !",
        style: kGeneralTextStyle,
      ),
    );

    Alert(
      style: alertStyle,
      context: context,
      title: 'Leave ${widget.roomData[kRoomName]}',
      content: alertContent,
      buttons: [
        dialogButton,
      ],
      closeFunction: () {
        Navigator.pop(context);
      },
    ).show();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kImperialRed,
      // appBar: AppBar(
      //   backgroundColor: kWhite,
      //   title: Text(
      //     'Private Room',
      //     style: TextStyle(color: kImperialRed),
      //   ),
      //   centerTitle: true,
      //   leading: IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){showLoginDialog(context);}, color: kImperialRed,)
      // ),
      body: Stack(
        children: [SafeArea(
          child: Container(
            color: kImperialRed,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 60,),
                            StylizedText(text: "Welcome to ${widget.roomData[kRoomName]}",
                                style: kHeadingTextStyle.copyWith(
                                    fontSize: 30,
                                    color: Colors.white
                                ),
                                textAlign: TextAlign.center),
                            // Text(
                            //   "Welcome to ${widget.roomData[kRoomName]}",
                            //   style: kHeadingTextStyle.copyWith(
                            //     fontSize: 30,
                            //     color: kLightBlue
                            //   ),
                            //   textAlign: TextAlign.center,
                            // ),
                            RelicBazaarStackedView(
                              upperColor: kSteelBlue,
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 360,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.white,
                                                  content: Text(
                                                    "Invite Copied!",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium,
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.copy,
                                              size: 36,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Hey! Come join me on Private Room. Join "${widget.roomData[kRoomName]}" with Room ID: ${widget.roomData[kRoomId]} by using your super secret password.',
                                            style: kGeneralTextStyle.copyWith(fontSize: 15, color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Text(
                                          "Invite by text or email",
                                          style: Theme.of(context).textTheme.titleLarge,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            RelicBazaarStackedView(
                                              height: 52,
                                              width: 52,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  color: kSteelBlue,
                                                  child: const Icon(
                                                    Icons.textsms,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            RelicBazaarStackedView(
                                              height: 52,
                                              width: 52,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  color: kSteelBlue,
                                                  child: const Icon(
                                                    Icons.mail,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Buddies currently here (4)...",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (ctx) => MessagingScreen(
                                        roomData: widget.roomData,
                                        password: widget.password,
                                        name: widget.name,
                                      ),
                                    ))
                                  },
                                  child: RelicBazaarStackedView(
                                    upperColor: Colors.white,
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    height: 55,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Chat Room",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(fontSize: 22),
                                          ),
                                          const Spacer(),
                                          const Icon(
                                            Icons.chat,
                                            size: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            SizedBox(height: 20,),
                            GestureDetector(
                              onTap: () => {
                              Navigator.push(context, MaterialPageRoute(
                              builder: (ctx) => RoomHome(),))
                              },
                              child: RelicBazaarStackedView(
                                upperColor: Colors.white,
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 55,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Study Room",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(fontSize: 22),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        FontAwesomeIcons.book,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                              ],
                            ),
                            SizedBox(height: 1,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
          TopBar(height: 100,),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 100, 0, 0),
                child: appBarBackButton(context, const Icon(Icons.exit_to_app, color: kBlack), (){showLoginDialog(context);}, 35, 35),
              )
          )
    ]
      ),
    );
  }
}