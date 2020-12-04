import 'dart:io';
import 'dart:ui';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:painter/screens/canvas_screen.dart';

void main() async {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: CanvasScreen()));
  if (ifDesktop) {
    await DesktopWindow.setMinWindowSize(Size(800, 600));
    await DesktopWindow.setMaxWindowSize(Size(1440, 1024));
  }
}

bool ifDesktop = (Platform.isMacOS || Platform.isLinux || Platform.isWindows);
