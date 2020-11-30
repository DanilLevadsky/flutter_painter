import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Color color;
  final double size;

  const SettingsScreen({this.color, this.size});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Color color;
  double size;

  @override
  void initState() {
    super.initState();
    widget.color != null ? color = widget.color : color = Colors.black;
    widget.size != null ? size = widget.size : size = 3.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        ColorPicker(
          color: color,
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
            Navigator.of(context).pop({'color': color, 'size': size});
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
  }
}
