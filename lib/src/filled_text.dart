part of filled_text;

/// Used to calculate the space and fills it with the appropriate text
class FilledText {
  String text;
  TextStyle? mainStyle;

  FilledText({
    required this.text,
    this.mainStyle,
  }) {
    _words = text.split(_splitChar);
  }

  late final List<String> _words;
  final String _splitChar = ' ';
  int _wordIndex = 0;

  /// Used to start the first [FilledTextWidget] of the builder.
  /// If the text needs to be rebuilded from a specific index, set [firstIndex].
  void initBuilderState([int firstIndex = 0]) => _wordIndex = firstIndex;

  /// Used to know if the text will be finished in the current page.
  bool get isTheTextFinished => _wordIndex >= _words.length;

  /// Used to get the last index after the build.
  int get lastIndex => _wordIndex;

  /// Used to get the remaining text after the build.
  String get remainingText => _words.sublist(_wordIndex, _words.length).join(_splitChar);

  /// Used to get the heigth of a line.
  double get lineHeigth => _getTextPainter('', style: mainStyle).size.height;

  TextPainter _getTextPainter(
    String text, {
    TextStyle? style,
    double minWidth = 0,
    double maxWidth = double.infinity,
    int? maxLines,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter;
  }

  String _removeLastSplit(String text) {
    final splittedText = text.split(_splitChar);
    return splittedText.getRange(0, splittedText.length - 1).join(_splitChar);
  }

  /// Use it to get the max text that fills in these [constraints].
  /// The [constraints] can be provided by [LayoutBuilder] widget.
  String getText(BoxConstraints constraints, [int? maxLines]) {
    String text = '';
    for (; _wordIndex < _words.length; _wordIndex++) {
      text += '$_splitChar${_words[_wordIndex]}';
      if (text[0] == _splitChar) text = text.replaceFirst(_splitChar, '');

      final textPainter = _getTextPainter(
        text,
        maxWidth: constraints.maxWidth,
        style: mainStyle,
        maxLines: maxLines,
      );

      final isOverflowing =
          textPainter.didExceedMaxLines || textPainter.size.height > constraints.maxHeight;
      if (isOverflowing) {
        text = _removeLastSplit(text);
        break;
      }
    }
    return text;
  }

  /// Use it to pass this [FilledText] to another page as parameter.
  FilledText get nextPage {
    return FilledText(
      text: remainingText,
      mainStyle: mainStyle,
    );
  }
}
