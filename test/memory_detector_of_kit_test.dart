import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memory_detector_of_kit/leak_info.dart';
import 'package:memory_detector_of_kit/memory_detector.dart';
import 'package:memory_detector_of_kit/memory_detector_of_kit.dart';

HashMap leaker = HashMap();

void main() {

  test('test detector', () async {

    String key = leaker.hashCode.toString();
    defaultHandler = (LeakedInfo info) {
      debugPrint(info.toString());
      expect(info.retainingPathJson.length, inInclusiveRange(1, double.infinity));
    };
    Completer completer = Completer();

    WidgetsFlutterBinding.ensureInitialized();
    MemoryDetectorOfKit().addObject(obj: leaker, group: key);
    await Future.delayed(const Duration(seconds: 3));
    MemoryDetectorOfKit().doDetect(key);
    MemoryDetectorOfKit().taskPhaseStream.listen((event) async {
      TaskPhase phase = event.phase;
      debugPrint('phase : $phase');
      expect(phase.index, inInclusiveRange(0, 5));
      if(phase == TaskPhase.endDetect) {
        completer.complete();
      }
    });
    return completer.future;
  });

}


