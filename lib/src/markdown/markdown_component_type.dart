enum MarkdownComponentType {
  BIG_TITLE, MEDIUM_TITLE, SMALL_TITLE, QUOTE, LIST_ITEM, TEXT, ITALIC_TEXT, BOLD_TEXT, LINK, SPLIT_LINE, CODE_BLOCK,
}

String ofString(MarkdownComponentType type) {
  switch (type) {
    case MarkdownComponentType.BIG_TITLE:
      return "大标题";
      break;
    case MarkdownComponentType.MEDIUM_TITLE:
      return "中标题";
      break;
    case MarkdownComponentType.SMALL_TITLE:
      return "小标题";
      break;
    case MarkdownComponentType.QUOTE:
      return "引用";
      break;
    case MarkdownComponentType.LIST_ITEM:
      return "列表项";
      break;
    case MarkdownComponentType.TEXT:
      return "文本";
      break;
    case MarkdownComponentType.ITALIC_TEXT:
      return "斜文本";
      break;
    case MarkdownComponentType.BOLD_TEXT:
      return "粗文本";
      break;
    case MarkdownComponentType.LINK:
      return "链接";
      break;
    case MarkdownComponentType.SPLIT_LINE:
      return "分割线";
      break;
    case MarkdownComponentType.CODE_BLOCK:
      return "代码块";
      break;
    default:
      return "未知组件";
  }
}