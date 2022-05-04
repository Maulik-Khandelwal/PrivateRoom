import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privateroom/retro/retroTextField.dart';
import 'package:privateroom/retro/retro_button.dart';
import 'package:privateroom/retro/stylized_container.dart';
import 'package:privateroom/retro/stylized_text.dart';
import 'package:privateroom/screens/messaging_screen/messaging_screen.dart';
import 'package:privateroom/services/encryption_service.dart';
import 'package:privateroom/utility/firebase_constants.dart';
import 'package:privateroom/utility/ui_constants.dart';
import 'package:privateroom/widgets/card_text_field.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../room/room.dart';

class RoomItemWidget extends StatelessWidget {
  RoomItemWidget({
    this.roomData,
    this.showProgressIndicator,
    this.context,
  });

  final context;
  final roomData;
  final showProgressIndicator;

  Widget roomTitle(String text){
    return Row(
      children: [
        Flexible(
          child: RelicBazaarStackedView(
            height: 52,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: StylizedText(
                  text: roomData[kRoomName],
                  style: kHeadingTextStyle.copyWith(fontSize: 24, letterSpacing: 1, height: 1.6, color: Colors.white,),
                // maxLines: 1,
                // softWrap: false,
                // overflow: TextOverflow.fade,
              ),
            ),
            ),
        ),
      ],
    );
  }

  void showError(String error) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kImperialRed,
        duration: const Duration(milliseconds: 1500),
        content: Text(
          error,
          style: kLabelTextStyle.copyWith(color: kWhite),
        ),
      ),
    );
  }

  void navigate(var password) async {
    String udid = await FlutterUdid.udid;

    final route = MaterialPageRoute(
      builder: (ctx) => Room(
        roomData: roomData,
        password: password,
        name: udid,
      ),
    );

    // move to new screen
    Navigator.push(context, route);
  }

  void enterRoom(String roomId, String password, var context) async {
    Navigator.pop(context);

    showProgressIndicator(true);

    try {
      assert(password != null && password.isNotEmpty);

      final docSnapshot = await FirebaseFirestore.instance
          .collection(kRoomCollection)
          .doc(roomId)
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot;

        String actualRoomId = data[kRoomId];
        String encryptedRoomId = data[kEncryptedRoomId];
        String decryptedRoomId = '';

        try {
          decryptedRoomId = EncryptionService.decrypt(
              actualRoomId, password, encryptedRoomId);
        } catch (_) {
          showProgressIndicator(false);
          showError('Wrong Password');
          return;
        }

        if (decryptedRoomId == roomId) {
          showProgressIndicator(false);
          navigate(password);
        }
      } else {
        showProgressIndicator(false);
        showError('Room does not exists');
      }
    } catch (e) {
      if (e.toString().toLowerCase().contains('assertion')) {
        showProgressIndicator(false);
        showError('Password can\'t be empty');
      } else {
        showError('Invalid Room ID');
        showProgressIndicator(false);
      }
    }
  }

  void showLoginDialog(var context) {
    final passwordController = TextEditingController();

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
          'Room ID ${roomData[kRoomId]}',
          style: kLabelTextStyle.copyWith(color: kBlack),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 10),
        addressTextField(context, icon: CupertinoIcons.lock_fill, hint: 'Password', text: passwordController, type: TextInputType.visiblePassword),
        // CardTextField(
        //   iconData: FontAwesomeIcons.lock,
        //   controller: passwordController,
        //   labelText: 'Password',
        //   obscureText: true,
        //   keyboardType: TextInputType.visiblePassword,
        // ),
      ],
    );

    final dialogButton = DialogButton(
      border: Border.all(color: Colors.black, width: 2),
      radius: BorderRadius.circular(0),
      height: 40,
      width: 90,
      color: kSteelBlue,
      onPressed: () => enterRoom(
        roomData[kRoomId],
        passwordController.text.trim(),
        context,
      ),
      child: Text(
        "Verify",
        style: kGeneralTextStyle.copyWith(color: kBlack),
      ),
    );

    Alert(
      style: alertStyle,
      context: context,
      title: roomData[kRoomName],
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
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      // side: BorderSide(color: kImperialRed, width: 1),
    );

    final cardMargin = const EdgeInsets.only(
      bottom: 5,
      top: 10,
    );

    final contentPadding = const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 15,
    );

    final roomNameText = roomTitle(roomData[kRoomName]);

    // final roomNameText = Text(
    //   roomData[kRoomName],
    //   style: kHeadingTextStyle.copyWith(fontSize: 24, letterSpacing: 1, height: 1.6, color: kImperialRed),
    // );

    final roomIdText = RichText(text: TextSpan(
      // Here is the explicit parent TextStyle
      style: kGeneralTextStyle.copyWith(fontSize: 15, color: kBlack, fontFamily: 'freshman', fontWeight: FontWeight.w100),
      children: <TextSpan>[
        const TextSpan(text: 'Room ID: ', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
        TextSpan(text: roomData[kRoomId], style: TextStyle(fontWeight: FontWeight.w100),)
      ],
    ),);

    final createdAtText = RichText(text: TextSpan(
      // Here is the explicit parent TextStyle
      style: kGeneralTextStyle.copyWith(fontSize: 15, color: kBlack, fontFamily: 'freshman', fontWeight: FontWeight.w100),
      children: <TextSpan>[
        const TextSpan(text: 'created at: ', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
        TextSpan(text: roomData[kRoomCreationDate], style: TextStyle(fontWeight: FontWeight.w100)),
      ],
    ),);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: RelicBazaarStackedView(
        height: 126,
        upperColor: kSteelBlue,
        child: InkWell(
          onTap: () => showLoginDialog(context),
          // splashColor: kImperialRed.withAlpha(100),
          child: Padding(
            padding: contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                roomNameText,
                const SizedBox(height: 15),
                roomIdText,
                createdAtText,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
