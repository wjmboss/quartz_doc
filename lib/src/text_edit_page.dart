import 'dart:io';

import 'package:flutter/material.dart';

import 'kits/toolkit.dart';

class TextEditPage extends StatefulWidget {
  final File file;
  TextEditPage({
    this.file
  });
  @override
  _TextEditPageState createState() => _TextEditPageState();
}

class _TextEditPageState extends State<TextEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getFileName(widget.file)),
      ),
    );
  }
}