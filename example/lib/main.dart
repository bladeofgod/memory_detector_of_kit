import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ume_kit_console/flutter_ume_kit_console.dart';
import 'package:flutter_ume_kit_device/flutter_ume_kit_device.dart';
import 'package:flutter_ume_kit_perf/flutter_ume_kit_perf.dart';
import 'package:flutter_ume_kit_show_code/flutter_ume_kit_show_code.dart';
import 'package:flutter_ume_kit_ui/flutter_ume_kit_ui.dart';
import 'package:memory_detector_of_kit/memory_detector_of_kit.dart';

import 'package:memory_detector_of_kit/widget/mem_detector_button.dart';
import 'package:flutter_ume/flutter_ume.dart';
import 'leak_page.dart';

void main() {

  if(!kReleaseMode) {
    PluginManager.instance                                 // 注册插件
      ..register(WidgetInfoInspector())
      ..register(WidgetDetailInspector())
      ..register(ColorSucker())
      ..register(AlignRuler())
      ..register(ColorPicker())                            // 新插件
      ..register(TouchIndicator())                         // 新插件
      ..register(Performance())
      ..register(ShowCode())
      ..register(MemoryInfoPage())
      ..register(CpuInfoPage())
      ..register(DeviceInfoPanel())
      ..register(Console());
    // flutter_ume 0.3.0 版本之后
    runApp(UMEWidget(child: MyApp(), enable: true)); // 初始化
  } else {
    runApp(const MyApp());
  }
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
