import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

class DigitalClock extends StatefulWidget {
  final DateTime now;
  final double maxWidth;
  final bool is24HourFormat;
  final Color color;
  DigitalClock(this.now,
      {@required this.is24HourFormat,
      @required this.maxWidth,
      @required this.color});

  @override
  State<StatefulWidget> createState() {
    return _DigitalClockState();
  }
}

class _DigitalClockState extends State<DigitalClock>
    with SingleTickerProviderStateMixin {
  Timer _timer;
  bool isClickOn = true;

  void _updateTime() {
    setState(() {
      isClickOn = !isClickOn;
      _timer = Timer(
        Duration(milliseconds: 500),
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
    final textStyle = TextStyle(
        color: widget.color,
        fontFamily: 'FakeHope',
        fontSize: widget.maxWidth * 0.07);
    final strutStyle = StrutStyle(fontSize: widget.maxWidth * 0.07);
    return ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Text(
                DateFormat(widget.is24HourFormat ? 'HH' : 'hh')
                    .format(widget.now),
                textDirection: TextDirection.ltr,
                strutStyle: strutStyle,
                style: textStyle,
              ),
              Text(":",
                  textDirection: TextDirection.ltr,
                  style: textStyle.copyWith(
                      color:
                          textStyle.color.withOpacity(isClickOn ? 0.7 : 0.5)),
                  strutStyle: strutStyle),
              Text(DateFormat('mm').format(widget.now),
                  textDirection: TextDirection.ltr,
                  style: textStyle,
                  strutStyle: strutStyle)
            ]));
  }
}
