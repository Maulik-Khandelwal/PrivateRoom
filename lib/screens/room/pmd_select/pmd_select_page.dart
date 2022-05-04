import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privateroom/retro/retro_button.dart';
import 'package:privateroom/utility/ui_constants.dart';

import '../../../retro/back_button.dart';
import '../../../retro/stylized_text.dart';
import '../../dashboard_screen/top_bar.dart';
import '../models/pmd_data.dart';
import '../providers/pmd_state_provider.dart';

class PmdSelectPage extends StatefulWidget {
  const PmdSelectPage({
    Key key,
    @required this.callback,
  }) : super(key: key);

  final Function(ChangeNotifierProvider<PmdStateProvider>) callback;

  @override
  State<PmdSelectPage> createState() => _PmdSelectPageState();
}

class _PmdSelectPageState extends State<PmdSelectPage> {
  PmdData _data;

  @override
  void initState() {
    super.initState();
    _data = PmdData(20, 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Stack(
        children: [SafeArea(
          child: Container(
            color: kImperialRed,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                StylizedText(
                                  text: "Start a Pomodoro",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontSize: 30,
                                    color: Colors.white
                                      ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                RelicBazaarStackedView(
                                  upperColor: Colors.white,
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 70,
                                  child: Center(
                                    child: RadioListTile<PmdData>(
                                      title:
                                          const Text('20 min focus; 5 min break'),
                                      value: PmdData(20, 5),
                                      groupValue: _data,
                                      onChanged: (var value) {
                                        setState(() {
                                          _data = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RelicBazaarStackedView(
                                  upperColor: Colors.white,
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 70,
                                  child: Center(
                                    child: RadioListTile<PmdData>(
                                      title:
                                          const Text('40 min focus; 10 min break'),
                                      value: PmdData(40, 10),
                                      groupValue: _data,
                                      onChanged: (var value) {
                                        setState(() {
                                          _data = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RelicBazaarStackedView(
                                  upperColor: Colors.white,
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 70,
                                  child: Center(
                                    child: RadioListTile<PmdData>(
                                      title:
                                          const Text('60 min focus; 20 min break'),
                                      value: PmdData(60, 20),
                                      groupValue: _data,
                                      onChanged: (var value) {
                                        setState(() {
                                          _data = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                ChangeNotifierProvider<PmdStateProvider>
                                provider = ChangeNotifierProvider(
                                      (_) => PmdStateProvider(
                                    pmdData: _data,
                                  ),
                                );
                                widget.callback(provider);
                              },
                              child: RelicBazaarStackedView(
                                width: MediaQuery.of(context).size.width * 0.75,
                                height: 55,
                                upperColor: Colors.white,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 7.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Text("Begin",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                                      const Spacer(),
                                      const Icon(
                                        CupertinoIcons.chevron_right,
                                      ),
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
                child: appBarBackButton(context, const Icon(Icons.arrow_back, color: kBlack), (){Navigator.pop(context);},35, 35),
              )
          )
    ],
      ),
    );
  }
}
