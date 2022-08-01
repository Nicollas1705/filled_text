part of filled_text;

/// Used to calculate the available space and fills it with the appropriate [text].
class FilledText {
  String text;
  TextStyle? mainStyle;

  FilledText({
    required this.text,
    this.mainStyle,
  });

  int _splitIndex = 0;
  final String _splitChar = ' ';
  final List<int> _builderPositions = [0];
  late final List<String> _splittedText = text.split(_splitChar);

  /// Used to start the first [FilledTextWidget] of the builder.
  /// If the text needs to be rebuilded from a specific index, set [firstIndex].
  void _initBuilderState([int firstIndex = 0]) => _splitIndex = firstIndex;

  /// Used to know if the text will be finished in the current page.
  bool get isTheTextFinished => _splitIndex >= _splittedText.length;

  /// Used to get the remaining text after the build.
  String get remainingText =>
      _splittedText.sublist(_builderPositions.last, _splittedText.length).join(_splitChar);

  /// Used to get the heigth of a line.
  double get lineHeigth => _getTextPainter('', style: mainStyle).size.height;

  TextPainter _getTextPainter(
    String text, {
    TextStyle? style,
    double minWidth = 0,
    double maxWidth = double.infinity,
    int? maxLines,
  }) {
    return TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
  }

  String _removeLastSplit(String text) {
    final splittedText = text.split(_splitChar);
    return splittedText.getRange(0, splittedText.length - 1).join(_splitChar);
  }

  /// Use it to get the max text that fills in these [constraints].
  String _getText(BoxConstraints constraints, [int? maxLines]) {
    String text = '';
    for (; _splitIndex < _splittedText.length; _splitIndex++) {
      text += '$_splitChar${_splittedText[_splitIndex]}';
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

  /// Used by [FilledTextWidget] to calculate and get the max text that fills in these
  /// [constraints]. The [constraints] can be provided by a [LayoutBuilder] widget.
  String computeFilledText({
    required BoxConstraints constraints,
    int? maxLines,
    int builderPosition = 1,
  }) {
    try {
      _initBuilderState(_builderPositions[builderPosition - 1]);
    } catch (error) {
      log('$error');
      log(
        'This can be caused by a FilledTextWidget with a wrong builderPosition setted. '
        'If the first FilledTextWidget builded is setted with builderPosition = 2, it will cause this error. '
        'It can also be caused by putting one FilledTextWidget into an Expanded/Flexible and the next one not. '
        'Since the Expanded/Flexible Widgets is the last ones to be builded in the Colum/Row, it can cause this error.',
      );
      log(
        'There are some ways to solve this:\n'
        '  1: Remove the Expanded/Flexible Widgets or add it to all FilledTextWidget.\n'
        '  2: Try to rebuild the next FilledTextWidget after the previous FilledTextWidget build.',
      );
      _initBuilderState();
    }

    final text = _getText(constraints, maxLines);

    if (builderPosition < _builderPositions.length) {
      _builderPositions[builderPosition] = _splitIndex;
    } else {
      _builderPositions.add(_splitIndex);
    }

    return text;
  }

  /// Use it to pass this [FilledText] to another page as parameter.
  /// It returns a new instance of [FilledText] with the [remainingText].
  FilledText get nextPage {
    return FilledText(
      text: remainingText,
      mainStyle: mainStyle,
    );
  }
}
