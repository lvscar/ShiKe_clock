import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shike_clock/models/time_in_shike.dart';

class Birds extends StatelessWidget {
  final DateTime now;
  final TimeInShiKe shiKeInTime;
  final Color color;
  final double width;
  static final birdsPositions = [
    [0.2, 0.1],
    [0.4, 0.3],
    [0.6, 0.5],
    [0.8, 0.7],
    [1, 0.9],
    [1.2, 1.1],
    [1.4, 1.3],
    [1.6, 1.5],
    [1.8, 1.7],
    [1.85, 2],
    [1.85, 2.5],
    [1.7, 2.7]
  ];
  Birds({@required this.now, @required this.color, @required this.width})
      : shiKeInTime = TimeInShiKe(now);

  @override
  Widget build(BuildContext context) {
    final positionIndex = shiKeInTime.shiIndex;
    final birdPosition = birdsPositions[positionIndex];
    return Positioned(
        bottom: width * birdPosition[0],
        left: width * birdPosition[1],
        child: Container(
            width: width,
            height: width * 0.7,
            child: Stack(alignment: Alignment.topRight, children: <Widget>[
              Positioned(
                right: 0,
                width: width / 5,
                child: SvgPicture.asset('assets/icons/bird0.svg',
                    width: width / 5, color: color),
              ),
              Positioned(
                left: 0 + (width / 24 * positionIndex),
                width: width / 5,
                child: SvgPicture.asset('assets/icons/bird1.svg',
                    width: width / 5, color: color),
              ),
              Positioned(
                left: width / 2 + (width / 64 * positionIndex),
                top: width * 0.35 - (width * 0.35 / 15 * positionIndex),
                width: width / 5,
                child: SvgPicture.asset('assets/icons/bird2.svg',
                    width: width / 5, color: color),
              ),
              Positioned(
                left: 0 + (width / 24 * positionIndex),
                bottom: 0 + (width / 24 * positionIndex),
                width: width / 5,
                child: SvgPicture.asset('assets/icons/bird3.svg',
                    width: width / 5, color: color),
              )
            ])));
  }
}
