import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'kits/toolkit.dart';
import 'markdown/the_markdown.dart';

import 'markdown/edit_fragment.dart';
import 'markdown/text_select_sheet.dart';
import 'markdown/markdown_component.dart';
import 'markdown/markdown_component_type.dart';

class MarkdownEditPage extends StatefulWidget {
  final File file;
  MarkdownEditPage({
    @required this.file,
  });
  @override
  MarkdownEditPageState createState() => MarkdownEditPageState();
}

class MarkdownEditPageState extends State<MarkdownEditPage> {
  String source = "";
  TheMarkdown md = TheMarkdown();
  List<MarkdownComponent> components;
  @override
  Widget build(BuildContext context) {
    source = widget.file.readAsStringSync();
    components = render();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(getFileName(widget.file)),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(Icons.subtitles, color: Colors.white,),
                      onTap: () async {
                        final result = await showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(0.0, 130.0, 0.0, 0.0),
                            items: <PopupMenuEntry<int>>[
                              PopupMenuItem(value: 0, child: Text("大标题"),),
                              PopupMenuItem(value: 1, child: Text("中标题"),),
                              PopupMenuItem(value: 2, child: Text("小标题"),),
                            ],
                        );
                        if (result==0) {
                          textSheet(context, "请输入标题", "标题", Icons.subtitles, (data) => setState(() {
                            append(MarkdownComponent(type: MarkdownComponentType.BIG_TITLE, arguments: [data],));
                            save();
                          }));
                        } else if (result==1) {
                          textSheet(context, "请输入标题", "标题", Icons.subtitles, (data) => setState(() {
                            append(MarkdownComponent(type: MarkdownComponentType.MEDIUM_TITLE, arguments: [data],));
                            save();
                          }));
                        } else if (result==2) {
                          textSheet(context, "请输入标题", "标题", Icons.subtitles, (data) => setState(() {
                            append(MarkdownComponent(type: MarkdownComponentType.SMALL_TITLE, arguments: [data],));
                            save();
                          }));
                        }
                      },
                    ),
                    GestureDetector(
                      child: Icon(Icons.format_quote, color: Colors.white,),
                      onTap: () {
                        textSheet(context, "请输入引用块内容", "引用块内容", Icons.format_quote, (data) {
                          setState(() {
                            append(MarkdownComponent(type: MarkdownComponentType.QUOTE, arguments: [data.replaceAll("\n\n", "\n")],));
                            save();
                          });
                        }, "", true);
                      },
                    ),
                    GestureDetector(
                      child: Icon(Icons.list, color: Colors.white,),
                      onTap: () {
                        textSheet(context, "请输入列表项名称", "列表项名称", Icons.list, (data) {
                          setState(() {
                            append(MarkdownComponent(type: MarkdownComponentType.LIST_ITEM, arguments: [data],));
                            save();
                          });
                        });
                      },
                    ),
                    GestureDetector(
                      child: Icon(Icons.title, color: Colors.white,),
                      onTap: () {
                        final ctrlr = TextEditingController();
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => TextSelectSheet(parent: this, ctrlr: ctrlr,),
                        );
                      },
                    ),
                    GestureDetector(
                      child: Icon(Icons.link, color: Colors.white,),
                      onTap: () {
                        doubleTextSheet(context, "请输入链接文本及地址", "链接文本", Icons.text_fields, "链接地址", Icons.link, (data0, data1) {
                          setState(() {
                            append(MarkdownComponent(type: MarkdownComponentType.LINK, arguments: [data0, data1],));
                            save();
                          });
                        }, "");
                      },
                    ),
                    GestureDetector(
                      child: Icon(Icons.linear_scale, color: Colors.white,),
                      onTap: () {
                        askSheet(context, "要添加分割线吗?", () {
                          setState(() {
                            append(MarkdownComponent(type: MarkdownComponentType.SPLIT_LINE,));
                            save();
                          });
                        });
                      },
                    ),
                    GestureDetector(
                      child: Icon(Icons.code, color: Colors.white,),
                      onTap: () async {
                        final result = await showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(0.0, 130.0, 0.0, 0.0),
                          items: <PopupMenuEntry<int>>[
                            PopupMenuItem(value: 0, child: Text("单行代码块"),),
                            PopupMenuItem(value: 1, child: Text("多行代码块"),),
                          ],
                        );
                        if (result==0) {
                          textSheet(context, "请输入代码", "Code", Icons.code, (data) {
                            setState(() {
                              append(MarkdownComponent(type: MarkdownComponentType.CODE_BLOCK, arguments: [data],));
                              save();
                            });
                          });
                        } else if (result==1) {
                          textSheet(context, "请输入代码", "Code", Icons.code, (data) {
                            setState(() {
                              append(MarkdownComponent(type: MarkdownComponentType.MULTI_LINE_CODE_BLOCK, arguments: [data],));
                              save();
                            });
                          }, "", true);
                        }
                      },
                    ),
                    GestureDetector(
                      child: Icon(Icons.playlist_add_check, color: Colors.white,),
                      onTap: () {
                        textSheet(context, "请输入复选框内容", "复选框内容", Icons.list, (data) {
                          setState(() {
                            append(MarkdownComponent(type: MarkdownComponentType.CHECK_BOX, arguments: [data],));
                            save();
                          });
                        });
                      },
                    ),
                    GestureDetector(
                      child: Icon(Icons.functions, color: Colors.white,),
                      onTap: () {
                        //TODO 编辑公式
                      },
                    ),
                  ],
                ),
                TabBar(
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.text_format),
                      text: "效果",
                    ),
                    Tab(
                      icon: Icon(Icons.edit),
                      text: "编辑",
                    ),
                    Tab(
                      icon: Icon(Icons.translate),
                      text: "文本",
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
            Markdown(data: source),
            EditFragment(parent: this),
            SingleChildScrollView(child: Text(source),),
            Text("设置")
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10),
              ),
              Text("${components.length} 组件", style: TextStyle(color: Colors.white),),
              Expanded(
                child: Text(""),
              ),
              Text("Markdown编辑器", style: TextStyle(color: Colors.white),),
              Padding(
                padding: EdgeInsets.only(left: 10),
              ),
            ],
          ),
        ),
      )
    );
  }
  void append(MarkdownComponent comp) => components.add(comp);
  List<MarkdownComponent> render() => md.render(source);
  void save() => widget.file.writeAsStringSync(md.save(components));
}