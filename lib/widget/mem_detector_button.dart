import 'package:flutter/material.dart';

import '../leak_info.dart';
import '../memory_detector.dart';
import '../memory_detector_of_kit.dart';
import 'leaked_info_page.dart';
import 'popup_window.dart';

/// 作者：李佳奇
/// 日期：2022/4/25
/// 备注：泄露信息入口按钮
class RikiMemDetectorButton extends StatefulWidget{
  const RikiMemDetectorButton({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RikiMemDetectorButtonState();
  }

}

class RikiMemDetectorButtonState extends State<RikiMemDetectorButton> {

  List<LeakedInfo> cache = [];

  double btnLeft = 10;
  double btnTop = 200;

  void _dragUpdate(DragUpdateDetails details) {
    setState(() {
      btnLeft += details.delta.dx;
      btnTop += details.delta.dy;
    });
  }

  @override
  void initState() {
    super.initState();
    MemoryDetectorOfKit().infoStream.listen((event) {
      cache.add(event!);
    });
  }

  @override
  Widget build(BuildContext context) {
    const double btnWidth = 48;
    final Size size = MediaQuery.of(context).size;
    return Positioned(
      left: btnLeft.clamp(0, size.width-btnWidth),
      top: btnTop.clamp(0, size.height-btnWidth),
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () async {
            if(cache.isEmpty) return;
            await MemDetectorPopupWindow.showBottomDrawer(context, LeakedInfoPage(leakInfoList: cache,));
            cache.clear();
            setState(() {

            });
          },
          onPanUpdate: _dragUpdate,
          child: Container(
            width: btnWidth, height: btnWidth,
            //padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue
            ),
            child: StreamBuilder(
              stream: MemoryDetectorOfKit().taskPhaseStream,
              builder: (BuildContext context, AsyncSnapshot<DetectTaskEvent> snapshot) {
                if(snapshot.data?.phase == null) return const Icon(Icons.remove_red_eye_outlined, color: Colors.white, size: 40,);
                final double progress = ((snapshot.data!.phase.index+1) / 6) * 100;
                switch(snapshot.data!.phase) {
                  case TaskPhase.startDetect:
                  case TaskPhase.startGC:
                  case TaskPhase.endGC:
                  case TaskPhase.startAnalyze:
                  case TaskPhase.endAnalyze:
                    return Text('${progress.toInt()}%', style: const TextStyle(color: Colors.white, fontSize: 18),);
                  case TaskPhase.endDetect:
                    if(cache.isEmpty) {
                      return const Icon(Icons.remove_red_eye_outlined, color: Colors.white, size: 40,);
                    } else {
                      return const Icon(Icons.system_security_update_warning_rounded, color: Colors.red,);
                    }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

















