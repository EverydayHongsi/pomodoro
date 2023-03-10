import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = 10;
  int pomodoroNumber = 0;
  bool isRunning = false;
  late Timer timer;

  void onTick(Timer timer) {
    setState(() {
      totalSeconds = totalSeconds - 1;
    });
    if (totalSeconds == 0) {
      isRunning = false;
      timer.cancel();
      pomodoroNumber += 1;
      totalSeconds = 10;
    }
  }

  void onStartPressed() {
    setState(() {});
    isRunning = true;
    timer = Timer.periodic(
        const Duration(
          seconds: 1,
        ),
        onTick);
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onReset() {
    timer.cancel();
    totalSeconds = 10;
    isRunning = false;
    setState(() {});
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    var result = duration.toString().split(".")[0].substring(3, 7);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children: [
        Flexible(
          flex: 1,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              format(totalSeconds),
              style: TextStyle(
                color: Theme.of(context).cardColor,
                fontSize: 89,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: isRunning ? onPausePressed : onStartPressed,
                  iconSize: 98,
                  icon: isRunning
                      ? Icon(
                          Icons.pause_circle,
                          color: Theme.of(context).cardColor,
                        )
                      : Icon(
                          Icons.play_circle_outlined,
                          color: Theme.of(context).cardColor,
                        ),
                ),
                isRunning
                    ? IconButton(
                        onPressed: onReset,
                        iconSize: 33,
                        icon: Icon(
                          Icons.restore,
                          color: Theme.of(context).cardColor,
                        ),
                      )
                    : const Text(''),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Pomodoro',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '$pomodoroNumber',
                          style: const TextStyle(
                            fontSize: 50,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
