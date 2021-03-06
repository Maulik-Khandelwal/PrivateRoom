import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:privateroom/retro/retro_button.dart';
import 'package:privateroom/screens/drawing_screen/drawing_screen.dart';
import 'package:privateroom/services/encoding_decoding_service.dart';
import 'package:privateroom/utility/firebase_constants.dart';
import 'package:privateroom/utility/ui_constants.dart';

class BottomSheetMenu extends StatelessWidget {
  BottomSheetMenu({
    @required this.toggleBrowser,
    @required this.chatDataCollectionReference,
    @required this.name,
    @required this.password,
  });

  final Function toggleBrowser;
  final chatDataCollectionReference;
  final String name;
  final String password;

  // todo: the image is not encrypted
  void uploadData(var imageBytes) async {
    var _ref = chatDataCollectionReference.doc();
    var documentId = _ref.id;

    final UploadTask uploadTask = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(documentId)
        .putData(imageBytes);

    var url =
        (await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL())
            .toString();

    Map<String, dynamic> data = {
      kUserName: name,
      kTimestamp: DateFormat('HH:mm, dd MMM yyyy').format(DateTime.now()),
      kMessageBody: url,
      kIsDoodle: true,
    };

    String encryptedData = EncodingDecodingService.encodeAndEncrypt(
      data,
      documentId, // using doc id as IV
      password,
    );

    _ref.set({
      'data': encryptedData,
      'id': documentId,
      'date': DateTime.now().toIso8601String().toString(),
    });
  }

  void openDoodleArea(var context) async {
    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (ctx) => DrawingScreen(),
    );

    var imageBytes = await Navigator.of(context).push(pageRoute);

    if (imageBytes == null) {
      return;
    }

    uploadData(imageBytes);
  }

  void setChatTheme() {}

  final sizedBoxWidth = SizedBox(width: 30.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: <Widget>[
            TileItem(
              iconData: FontAwesomeIcons.fileImage,
              title: 'Theme',
              onTap: setChatTheme,
            ),
            sizedBoxWidth,
            TileItem(
              iconData: FontAwesomeIcons.firefoxBrowser,
              title: 'Browser',
              onTap: () => toggleBrowser(),
            ),
            sizedBoxWidth,
            TileItem(
              iconData: FontAwesomeIcons.pencilRuler,
              title: 'Doodle',
              onTap: () => openDoodleArea(context),
            ),
          ],
        ),
      ),
    );
  }
}

class TileItem extends StatelessWidget {
  TileItem({
    this.iconData,
    this.title,
    this.onTap,
  });

  final iconData;
  final title;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: RelicBazaarStackedView(
        upperColor: Colors.white,
        height: 80,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              color: Colors.black,
              size: 35.0,
            ),
            SizedBox(height: 10.0),
            Text(
              title,
              style: kLabelTextStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
