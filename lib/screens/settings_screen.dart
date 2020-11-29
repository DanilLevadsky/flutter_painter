import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Color color;
  double size;

  @override
  void initState() {
    super.initState();
    if (color == null) {
      color = Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
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
          FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            color: Colors.grey[800],
            textColor: Colors.white,
            child: Text('Submit'),
            onPressed: () {
              print('color: $color');
              Navigator.pop(context, color);
            },
          )
        ],
      ),
    );
  }
}
