import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:privateroom/utility/firebase_constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../utility/ui_constants.dart';
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
      borderRadius: BorderRadius.circular(10.0),
      // side: BorderSide(
      //   width: 2.0,
      //   color: kImperialRed,
      // ),
    );

    final alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: true,
      isOverlayTapDismiss: false,
      alertBorder: alertBorder,
      titleStyle: kHeadingTextStyle.copyWith(color: kSteelBlue, fontSize: 30),
    );

    final alertContent = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 5),
        Text(
          'Are you sure want to leave your private room, rest of the world is not secure enough !',
          style: kLabelTextStyle.copyWith(color: kLightBlue),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
      ],
    );

    final dialogButton = DialogButton(
      height: 40,
      width: 120,
      onPressed: () => Navigator.pop(context),
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
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        title: Text(
          'Private Room',
          style: TextStyle(color: kImperialRed),
        ),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){showLoginDialog(context);}, color: kImperialRed,)
      ),
      body: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome to ${widget.roomData[kRoomName]}",
                        style: kHeadingTextStyle.copyWith(
                          fontSize: 30,
                          color: kLightBlue
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Column(
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
                              color: kImperialRed,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Hey! Come studdy with me on Study Buddies. Click the link to join the session. https://www.StudyBuddies/session123.com",
                            style: kGeneralTextStyle.copyWith(fontSize: 20, color: kSteelBlue),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Column(
                        children: [
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
                              SizedBox(
                                height: 52,
                                width: 52,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: kImperialRed,
                                    padding: EdgeInsets.zero,
                                  ),
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.textsms,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              SizedBox(
                                height: 52,
                                width: 52,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: kImperialRed,
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: const Icon(
                                    Icons.mail,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Buddies currently here (4)...",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // const BuddyRow(),
                        ],
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: Card(
                          color: const Color(0xffFFE0C3),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () => {
                             Navigator.push(context, MaterialPageRoute(
                                builder: (ctx) => MessagingScreen(
                                roomData: widget.roomData,
                                password: widget.password,
                                name: widget.name,
                                ),
                              ))
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 16.0,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Start Chatting",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontSize: 22),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    CupertinoIcons.right_chevron,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: Card(
                          color: const Color(0xffFFE0C3),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () => {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (ctx) => RoomHome(),
                              ))
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 16.0,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Start Chatting",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontSize: 22),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    CupertinoIcons.right_chevron,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}