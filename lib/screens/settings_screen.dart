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
            setState(() {
              this.color = value;
            });
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
        SubmitButton(color: color, size: size)
      ]),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final Color color;
  final double size;

  const SubmitButton({@required this.color, @required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 70,
        width: 125,
        decoration: BoxDecoration(
            color: Colors.grey[800], borderRadius: BorderRadius.circular(12.5)),
        child: Center(
            child: FittedBox(
          fit: BoxFit.fill,
          child: Text('Submit',
              style: TextStyle(color: Colors.white, fontSize: 20.0)),
        )),
      ),
      onTap: () => Navigator.of(context).pop({'color': color, 'size': size}),
    );
  }
}
