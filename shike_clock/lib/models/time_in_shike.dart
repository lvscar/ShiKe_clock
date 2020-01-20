import 'dart:core';

class TimeInShiKe {
  static const shiList = <String>[
    '子',
    '丑',
    '寅',
    '卯',
    '辰',
    '巳',
    '午',
    '未',
    '申',
    '酉',
    '戌',
    '亥'
  ];
  static const keList = <String>['一', '二', '三', '四', '五', '六', '七', '八'];

  final DateTime dt;
  TimeInShiKe(this.dt);

  int get shiIndex {
    //The first Shi(时) of a day is 23:00 .
    var h = dt.hour + 1;
    if (h > 23) {
      h = 0;
    }
    var index = ((h) / 2).floor();
    return index;
  }

  String get shi {
    return shiList[shiIndex];
  }

  int get keIndex {
    //One Shi(时) is 8 Ke(刻)
    int index = (dt.minute / 15).floor() + ((dt.hour % 2) == 0 ? 4 : 0);
    return index;
  }

  String get ke {
    return keList[keIndex];
  }
}
