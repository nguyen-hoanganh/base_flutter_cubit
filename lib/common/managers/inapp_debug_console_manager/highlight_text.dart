part of 'inapp_debug_console_manager.dart';

class _HighlightText extends StatelessWidget {
  final String text;
  final String highlight;
  final TextStyle style;
  final TextStyle? highlightStyle;
  final Color? highlightColor;
  final bool ignoreCase;
  final int? maxLines;
  final TextOverflow? overflow;

  _HighlightText({
    Key? key,
    required this.text,
    required this.highlight,
    required this.style,
    this.highlightColor,
    TextStyle? highlightStyle,
    this.ignoreCase = false,
    this.maxLines,
    this.overflow,
  })  : highlightStyle =
            highlightStyle ?? style.copyWith(color: highlightColor),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = this.text;
    if (highlight.isEmpty || text.isEmpty) {
      return Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        style: style,
      );
    }

    var sourceText = ignoreCase ? text.toLowerCase() : text;
    var targetHighlight = ignoreCase ? highlight.toLowerCase() : highlight;

    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight;
    do {
      indexOfHighlight = sourceText.indexOf(targetHighlight, start);
      if (indexOfHighlight < 0) {
        // no highlight
        spans.add(_normalSpan(text.substring(start)));
        break;
      }
      if (indexOfHighlight > start) {
        // normal text before highlight
        spans.add(_normalSpan(text.substring(start, indexOfHighlight)));
      }
      start = indexOfHighlight + highlight.length;
      spans.add(_highlightSpan(text.substring(indexOfHighlight, start)));
    } while (true);

    return Text.rich(
      TextSpan(children: spans),
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  TextSpan _highlightSpan(String content) {
    return TextSpan(
      text: content,
      style: highlightStyle,
    );
  }

  TextSpan _normalSpan(String content) {
    return TextSpan(
      text: content,
      style: style,
    );
  }
}
