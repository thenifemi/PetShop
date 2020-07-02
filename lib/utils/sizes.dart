import 'package:flutter/cupertino.dart';

BuildContext context;

var size = MediaQuery.of(context).size;

final double itemHeight = size.height / 2.5;
final double itemWidth = size.width / 2;

double picHeight() {
  double _picHeight;
  if (itemHeight >= 315) {
    _picHeight = itemHeight / 2;
    return _picHeight;
  } else if (itemHeight <= 315 && itemHeight >= 280) {
    _picHeight = itemHeight / 2.2;
    return _picHeight;
  } else if (itemHeight <= 280 && itemHeight >= 200) {
    _picHeight = itemHeight / 2.7;
    return _picHeight;
  } else {
    _picHeight = 30;
    return _picHeight;
  }
}
