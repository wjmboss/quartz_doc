import 'package:flutter/material.dart';

import '../kits/toolkit.dart';
import '../markdown/markdown_component_type.dart';

import '../markdown_edit_page.dart';

class EditFragment extends StatefulWidget {
  final MarkdownEditPageState parent;
  EditFragment({
    @required this.parent,
  });
  @override
  _EditFragmentState createState() => _EditFragmentState();
}

class _EditFragmentState extends State<EditFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.parent.components.length,
        itemBuilder: (context, index) => Card(
          elevation: 15.0,  //设置阴影
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),
          child: ListTile(
            title: Text(ofString(widget.parent.components[index].type)),
            subtitle: Text("Markdown组件 #${index+1}"),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                widget.parent.setState(() {
                  askSheet(context, "您真的要删除这个组件吗?", () {
                    widget.parent.components.removeAt(index);
                    widget.parent.save();
                  });
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}