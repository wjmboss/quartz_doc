import 'dart:io';

import 'package:file_picker/file_picker.dart' as picker_plugin;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart' as pdf_plugin;
import 'package:pdf/widgets.dart' as pdf_plugin;

import 'kits/toolkit.dart';
import 'markdown_edit_page.dart';
import 'pdf_edit_page.dart';
import 'structures/document_type.dart';
import 'text_edit_page.dart';

class QuartzPage extends StatefulWidget {
  final Directory workDirectory;
  final bool showAppBar;
  final bool supportFilePicker;
  QuartzPage({
    this.showAppBar = true,
    this.supportFilePicker = true,
    @required this.workDirectory,
  });
  _QuartzPageState createState() => _QuartzPageState();
}

class _QuartzPageState extends State<QuartzPage> {
  TextField field(String label, Widget icon, String suffix, int key) {
    final ctrlr = TextEditingController();
    map[key] = ctrlr;
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon,
        suffix: Padding(
          padding: EdgeInsets.only(right: 20),
          child: Text(suffix),
        ),
      ),
      controller: ctrlr,
    );
  }
  final map = Map<int, TextEditingController>();
  final files = List<File>();
  @override
  void initState() {
    super.initState();
    files.clear();
    if (!widget.workDirectory.existsSync()) {
      widget.workDirectory.createSync(recursive: true);
    }
    List<FileSystemEntity> documents = widget.workDirectory.listSync();
    if (documents.length==0) {
      files.add(null);
    } else {
      for (var i in documents) {
        if (FileSystemEntity.isDirectorySync(i.path)) {
          continue;
        } else {
          final file = File(i.path);
          files.add(file);
        }
      }
    }
  }
  @override
  Widget build(BuildContext buildContext) {
    if (files.length==0) {
      files.add(null);
    }
    return Scaffold(
      appBar: widget.showAppBar?AppBar(
        title: Text("QuartzDoc 石英文档"),
      ):null,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.add),
        tooltip: "创建文档",
        onPressed: () {
          showModalBottomSheet(
              context: buildContext,
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.text_fields),
                    title: Text("文本文档(.txt)"),
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                          context: buildContext,
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              field("文件名", Icon(Icons.translate), ".txt", 0),
                              ButtonBar(
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
                                    child: Text("创建"),
                                    onPressed: () {
                                      File txt = File("${widget.workDirectory.path}/${map[0].text}.txt");
                                      if (txt.existsSync()) {
                                        tipsSheet(buildContext, "该文件已存在");
                                      } else {
                                        Navigator.pop(context);
                                        setState(() {
                                          final index = files.indexOf(null);
                                          if (index!=-1) {
                                            files.removeAt(index);
                                          }
                                          txt.createSync();
                                          files.add(txt);
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.picture_as_pdf),
                    title: Text("可携式文件格式(.pdf)"),
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                        context: buildContext,
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            field("文件名", Icon(Icons.translate), ".pdf", 0),
                            ButtonBar(
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
                                  child: Text("创建"),
                                  onPressed: () {
                                    File pdf = File("${widget.workDirectory.path}/${map[0].text}.pdf");
                                    if (pdf.existsSync()) {
                                      tipsSheet(buildContext, "该文件已存在");
                                    } else {
                                      Navigator.pop(context);
                                      setState(() {
                                        final index = files.indexOf(null);
                                        if (index!=-1) {
                                          files.removeAt(index);
                                        }
                                        pdf.createSync();
                                        final doc = pdf_plugin.Document();
                                        doc.addPage(pdf_plugin.Page(
                                          pageFormat: pdf_plugin.PdfPageFormat.a4,
                                          build: (context) => pdf_plugin.Stack(
                                            fit: pdf_plugin.StackFit.expand,
                                            children: <pdf_plugin.Widget>[
                                              pdf_plugin.Positioned(
                                                left: 0,
                                                top: 0,
                                                child: pdf_plugin.Text("Hello, World!"),
                                              ),
                                            ]
                                          ),
                                        ));
                                        pdf.writeAsBytesSync(doc.save());
                                        files.add(pdf);
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.text_format),
                    title: Text("Markdown富文本(.md)"),
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                        context: buildContext,
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            field("文件名", Icon(Icons.translate), ".md", 0),
                            ButtonBar(
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
                                  child: Text("创建"),
                                  onPressed: () {
                                    File md = File("${widget.workDirectory.path}/${map[0].text}.md");
                                    if (md.existsSync()) {
                                      tipsSheet(buildContext, "该文件已存在");
                                    } else {
                                      Navigator.pop(context);
                                      setState(() {
                                        final index = files.indexOf(null);
                                        if (index!=-1) {
                                          files.removeAt(index);
                                        }
                                        md.createSync();
                                        files.add(md);
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.open_in_new),
                    title: Text("打开已有文件"),
                    onTap: () async {
                      if (!widget.supportFilePicker) {
                        Navigator.pop(context);
                        tipsSheet(buildContext, "您的操作系统暂不支持从外部打开文件");
                      } else {
                        Navigator.pop(context);
                        final path = await picker_plugin.FilePicker.getFilePath(type: picker_plugin.FileType.ANY);
                        if (path!=null) {
                          final file = File(path);
                          final name = getFileName(file);
                          if (name.endsWith(".pdf")) {
                            open(file, DocumentType.PDF);
                          } else if (name.endsWith(".md")) {
                            open(file, DocumentType.MD);
                          } else if (name.endsWith("txt")) {
                            open(file, DocumentType.TXT);
                          } else {
                            tipsSheet(buildContext, "暂不支持此类文件");
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
          );
        },
      ),
      body: ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          if (files[index]==null) {
            return Text("您还没有任何文档,\n请点击右下方按钮新建一个", style: TextStyle(
              fontSize: 20,
            ),);
          } else {
            final file = files[index];
            final name = getFileName(file);
            return ListTile(
              leading: Icon(Icons.folder),
              title: Text(name),
              onTap: () {
                if (name.endsWith(".pdf")) {
                  open(file, DocumentType.PDF);
                } else if (name.endsWith(".md")) {
                  open(file, DocumentType.MD);
                } else if (name.endsWith("txt")) {
                  open(file, DocumentType.TXT);
                } else {
                  tipsSheet(context, "暂不支持此类文件");
                }
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.translate),
                        Text("重命名")
                      ],
                    ),
                    onTap: () {
                      textSheet(context, "请输入新文件名", "新文件名", Icons.translate, (data) {
                        setState(() {
                          final index = files.indexOf(file);
                          files.removeAt(index);
                          final newFile = file.renameSync(stringList2string("/", file.path.split("/")..removeLast()..add(data)));
                          files.insert(index, newFile);
                        });
                      }, getFileName(file));
                    },
                  ),
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.delete),
                        Text("删除"),
                      ],
                    ),
                    onTap: () {
                      askSheet(context, "确定要删除这个文件吗？", () {
                        setState(() {
                          files.remove(file);
                          file.deleteSync();
                        });
                      });
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
  void open(File file, DocumentType type) {
    switch (type) {
      case DocumentType.TXT:
        push(context, TextEditPage(file: file,));
        break;
      case DocumentType.PDF:
        push(context, PdfEditPage(file: file,));
        break;
      case DocumentType.MD:
        push(context, MarkdownEditPage(file: file,));
        break;
    }
  }
}