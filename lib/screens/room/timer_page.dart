import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privateroom/screens/room/providers/timer_state_provider.dart';
import 'package:privateroom/screens/room/timer_page/buddy_row.dart';
import 'package:privateroom/screens/room/timer_page/done_button.dart';
import 'package:privateroom/screens/room/timer_page/play_pause_button.dart';
import 'package:privateroom/screens/room/timer_page/quit_button.dart';
import 'package:privateroom/screens/room/timer_page/timer.dart';

import '../../retro/back_button.dart';
import '../../utility/ui_constants.dart';
import '../dashboard_screen/top_bar.dart';
import 'done_page/done_page.dart';

class TimerPage extends ConsumerStatefulWidget {
  const TimerPage({Key key, this.timerStateChangeNotifier})
      : super(key: key);

  final ChangeNotifierProvider<TimerStateProvider> timerStateChangeNotifier;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return TimerPageState();
  }
}

class TimerPageState extends ConsumerState<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
        children: [
          SafeArea(
        child: Container(
        color: kImperialRed,
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 42.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Card(
                  color: const Color(0xffFFE0C3),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 16.0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Study Session ~ ${ref.read(widget.timerStateChangeNotifier).duration.inHours}hr",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 22),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.edit,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                TimerText(
                  initial: const Duration(
                    hours: 1,
                    minutes: 20,
                    seconds: 42,
                  ),
                  timerStateNotifier: widget.timerStateChangeNotifier,
                ),
                const SizedBox(
                  height: 80,
                ),
                Card(
                  color: const Color(0xffFFE0C3),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 16.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "4 buddies studying with you",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const BuddyRow(),
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DoneButton(onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const DonePage(),
                        ),
                      );
                    }),
                    PlayPauseButton(
                      timerStateNotifier: widget.timerStateChangeNotifier,
                    ),
                    QuitButton(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text("Its sad to see you go!"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Close"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).popUntil(
                                      (route) => route.isFirst,
                                    );
                                  },
                                  child: const Text("Exit"),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
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
          )
        ]
        ),
    );
  }
}