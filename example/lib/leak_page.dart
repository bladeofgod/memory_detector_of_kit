import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 作者：李佳奇
/// 日期：2022/4/22
/// 备注：泄露测试页面

///泄露widget
class LeakPage1 extends StatefulWidget{
  const LeakPage1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LeakPage1State();
  }

}

class LeakPage1State extends State<LeakPage1> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, widget);
          },
          child: const Text('pop'),
        ),
      ),
    );
  }
}


///泄露state
class LeakPage2 extends StatefulWidget{
  const LeakPage2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LeakPage2State();
  }

}

class LeakPage2State extends State<LeakPage2> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, this);
          },
          child: const Text('pop'),
        ),
      ),
    );
  }
}


///泄露context
class LeakPage3 extends StatefulWidget{
  const LeakPage3({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LeakPage3State();
  }

}

class LeakPage3State extends State<LeakPage3> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, context);
          },
          child: const Text('pop'),
        ),
      ),
    );
  }
}

///stateless 泄露
class LeakPage4 extends StatelessWidget{
  const LeakPage4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, this);
          },
          child: const Text('pop'),
        ),
      ),
    );
  }
}















