import 'package:flutter/material.dart';
import 'package:memory_detector_of_kit/memory_detector_of_kit.dart';

import 'package:memory_detector_of_kit/widget/mem_detector_button.dart';

import 'leak_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  static dynamic leaker;

  OverlayEntry? entry;


  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      routes: {
        '/p1' : (_)=> const LeakPage1(),
        '/p2' : (_)=> const LeakPage2(),
        '/p3' : (_)=> const LeakPage3(),
        '/p4' : (_)=> const LeakPage4(),
      },
      navigatorObservers: [
        MemoryDetectorOfKit(),
      ],
      home: Builder(
        builder: (context) {
          if(entry == null) {
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
              entry = OverlayEntry(builder: (_) => const RikiMemDetectorButton());
              Overlay.of(context)?.insert(entry!);
            });
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Plugin example app'),
            ),
            //floatingActionButton: const RikiMemDetectorButton(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildBtn('page 1', () async {
                  leaker = await Navigator.pushNamed(context, '/p1');
                  debugPrint(leaker.runtimeType.toString());
                }),
                _buildBtn('page 2', () async {
                  leaker = await Navigator.pushNamed(context, '/p2');
                  debugPrint(leaker.runtimeType.toString());
                }),
                _buildBtn('page 3', () async {
                  leaker = await Navigator.pushNamed(context, '/p3');
                  debugPrint(leaker.runtimeType.toString());
                }),
                _buildBtn('page 4', () async {
                  leaker = await Navigator.pushNamed(context, '/p4');
                  debugPrint(leaker.runtimeType.toString());
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBtn(String title, VoidCallback tap) => ElevatedButton(onPressed: tap, child: Text(title));


}
