import '../markdown/markdown_component.dart';
import '../markdown/markdown_component_type.dart';

class TheMarkdown {
  List<MarkdownComponent> render(String source) {
    final list = List<MarkdownComponent>();
    for (final comp in source.split("\n\n")) {
      if (comp!=""&&comp!=null) {
        if (comp=="---") {
          list.add(MarkdownComponent(type: MarkdownComponentType.SPLIT_LINE,));
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
        final matchesQuote = RegExp("> (.*)").firstMatch(comp);
        if (matchesBigTitle!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.QUOTE, arguments: [matchesQuote.group(1)],));
          continue;
        }
        final matchesListItem = RegExp("> (.*)").firstMatch(comp);
        if (matchesBigTitle!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.LIST_ITEM, arguments: [matchesListItem.group(1)],));
          continue;
        }
        final matchesItalicText = RegExp("_(.*)_").firstMatch(comp);
        if (matchesBigTitle!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.ITALIC_TEXT, arguments: [matchesItalicText.group(1)],));
          continue;
        }
        final matchesBoldText = RegExp("_(.*)_").firstMatch(comp);
        if (matchesBigTitle!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.BOLD_TEXT, arguments: [matchesBoldText.group(1)],));
          continue;
        }
        final matchesLink = RegExp("\\[(.*)\\]\\((.*)\\)").firstMatch(comp);
        if (matchesBigTitle!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.ITALIC_TEXT, arguments: [matchesLink.group(1), matchesLink.group(2)],));
          continue;
        }
        final matchesCodeBlock = RegExp("\\`(.*)\\`").firstMatch(comp);
        if (matchesBigTitle!=null) {
          list.add(MarkdownComponent(type: MarkdownComponentType.CODE_BLOCK, arguments: [matchesLink.group(1)],));
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
        case MarkdownComponentType.TEXT:
          buff.write("${comp.arguments[0]}\n\n");
          break;
        case MarkdownComponentType.ITALIC_TEXT:
          buff.write("_${comp.arguments[0]}_\n\n");
          break;
        case MarkdownComponentType.BOLD_TEXT:
          buff.write("__${comp.arguments[0]}__\n\n");
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
      }
    }
    return buff.toString();
  }
}