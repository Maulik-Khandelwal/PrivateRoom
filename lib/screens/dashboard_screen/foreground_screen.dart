import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privateroom/retro/search_bar.dart';
import 'package:privateroom/retro/stylized_container.dart';
import 'package:privateroom/retro/stylized_text.dart';
import 'package:privateroom/screens/dashboard_screen/top_bar.dart';
import 'package:privateroom/utility/firebase_constants.dart';
import 'package:privateroom/utility/ui_constants.dart';
import 'package:privateroom/widgets/not_found.dart';
import 'package:privateroom/screens/dashboard_screen/widgets/room_item_widget.dart';

import '../../retro/StackedView.dart';
import '../../retro/back_button.dart';

class ForegroundScreen extends StatefulWidget {
  final navBarOnPressed;

  ForegroundScreen({
    @required this.navBarOnPressed,
  });

  @override
  _ForegroundScreenState createState() => _ForegroundScreenState();
}

class _ForegroundScreenState extends State<ForegroundScreen> {
  final _firestore = FirebaseFirestore.instance;

  bool showProgress = false;

  void showProgressIndicator(bool show) {
    setState(() {
      showProgress = show;
    });
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxHeight = SizedBox(
      height: 70,
    );

    final headingText = StylizedText(text: "Private Room", style: kHeadingTextStyle.copyWith(
        fontSize: 40, fontWeight: FontWeight.w900, color: kImperialRed
      ), textAlign: TextAlign.center, strokeColor: Colors.black,);

    // final headingText = Text(
    //   'Private Room',
    //   style: kHeadingTextStyle.copyWith(
    //     fontSize: 30, fontWeight: FontWeight.w900
    //   ),
    //   textAlign: TextAlign.center,
    // );

    const titleText = Text(
      'Join a room to continue',
      style: kLightLabelTextStyle,
      textAlign: TextAlign.center,
    );

    // final navButton = Align(
    //   alignment: Alignment.topLeft,
    //   child: IconButton(
    //     icon: Icon(
    //       FontAwesomeIcons.bars,
    //       color: kWhite,
    //     ),
    //     onPressed: widget.navBarOnPressed,
    //   ),
    // );

    final navButton = Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: appBarBackButton(context, Icon(FontAwesomeIcons.bars, color: kBlack), widget.navBarOnPressed, 35, 35),
      )
    );

    const boxDecoration = const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/bg.png"),
        fit: BoxFit.cover,
      ),
      color: kWhite,
      borderRadius: const BorderRadius.only(
        topLeft: const Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    );

    final streamBuilder = StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection(kRoomCollection).snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data.docs.isEmpty) return NotFoundWidget();

        List<Widget> widgets = [];
        List<DocumentSnapshot> ds = snapshot.data.docs;

        for (var room in ds) {
          widgets.add(RoomItemWidget(
            context: context,
            roomData: room,
            showProgressIndicator: showProgressIndicator,
          ));
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
          itemCount: widgets.length,
          itemBuilder: (ctx, index) {
            return widgets[index];
          },
        );
      },
    );

    const circularProgressIndicator = const Center(
      child: CircularProgressIndicator(),
    );

    // final listOfRooms = Container(
    //   decoration: boxDecoration,
    //   child: showProgress ? circularProgressIndicator : streamBuilder,
    // );

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final listOfRooms = SizedBox(
      height: height * 1.08,
      width: width,
      child: showProgress ? circularProgressIndicator : RelicBazaarStackedView(
              width: width * 0.9,
              // height: 729.0,
              upperColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: streamBuilder,
              ),
            )
    );

    final mainCol = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        sizedBoxHeight,
        headingText,
        SizedBox(height: 20,),
        titleText,
        // listOfRooms,
      ],
    );

    final roomList = Padding(
      padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
      child: Column(
        children: [
          searchBar(context),
          SizedBox(height: 20,),
          Expanded(child: listOfRooms),
        ],
      ),
    );

    final foregroundScreen = Container(
      color: kImperialRed,
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(height: MediaQuery.of(context).size.height, color: const Color(0xff009d9d),),
            roomList,
            TopBar(height: 280,),
            mainCol,
            navButton,
          ],
        ),
      ),
    );

    return foregroundScreen;
  }
}
