import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void tipsSheet(BuildContext context, String tip, [VoidCallback onOkClicked]) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(tip),
        ButtonBar(
          alignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("好"),
              onPressed: () {
                if (onOkClicked!=null) {
                  onOkClicked();
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    ),
  );
}

void textSheet(BuildContext context, String tip, String label, IconData iconData, Function(String data) callback, [String src = ""]) {
  final ctrlr = TextEditingController();
  ctrlr.text = src;
  showModalBottomSheet(
    context: context,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(tip),
        TextField(
          controller: ctrlr,
          decoration: InputDecoration(
            prefixIcon: Icon(iconData),
            labelText: label,
          ),
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
                callback(ctrlr.text);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    ),
  );
}

void doubleTextSheet(BuildContext context, String tip, String label0, IconData iconData0, String label1, IconData iconData1, Function(String data0, String data1) callback, [String src0 = "", String src1 = ""]) {
  final ctrlr0 = TextEditingController();
  ctrlr0.text = src0;
  final ctrlr1 = TextEditingController();
  ctrlr1.text = src1;
  showModalBottomSheet(
    context: context,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(tip),
        TextField(
          controller: ctrlr0,
          decoration: InputDecoration(
            prefixIcon: Icon(iconData0),
            labelText: label0,
          ),
        ),
        TextField(
          controller: ctrlr1,
          decoration: InputDecoration(
            prefixIcon: Icon(iconData1),
            labelText: label1,
          ),
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
                callback(ctrlr0.text, ctrlr1.text);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    ),
  );
}

void askSheet(BuildContext context, String tip, VoidCallback ok) {
  showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(tip),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("不了"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                VerticalDivider(),
                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("好"),
                  onPressed: () {
                    ok();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      }
  );
}

void push(BuildContext context, Widget widget) => Navigator.push(context, MaterialPageRoute(
  builder: (context) => widget,
));

String getFileName(File file) => file.path.split("/").last;

String stringList2string(String split, List<String> list) {
  final sb = StringBuffer();
  for (var i in list) {
    sb.write(i);
    sb.write(split);
  }
  return sb.toString().substring(0, sb.length-split.length);
}
