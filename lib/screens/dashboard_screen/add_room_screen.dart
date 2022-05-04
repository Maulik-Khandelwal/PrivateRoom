import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:privateroom/retro/retroTextField.dart';
import 'package:privateroom/retro/retro_button.dart';
import 'package:privateroom/retro/stylized_text.dart';
import 'package:privateroom/screens/dashboard_screen/top_bar.dart';
import 'package:privateroom/services/encryption_service.dart';
import 'package:privateroom/utility/firebase_constants.dart';
import 'package:privateroom/utility/ui_constants.dart';
import 'package:privateroom/widgets/card_text_field.dart';

import '../../retro/back_button.dart';

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({Key key}) : super(key: key);

  @override
  _AddRoomScreenState createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  final _firestore = FirebaseFirestore.instance;

  final _roomNameController = TextEditingController();
  final _roomPasswordController = TextEditingController();

  bool showProgress = false;

  void createNewRoom() async {
    setState(() {
      showProgress = true;
    });

    String inputRoomName = _roomNameController.text.trim();
    String inputRoomPassword = _roomPasswordController.text.trim();

    _roomPasswordController.clear();
    _roomNameController.clear();

    assert(inputRoomName != null && inputRoomName.isNotEmpty);
    assert(inputRoomPassword != null && inputRoomPassword.isNotEmpty);

    var ref = _firestore.collection(kRoomCollection).doc();

    String roomId = ref.id;
    String roomName = inputRoomName;
    String roomCreationDate =
        DateFormat('HH:mm, dd MMMM, yyyy').format(DateTime.now());
    String encryptedRoomId =
        EncryptionService.encrypt(roomId, inputRoomPassword, roomId);

    await ref
        .set({
          kRoomId: roomId,
          kEncryptedRoomId: encryptedRoomId,
          kRoomName: roomName,
          kRoomCreationDate: roomCreationDate,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

    // close the screen
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _roomPasswordController.dispose();
    _roomNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var containerPadding = const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 30,
    );

    var sizedBox20 = SizedBox(
      height: 20,
    );

    var headingText = StylizedText(text: 'Add a new Room', style: kHeadingTextStyle.copyWith(
        fontSize: 30,
        color: Colors.white
    ),);
    Text(
      'Add a new Room',
      style: kHeadingTextStyle.copyWith(
        fontSize: 30,
        color: Colors.white
      ),
      textAlign: TextAlign.center,
    );

    var labelText = Text(
      'To add a new room, please enter a password. After which, you will be provided with an auto-generated Room ID. Share the ID with other\'s to allow them to join your room.',
      style: kLightLabelTextStyle.copyWith(color: kBlack),
      textAlign: TextAlign.center,
    );

    var textFieldNewRoomPassword = addressTextField(context, text: _roomPasswordController, hint: 'New Room Password', icon: CupertinoIcons.lock_fill, color: Colors.white);
    // CardTextField(
    //   controller: _roomPasswordController,
    //   obscureText: true,
    //   labelText: 'New Room Password',
    //   keyboardType: TextInputType.visiblePassword,
    //   iconData: FontAwesomeIcons.lock,
    // );

    var textFieldRoomName = addressTextField(context, text: _roomNameController, hint: 'Room Name', icon: FontAwesomeIcons.napster, color: Colors.white);
    // CardTextField(
    //   controller: _roomNameController,
    //   labelText: 'Room Name',
    //   iconData: FontAwesomeIcons.napster,
    // );

    var createRoomButton = GestureDetector(child: RelicBazaarStackedView(height: 46, width: 170, upperColor: CupertinoColors.white,
      child:
    Center(
      child: Text(
            'Create Room',
            style: kGeneralTextStyle.copyWith(color: kBlack),
          ),
    ),
    ),onTap: createNewRoom,
    );
    // RaisedButton(
    //   child: Text(
    //     'Create Room',
    //     style: kGeneralTextStyle.copyWith(color: kBlack),
    //   ),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(20.0),
    //   ),
    //   elevation: 10.0,
    //   padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
    //   color: kLightBlue,
    //   splashColor: kWhite,
    //   onPressed: createNewRoom,
    // );

    return Scaffold(
      backgroundColor: kWhite,
      body: ModalProgressHUD(
        inAsyncCall: showProgress,
        child: Stack(
          children: [
            SafeArea(
            child: Container(
              color: kImperialRed,
              child: Center(
                child: Container(
                  width: double.infinity,
                  padding: containerPadding,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        headingText,
                        sizedBox20,
                        sizedBox20,
                        sizedBox20,
                        RelicBazaarStackedView(
                          upperColor: kSteelBlue,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 380,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                labelText,
                                sizedBox20,
                                sizedBox20,
                                textFieldRoomName,
                                sizedBox20,
                                textFieldNewRoomPassword,
                                sizedBox20,
                                sizedBox20,
                                createRoomButton,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
            TopBar(height: 100,),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 100, 0, 0),
                  child: appBarBackButton(context, const Icon(Icons.arrow_back, color: kBlack), (){Navigator.pop(context);},35, 35),
                )
            )
          ]
        ),
      ),
    );
  }
}
