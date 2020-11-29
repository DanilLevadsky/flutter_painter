
import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {
  final Function onPressed;
  final Icon icon;

  BarButton({this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return FlatButton(minWidth: 75.0, child: icon, onPressed: onPressed);
  }
}