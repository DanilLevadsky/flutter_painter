import 'package:flutter/material.dart';
import 'package:painter/screens/settings_screen.dart';
import 'package:painter/services/group_points.dart';
import 'package:painter/services/painter.dart';

import '../services/bar_button.dart';

class CanvasScreen extends StatefulWidget {
  @override
  _CanvasScreenState createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  List<GroupPoints> points = <GroupPoints>[];
  double size = 3.0;
  Color color = Colors.black;
  Painter _painter;

  @override
  void initState() {
    super.initState();
    if (_painter != null) {
      setState(() {
        _painter.color = this.color;
        _painter.size = this.size;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _painter = Painter(size: size, points: points, color: color);
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
                points.clear();
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
            var settings = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsScreen(
                          size: size,
                          color: color,
                        )));
            setState(() {
              this.color = settings['color'];
              this.size = settings['size'];
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
              points.add(GroupPoints(
                  offset: details.localPosition, color: color, size: size));
            });
          },
          onPanUpdate: (details) {
            setState(() {
              points.add(GroupPoints(
                  offset: details.localPosition, color: color, size: size));
            });
          },
          onPanEnd: (details) {
            setState(() {
              points.add(GroupPoints(offset: null, color: color, size: size));
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
