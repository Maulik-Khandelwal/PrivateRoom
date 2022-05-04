import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:privateroom/retro/back_button.dart';
import 'package:privateroom/retro/retroTextField.dart';
import 'package:privateroom/retro/retro_button.dart';
import 'package:privateroom/screens/messaging_screen/widgets/bottom_sheet_menu.dart';
import 'package:privateroom/screens/messaging_screen/webview/browser.dart';
import 'package:privateroom/screens/messaging_screen/widgets/chat_bubble.dart';
import 'package:privateroom/services/encoding_decoding_service.dart';
import 'package:privateroom/utility/firebase_constants.dart';
import 'package:privateroom/utility/ui_constants.dart';

import '../dashboard_screen/top_bar.dart';

class MessagingScreen extends StatefulWidget {
  final roomData;
  final password;
  final name;

  MessagingScreen({
    @required this.roomData,
    @required this.password,
    @required this.name,
  });

  @override
  _MessagingScreenState createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final _textMessageController = TextEditingController();

  bool showBrowser = false;
  DocumentReference _documentRef;
  CollectionReference _chatDataCollectionRef;

  void toggleBrowser() {
    setState(() {
      showBrowser = !showBrowser;
    });
  }

  void sendMessage(String message) {
    var _ref = _chatDataCollectionRef.doc();
    var documentId = _ref.id;

    Map<String, dynamic> data = {
      kUserName: widget.name,
      kTimestamp: DateFormat('HH:mm, dd MMM yyyy').format(DateTime.now()),
      kMessageBody: message,
      kIsDoodle: false,
    };

    String encryptedData = EncodingDecodingService.encodeAndEncrypt(
      data,
      documentId, // using doc id as IV
      widget.password,
    );

    _ref.set({
      'data': encryptedData,
      'id': documentId,
      'date': DateTime.now().toIso8601String().toString(),
    });
  }

  @override
  void initState() {
    super.initState();

    _documentRef = FirebaseFirestore.instance
        .collection(kChatCollection)
        .doc(widget.roomData[kRoomId]);

    _chatDataCollectionRef = _documentRef.collection(kChatDataCollection);
  }

  @override
  Widget build(BuildContext context) {
    // bottom text area widgets
    final menuButton = Positioned.fill(
      child: Align(
        alignment: Alignment.centerLeft,
        child: appBarBackButton(context, Icon(
              FontAwesomeIcons.angleDoubleUp,
              size: 25.0,
              color: kImperialRed,
            ),
    () {
        showModalBottomSheet(
          backgroundColor: kImperialRed,
          isScrollControlled: true,
          context: context,
          builder: (ctx) => SingleChildScrollView(
            child: BottomSheetMenu(
              toggleBrowser: toggleBrowser,
              name: widget.name,
              password: widget.password,
              chatDataCollectionReference: _chatDataCollectionRef,
            ),
          ),
        );
      }, 40, 40)
        // MaterialButton(
        //   onPressed: () {
        //     showModalBottomSheet(
        //       isScrollControlled: true,
        //       context: context,
        //       builder: (ctx) => SingleChildScrollView(
        //         child: BottomSheetMenu(
        //           toggleBrowser: toggleBrowser,
        //           name: widget.name,
        //           password: widget.password,
        //           chatDataCollectionReference: _chatDataCollectionRef,
        //         ),
        //       ),
        //     );
        //   },
        //   minWidth: 0,
        //   elevation: 5.0,
        //   color: kWhite,
        //   child: Icon(
        //     FontAwesomeIcons.angleDoubleUp,
        //     size: 25.0,
        //     color: kImperialRed,
        //   ),
        //   padding: EdgeInsets.all(10.0),
        //   shape: CircleBorder(),
        // ),
      ),
    );
    final textArea = Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 50,
            right: 50,
          ),
          child: RelicBazaarStackedView(
            height: MediaQuery.of(context).size.height * 0.05,
            // width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.bottom,
                style: const TextStyle(
                  // fontFamily: 'pix M 8pt',
                  fontSize: 16,
                  color: Colors.black,
                ),
                controller: _textMessageController,
                decoration: InputDecoration(
                    hintText: 'Type your message...',
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                ),
          )),
        ),
      ),
    );
    final sendButton = Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: RelicBazaarStackedView(
          upperColor: kImperialRed,
          width: 50,
          height: 50,
          borderColor: kImperialRed,
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.chevronRight,
              size: 25.0,
              color: kWhite,
            ),
            onPressed: () {
              String message = _textMessageController.text.trim();
              _textMessageController.clear();

              if (message.isEmpty) {
                return;
              }
              sendMessage(message);
            },
          ),
        ),
      )
      // MaterialButton(
      //   onPressed: () {
      //     String message = _textMessageController.text.trim();
      //     _textMessageController.clear();
      //
      //     if (message.isEmpty) {
      //       return;
      //     }
      //     sendMessage(message);
      //   },
      //   minWidth: 0,
      //   elevation: 5.0,
      //   color: kImperialRed,
      //   child: Icon(
      //     FontAwesomeIcons.chevronRight,
      //     size: 25.0,
      //     color: kWhite,
      //   ),
      //   padding: EdgeInsets.all(15.0),
      //   shape: CircleBorder(),
      // ),
    );

    final bottomTextArea = RelicBazaarStackedView(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 65,
      upperColor: kSteelBlue,
      lowerColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
        child: Stack(
          children: <Widget>[
            menuButton,
            textArea,
            sendButton,
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30,),
              showBrowser
                  ? Browser(
                      roomId: widget.roomData[kRoomId],
                      password: widget.password,
                      toggleBrowser: toggleBrowser,
                    )
                  : SizedBox.shrink(),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _chatDataCollectionRef.orderBy('date').snapshots(),
                  builder: (ctx, snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.data.docs.isEmpty)
                      return Center(
                        child: Text(
                          'Send your first text in this Room',
                          style: kTitleTextStyle,
                        ),
                      );

                    List<Widget> widgets = [];
                    List<DocumentSnapshot> ds =
                        snapshot.data.docs.reversed.toList();

                    for (var chatData in ds) {
                      widgets.add(ChatBubble(
                        chatData: chatData,
                        name: widget.name,
                        password: widget.password,
                      ));
                    }

                    // snapshot.data.docs.reversed.forEach((doc) {
                    //   widgets.add(ChatBubble(
                    //     chatData: doc,
                    //     name: widget.name,
                    //     password: widget.password,
                    //   ));
                    // });

                    return ListView.builder(
                      reverse: true,
                      itemCount: widgets.length,
                      itemBuilder: (ctx, index) {
                        return widgets[index];
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 12),
                child: bottomTextArea,
              ),
            ],
          ),
        ),
          TopBar(height: 100,),
    ]
      ),
    );
  }
}
