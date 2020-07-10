import 'package:flutter/material.dart';
import 'package:mollet/widgets/allWidgets.dart';

class OrderPlaced extends StatefulWidget {
  OrderPlaced({Key key}) : super(key: key);

  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  Widget build(BuildContext context) {
    return primaryContainer(
      Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
