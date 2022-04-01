import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../messaging_screen/messaging_screen.dart';

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Invite Buddies",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                              fontSize: 40,
                            ),
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
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Hey! Come studdy with me on Study Buddies. Click the link to join the session. https://www.StudyBuddies/session123.com",
                                style: Theme.of(context).textTheme.titleLarge,
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
                                        primary: const Color(
                                          0xff8A93E9,
                                        ),
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
                                        primary: const Color(
                                          0xff8A93E9,
                                        ),
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
    );
  }
}