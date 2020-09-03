import 'package:flutter/material.dart';
import 'package:mollet/model/data/Products.dart';

class SeeMoreScreen extends StatefulWidget {
  final ProdProducts products;
  SeeMoreScreen({Key key, this.products}) : super(key: key);

  @override
  _SeeMoreScreenState createState() => _SeeMoreScreenState(products);
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  final ProdProducts products;
  _SeeMoreScreenState(this.products);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
