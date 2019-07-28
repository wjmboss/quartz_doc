import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

import 'package:pdf/pdf.dart' as pdf_plugin;
import 'package:pdf/widgets.dart' as pdf_plugin;

import 'kits/toolkit.dart';

class PdfEditPage extends StatefulWidget {
  final File file;
  PdfEditPage({
    @required this.file,
  });
  @override
  _PdfEditPageState createState() => _PdfEditPageState();
}

class _PdfEditPageState extends State<PdfEditPage> {
  PDFDocument document;
  var isLoading = true;
  @override
  void initState() {
    super.initState();
    load();
  }
  void load() async {
    document = await PDFDocument.fromFile(widget.file);
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(getFileName(widget.file)),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 50),
                    ),
                    GestureDetector(
                      child: Text("新建页面", style: TextStyle(color: Colors.white),),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    GestureDetector(
                      child: Text("删除页面", style: TextStyle(color: Colors.white),),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    GestureDetector(
                      child: Text("置入", style: TextStyle(color: Colors.white),),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    GestureDetector(
                      child: Text("编辑", style: TextStyle(color: Colors.white),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50),
                    ),
                  ],
                ),
                TabBar(
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.picture_as_pdf),
                      text: "效果",
                    ),
                    Tab(
                      icon: Icon(Icons.picture_as_pdf),
                      text: "编辑",
                    ),
                    Tab(
                      icon: Icon(Icons.settings),
                      text: "设置",
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            isLoading?
            Center(
              child: CircularProgressIndicator(),
            ):
            PDFViewer(document: document),
            Text("编辑"),
            Text("设置"),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10),
              ),
              Text(" 0 组件", style: TextStyle(color: Colors.white),),
              Expanded(
                child: Text(""),
              ),
              Text("PDF编辑器 ", style: TextStyle(color: Colors.white),),
              Padding(
                padding: EdgeInsets.only(left: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}