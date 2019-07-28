import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../markdown/markdown_component_type.dart';

class MarkdownComponent extends StatefulWidget {
  final MarkdownComponentType type;
  final List<String> arguments;
  MarkdownComponent({
    @required this.type,
    this.arguments,
  });
  @override
  _MarkdownComponentState createState() => _MarkdownComponentState();
}

class _MarkdownComponentState extends State<MarkdownComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210.0,
      child: Card(
        elevation: 15.0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),
        child: Text(widget.type.toString())
      )
    );
  }
}