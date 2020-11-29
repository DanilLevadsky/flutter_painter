
import 'package:flutter/material.dart';
import 'package:painter/screens/settings_screen.dart';
import 'package:painter/services/painter.dart';

import '../services/bar_button.dart';


class CanvasScreen extends StatefulWidget {
  @override
  _CanvasScreenState createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  final _offsets = <Offset>[];
  double size = 3.0;
  Color color = Colors.black;
  Painter _painter;

  @override
  void initState(){
    super.initState();
    if (_painter != null) {
      setState(() {
        _painter.color = this.color;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _painter = Painter(size: size, offsets: _offsets, color: color);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        actions: [
          BarButton(
            icon: Icon(
              Icons.clear,
              color: Colors.grey[100],
            ),
            onPressed: () {
              setState(() {
                _offsets.clear();
              });
            },
          ),
          BarButton(
            icon: Icon(Icons.save, color: Colors.grey[100]),
            onPressed: () {
              //TODO: implement saving file
            },
          )
        ],
        backgroundColor: Colors.grey[800],
        title: null,
        leading: BarButton(
          icon: Icon(
            Icons.brush,
            color: Colors.grey[100],
          ),
          onPressed: () async {
            var settings = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsScreen()));
            setState(() {
              this.color = settings;
            });
          },
        ),
      ),
      body: InteractiveViewer(
        minScale: 1.0,
        maxScale: 15.0,
        child: GestureDetector(
          onPanDown: (details) {
            setState(() {
              _offsets.add(details.localPosition);
            });
          },
          onPanUpdate: (details) {
            setState(() {
              print(this.color.toString());
              _offsets.add(details.localPosition);
            });
          },
          onPanEnd: (details) {
            setState(() {
              _offsets.add(null);
            });
          },
          child: Center(
            child: CustomPaint(
              painter: _painter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
      ),
    );
  }
}