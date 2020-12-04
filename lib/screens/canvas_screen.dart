import 'dart:io';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:painter/services/group_points.dart';
import 'package:painter/services/painter.dart';
import 'package:screenshot/screenshot.dart';

import '../services/bar_button.dart';
import 'settings_screen.dart';

class CanvasScreen extends StatefulWidget {
  @override
  _CanvasScreenState createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  List<GroupPoints> points = <GroupPoints>[];
  double size = 3.0;
  Color color = Colors.black;
  Painter _painter;
  ScreenshotController controller;

  @override
  void initState() {
    controller = ScreenshotController();
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
              icon: Icon(
                Icons.save,
                color: Colors.grey[100],
              ),
              onPressed: () {
                File _imageFile;
                controller.capture().then((File image) {
                  setState(() {
                    _imageFile = image;
                  });
                }).catchError((onError) {
                  print(onError);
                });
              })
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
                    builder: (context) =>
                        SettingsScreen(color: color, size: size)));
            this.color = settings['color'];
            this.size = settings['size'];
          },
        ),
      ),
      body: Screenshot(
        controller: controller,
        child: InteractiveViewer(
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
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void settings() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ColorPicker(
                    onColorChanged: (value) {
                      this.color = value;
                    },
                  ),
                  Slider(
                    value: size,
                    onChangeStart: (value) {
                      setState(() {
                        size = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        size = value;
                      });
                    },
                    min: 1.0,
                    max: 15.0,
                    divisions: 15,
                    inactiveColor: Colors.white,
                    activeColor: Color.fromARGB(255, 100, 100, 100),
                    label: 'Size',
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        margin: EdgeInsets.all(8.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 30.0, color: Colors.white),
                        )),
                    color: Colors.grey[800],
                    padding: EdgeInsets.all(8.0),
                  )
                ]),
          );
        });
  }
}
