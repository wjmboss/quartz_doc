import 'package:flutter/material.dart';

import '../markdown/markdown_component.dart';
import '../markdown/markdown_component_type.dart';

import '../markdown_edit_page.dart';

class TextSelectSheet extends StatefulWidget {
  final MarkdownEditPageState parent;
  final TextEditingController ctrlr;
  TextSelectSheet({
    @required this.parent,
    @required this.ctrlr,
  });
  @override
  _TextSelectSheetState createState() => _TextSelectSheetState();
}

class _TextSelectSheetState extends State<TextSelectSheet> {
  var isItalicChecked = false;
  var isBoldChecked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("请输入文本内容"),
        TextField(
          controller: widget.ctrlr,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.title),
            labelText: "文本内容",
          ),
        ),
        Row(
          children: <Widget>[
            Text("斜体"),
            Checkbox(
              value: isItalicChecked,
              activeColor: Colors.blue,
              onChanged: (bool boolean) {
                setState(() => isItalicChecked = boolean,);
              },
            ),
            Text("粗体"),
            Checkbox(
              value: isBoldChecked,
              activeColor: Colors.blue,
              onChanged: (bool boolean) {
                setState(() => isBoldChecked = boolean,);
              },
            ),
          ],
        ),
        ButtonBar(
          alignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("取消"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("好"),
              onPressed: () {
                widget.parent.setState(() {
                  if (isItalicChecked&&!isBoldChecked) {
                    widget.parent.append(MarkdownComponent(type: MarkdownComponentType.ITALIC_TEXT, arguments: [widget.ctrlr.text],));
                  } else if (isBoldChecked&&!isItalicChecked) {
                    widget.parent.append(MarkdownComponent(type: MarkdownComponentType.BOLD_TEXT, arguments: [widget.ctrlr.text],));
                  } else if (isBoldChecked&&isItalicChecked) {
                    widget.parent.append(MarkdownComponent(type: MarkdownComponentType.BOLD_ITALIC_TEXT, arguments: [widget.ctrlr.text],));
                  } else {
                    widget.parent.append(MarkdownComponent(type: MarkdownComponentType.TEXT, arguments: [widget.ctrlr.text],));
                  }
                  widget.parent.save();
                });
                isBoldChecked = false;
                isItalicChecked = false;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}