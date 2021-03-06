import '../markdown/markdown_component.dart';
import '../markdown/markdown_component_type.dart';

class TheMarkdown {
  List<MarkdownComponent> render(String source) {
    final list = List<MarkdownComponent>();
    for (final comp in source.split("\n\n")) {
      if (comp!=""&&comp!=null) {
        if (comp=="---") {
          list.add(MarkdownComponent(type: MarkdownComponentType.SPLIT_LINE,));
          continue;
        }
        final matchesSmallTitle = RegExp("### (.*)").firstMatch(comp);
        if (matchesSmallTitle!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.SMALL_TITLE, arguments: [matchesSmallTitle.group(1)],));
          continue;
        }
        final matchesMediumTitle = RegExp("## (.*)").firstMatch(comp);
        if (matchesMediumTitle!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.MEDIUM_TITLE, arguments: [matchesMediumTitle.group(1)],));
          continue;
        }
        final matchesBigTitle = RegExp("# (.*)").firstMatch(comp);
        if (matchesBigTitle!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.BIG_TITLE, arguments: [matchesBigTitle.group(1)],));
          continue;
        }
        final matchesQuote = RegExp("> (.*)").firstMatch(comp.replaceAll("\n", "<br>"));
        if (matchesQuote!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.QUOTE, arguments: [matchesQuote.group(1).replaceAll("<br>", "\n")],));
          continue;
        }
        final matchesCheckBox = RegExp("- \\[ \\] (.*)").firstMatch(comp);
        if (matchesCheckBox!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.CHECK_BOX, arguments: [matchesCheckBox.group(1)],));
          continue;
        }
        final matchesListItem = RegExp("- (.*)").firstMatch(comp);
        if (matchesListItem!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.LIST_ITEM, arguments: [matchesListItem.group(1)],));
          continue;
        }
        final matchesBoldItalicText = RegExp("___(.*)___").firstMatch(comp);
        if (matchesBoldItalicText!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.BOLD_ITALIC_TEXT, arguments: [matchesBoldItalicText.group(1)],));
          continue;
        }
        final matchesBoldText = RegExp("__(.*)__").firstMatch(comp);
        if (matchesBoldText!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.BOLD_TEXT, arguments: [matchesBoldText.group(1)],));
          continue;
        }
        final matchesItalicText = RegExp("_(.*)_").firstMatch(comp);
        if (matchesItalicText!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.ITALIC_TEXT, arguments: [matchesItalicText.group(1)],));
          continue;
        }
        final matchesLink = RegExp("\\[(.*)\\]\\((.*)\\)").firstMatch(comp);
        if (matchesLink!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.LINK, arguments: [matchesLink.group(1), matchesLink.group(2)],));
          continue;
        }
        final matchesMultiLineCodeBlock = RegExp("\\`\\`\\`<br>(.*)<br>\\`\\`\\`").firstMatch(comp.replaceAll("\n", "<br>"));
        if (matchesMultiLineCodeBlock!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.MULTI_LINE_CODE_BLOCK, arguments: [matchesMultiLineCodeBlock.group(1).replaceAll("<br>", "\n")],));
          continue;
        }
        final matchesCodeBlock = RegExp("\\`(.*)\\`").firstMatch(comp);
        if (matchesCodeBlock!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.CODE_BLOCK, arguments: [matchesCodeBlock.group(1)],));
          continue;
        }
        list.add(MarkdownComponent(type: MarkdownComponentType.TEXT, arguments: [comp],));
      }
    }
    return list;
  }
  String save(List<MarkdownComponent> comps) {
    final buff = StringBuffer();
    for (final comp in comps) {
      switch (comp.type) {
        case MarkdownComponentType.BIG_TITLE:
          buff.write("# ${comp.arguments[0]}\n\n");
          break;
        case MarkdownComponentType.MEDIUM_TITLE:
          buff.write("## ${comp.arguments[0]}\n\n");
          break;
        case MarkdownComponentType.SMALL_TITLE:
          buff.write("### ${comp.arguments[0]}\n\n");
          break;
        case MarkdownComponentType.QUOTE:
          buff.write("> ${comp.arguments[0]}\n\n");
          break;
        case MarkdownComponentType.LIST_ITEM:
          buff.write("- ${comp.arguments[0]}\n\n");
          break;
        case MarkdownComponentType.CHECK_BOX:
          buff.write("- [ ] ${comp.arguments[0]}\n\n");
          break;
        case MarkdownComponentType.TEXT:
          buff.write("${comp.arguments[0]}\n\n");
          break;
        case MarkdownComponentType.ITALIC_TEXT:
          buff.write("_${comp.arguments[0]}_\n\n");
          break;
        case MarkdownComponentType.BOLD_TEXT:
          buff.write("__${comp.arguments[0]}__\n\n");
          break;
        case MarkdownComponentType.BOLD_ITALIC_TEXT:
          buff.write("___${comp.arguments[0]}___\n\n");
          break;
        case MarkdownComponentType.LINK:
          buff.write("[${comp.arguments[0]}](${comp.arguments[1]})\n\n");
          break;
        case MarkdownComponentType.SPLIT_LINE:
          buff.write("---\n\n");
          break;
        case MarkdownComponentType.CODE_BLOCK:
          buff.write("`${comp.arguments[0]}`\n\n");
          break;
        case MarkdownComponentType.MULTI_LINE_CODE_BLOCK:
          buff.write("```\n${comp.arguments[0]}\n```\n\n");
      }
    }
    return buff.toString();
  }
}