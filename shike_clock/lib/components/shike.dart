import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shike_clock/models/time_in_shike.dart';

class ShiKe extends StatefulWidget {
  final DateTime now;
  final TimeInShiKe shiKeInTime;
  final double maxWidth;
  final Color color;
  ShiKe({@required this.now, @required this.maxWidth, @required this.color})
      : shiKeInTime = TimeInShiKe(now);

  @override
  State<StatefulWidget> createState() {
    return _ShiKeState();
  }
}

class _ShiKeState extends State<ShiKe> with SingleTickerProviderStateMixin {
  Timer _timer;
  static const opacityList = <double>[0.5, 0.6, 0.7, 0.8];
  int opacityIndex = 0;
  bool forwardPass = true;

  void _updateTime() {
    setState(() {
      if (forwardPass) {
        if (opacityIndex < (opacityList.length - 1)) {
          opacityIndex += 1;
        } else {
          forwardPass = false;
        }
      } else {
        if (opacityIndex > 0) {
          opacityIndex -= 1;
        } else {
          forwardPass = true;
        }
      }

      _timer = Timer(
        Duration(seconds: 1),
        _updateTime,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final skStyleBigger = TextStyle(
        color: widget.color,
        fontFamily: 'I.Ngaan',
        fontSize: widget.maxWidth * (1 / 5));
    final skStyle = TextStyle(
        color: widget.color,
        fontFamily: 'I.Ngaan',
        fontSize: widget.maxWidth * (1 / 8));
    return Container(
        child: Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
          Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(widget.shiKeInTime.ke,
                  textDirection: TextDirection.ltr, style: skStyleBigger),
              Text("刻",
                  textDirection: TextDirection.ltr,
                  style: skStyle.copyWith(
                      color: widget.color.withOpacity(
                          opacityList[opacityList.length - 1 - opacityIndex]))),
            ],
          )),
          Container(
            child: Column(
              textDirection: TextDirection.ltr,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(widget.shiKeInTime.shi,
                    textDirection: TextDirection.ltr, style: skStyleBigger),
                Text("時",
                    textDirection: TextDirection.ltr,
                    style: skStyle.copyWith(
                        color: widget.color
                            .withOpacity(opacityList[opacityIndex])))
              ],
            ),
          )
        ]));
  }
}
