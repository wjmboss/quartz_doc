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
          elevation: 15.0,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),
          child: ListTile(
            title: Text(widget.parent.components[index].type==MarkdownComponentType.SPLIT_LINE?"---分割线---":stringList2string(" => ", widget.parent.components[index].arguments)),
            subtitle: Text("Markdown组件 #${index+1} ${ofString(widget.parent.components[index].type)}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.edit),
                  onTap: () {
                    final comp = widget.parent.components[index];
                    if (comp.type==MarkdownComponentType.LINK) {
                      doubleTextSheet(context, "请输入修改过后的内容", "链接文本", Icons.text_fields, "链接地址", Icons.link, (text0, text1) {
                        widget.parent.setState(() {
                          comp.arguments[0] = text0;
                          comp.arguments[1] = text1;
                          widget.parent.save();
                        });
                      }, comp.arguments[0], comp.arguments[1]);
                    } else {
                      textSheet(context, "请输入修改过后的内容", "内容", Icons.content_paste, (text) {
                        widget.parent.setState(() {
                          comp.arguments[0] = text;
                          widget.parent.save();
                        });
                      }, comp.arguments[0], comp.type==MarkdownComponentType.QUOTE?true:null);
                    }
                  },
                ),
                GestureDetector(
                  child: Icon(Icons.delete),
                  onTap: () {
                    askSheet(context, "您真的要删除这个组件吗?", () {
                      widget.parent.setState(() {
                        widget.parent.components.removeAt(index);
                        widget.parent.save();
                      });
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}