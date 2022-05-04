import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privateroom/retro/retroTextField.dart';
import 'package:privateroom/retro/retro_button.dart';
import 'package:privateroom/retro/stylized_text.dart';

import '../../../retro/back_button.dart';
import '../../../utility/ui_constants.dart';
import '../../dashboard_screen/top_bar.dart';
import '../providers/timer_state_provider.dart';

class TimeSelectPage extends StatefulWidget {
  const TimeSelectPage({
    Key key,
    @required this.callback,
  }) : super(key: key);

  final Function(ChangeNotifierProvider<TimerStateProvider>) callback;

  @override
  State<TimeSelectPage> createState() => _TimeSelectPageState();
}

class _TimeSelectPageState extends State<TimeSelectPage> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: "120");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [SafeArea(
      child: Container(
      color: kImperialRed,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 120.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 150),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StylizedText(text: "Timer Block", style: TextStyle(fontSize: 30, color: Colors.white),),
                        SizedBox(height: 40,),
                        Text(
                          "Set timer for (minutes): ",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        addressTextField(context, text: _controller, hint: 'Minutes'),
                        // TextField(
                        //   controller: _controller,
                        //   style: Theme.of(context).textTheme.titleMedium,
                        //   decoration: const InputDecoration(
                        //     focusedBorder: OutlineInputBorder(),
                        //     enabledBorder: OutlineInputBorder(),
                        //     hintText: 'Minutes',
                        //   ),
                        // ),
                        GestureDetector(child: RelicBazaarStackedView(child: Center(

                          child: Text("Begin",
                              style:
                              Theme.of(context).textTheme.titleLarge),
                        ),upperColor: Colors.white, height: 50, width: 120,),onTap: () {
                          int minutes = int.parse(_controller.value.text);
                          ChangeNotifierProvider<TimerStateProvider>
                          provider = ChangeNotifierProvider(
                                (_) => TimerStateProvider(
                              duration: Duration(minutes: minutes),
                            ),
                          );
                          widget.callback(provider);
                        },)
                      ],
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
                child: appBarBackButton(context, const Icon(Icons.arrow_back, color: kBlack), (){Navigator.pop(context);}, 35, 35),
              )
          )])
    );
  }
}
