import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class SettingsScreen extends StatefulWidget {
  final double size;
  final Color color;

  const SettingsScreen({this.size, this.color});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Color color;
  double size;

  @override
  void initState() {
    super.initState();
    if (widget.color == null) {
      color = Colors.black;
    }
    if (widget.size == null) {
      size = 3.0;
    }
    if (widget.color != null && widget.size != null) {
      size = widget.size;
      color = widget.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey[100],
          ),
          onPressed: () {
            Navigator.pop(context, {'color': color, 'size': size});
          },
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ListTile(
            leading: Icon(
              Icons.palette_outlined,
              color: Colors.black,
            ),
            title: Text(
              'Color',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Container(
              width: 20.0,
              height: 20.0,
              color: this.color,
            ),
            onTap: () {
              getColor();
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Divider(
              height: 9.0,
              thickness: 1.5,
              color: Colors.black,
            ),
          ),
          Slider(
            value: size,
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

          )
        ],
      ),
    );
  }

  void getColor() {
    showMaterialColorPicker(
        headerColor: Colors.grey[800],
        buttonTextColor: Colors.black,
        context: context,
        selectedColor: color,
        onChanged: (value) {
          setState(() {
            this.color = value;
          });
        });
  }
}
