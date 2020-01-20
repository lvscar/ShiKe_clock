// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Updated by Bono Lv(lvscar@gmail.com) for ShiKe Clock. 2020-01-19
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:shike_clock/components/shike.dart';
import 'package:shike_clock/components/shike_circle_printer.dart';
import 'package:shike_clock/components/digital_clock.dart';
import 'package:shike_clock/components/weather.dart';
import 'package:shike_clock/components/birds.dart';

enum _Element {
  background,
  text,
}

final _lightTheme = {
  _Element.background: Color.fromRGBO(
      160, 160, 160, 1), //the color of shell of Lenovo Smart Clock.
  _Element.text: Colors.black87,
};

final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Colors.white70,
};

class ShiKeClock extends StatefulWidget {
  const ShiKeClock(this.model);

  final ClockModel model;

  @override
  _ShiKeClockState createState() => _ShiKeClockState();
}

class _ShiKeClockState extends State<ShiKeClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(ShiKeClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double maxWidth = (screenWidth / screenHeight > 5 / 3)
        ? (5 / 3) * screenHeight * 0.9
        : screenWidth * 0.9;

    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;

    return Container(
      color: colors[_Element.background],
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                width: maxWidth * 0.5,
                child:
                    Stack(alignment: Alignment.bottomLeft, children: <Widget>[
                  Birds(
                      now: _dateTime,
                      color: colors[_Element.text],
                      width: maxWidth * 0.1),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: CustomPaint(
                              painter: ShiKeInCircle(
                                  now: _dateTime,
                                  color: colors[_Element.text],
                                  brightness: Theme.of(context).brightness),
                              child: Center(
                                widthFactor: 3,
                                child: DigitalClock(_dateTime,
                                    is24HourFormat: widget.model.is24HourFormat,
                                    maxWidth: maxWidth,
                                    color: colors[_Element.text]),
                              ))),
                      Expanded(
                          child: WeatherInfo(widget.model,
                              color: colors[_Element.text], now: _dateTime))
                    ],
                  )
                ])),
            Container(
              width: maxWidth * 0.5,
              child: ShiKe(
                  now: _dateTime,
                  maxWidth: maxWidth,
                  color: colors[_Element.text]),
            ),
          ],
        ),
      ),
    );
  }
}
