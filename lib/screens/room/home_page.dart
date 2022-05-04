import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privateroom/retro/retro_button.dart';
import 'package:privateroom/screens/room/pmd_page/pmd_page.dart';
import 'package:privateroom/screens/room/pmd_select/pmd_select_page.dart';
import 'package:privateroom/screens/room/room.dart';
import 'package:privateroom/screens/room/time_select/time_select_page.dart';
import 'package:privateroom/screens/room/timer_page.dart';

import '../../retro/back_button.dart';
import '../../utility/ui_constants.dart';
import '../dashboard_screen/top_bar.dart';

class RoomHome extends StatefulWidget {
  const RoomHome({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RoomHomeState();
  }
}

class RoomHomeState extends State<RoomHome> {
  List<String> days = ["We", "Th", "Fr", "Sa", "Su"];

  static String dateTimetoHumanReadable(DateTime dt) {
    String dateSlug =
        "${dt.year.toString()}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}";
    return dateSlug;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [SafeArea(
          child: Container(
            color: kImperialRed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 42.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 20),
                  const SizedBox(height: 40),
                  const SizedBox(
                    height: 20,
                  ),
                  RelicBazaarStackedView(
                    upperColor: Colors.white,
                    width: MediaQuery.of(context).size.width - 64,
                    height: 165,
                    child: Container(
                      padding: const EdgeInsets.all(
                        20.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Today: ${dateTimetoHumanReadable(DateTime.now())}",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              SizedBox(height: 7,),
                              Text(
                                "Your Study Streak: ${days.length} Days",
                                style: kLabelTextStyle,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: days
                                .map(
                                  (e) => Expanded(
                                    child: CircleAvatar(
                                      backgroundColor: kSteelBlue,
                                      child: Text(e, style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => {
                      Navigator.pop(context)
                    },
                    child: RelicBazaarStackedView(
                      upperColor: kSteelBlue,
                      width: MediaQuery.of(context).size.width - 64,
                      height: 180,
                      child: Container(
                        padding: const EdgeInsets.all(
                          20.0,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Begin a group study session",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontSize: 30),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Invite Friends",
                                  style: Theme.of(context).textTheme.titleLarge.copyWith(color: Colors.white),
                                ),
                                const Spacer(),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.message,
                                      size: 30,color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Icon(
                                      Icons.mail,
                                      size: 30,color: Colors.white,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TimeSelectPage(
                            callback: (p) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TimerPage(
                                    timerStateChangeNotifier: p,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
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
                              "Set a timer block",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontSize: 22),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.timer,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PmdSelectPage(
                            callback: (p) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PmdPage(
                                    pmdStateChangeNotifier: p,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
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
                              "Start a pomodoro",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontSize: 22),
                            ),
                            const Spacer(),
                            const Icon(
                              FontAwesomeIcons.clock,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,)
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
          )
        ]
      ),
    );
  }
}
