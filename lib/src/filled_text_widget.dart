part of filled_text;

/// A widget to use [FilledText] in an easy way, getting the available space.
///
/// Use all the [FilledTextWidget] of the page in the same builder.
class FilledTextWidget extends StatelessWidget {
  final FilledText filledText;

  /// If it is not the first [FilledTextWidget] builded in the page, set as [false].
  /// 
  /// Don't use the non-first [FilledTextWidget] in a separated builder from the first one.
  final bool isTheFirstOfTheBuilder;

  /// It can be used to build a different child.
  /// Example:
  /// ```dart
  /// builder: (String text, TextStyle? style) => Text(
  ///   text,
  ///   style: style,
  ///   textAlign: TextAlign.center,
  /// ),
  /// ```
  final Widget Function(String text, TextStyle? style)? builder;

  /// **Note: be careful using this parameter.**
  ///
  /// If [isTheFirstOfTheBuilder] is [false], the [maxLines] can't be setted.
  ///
  /// If needs to set a [maxLines], use only in the first [FilledTextWidget].
  ///
  /// Tip: if using this, try to use a [Flexible] as its parent
  /// (if not using another [Flexible] or [Expanded] in the [Row]/[Column]).
  final int? maxLines;

  const FilledTextWidget({
    Key? key,
    required this.filledText,
    this.builder,
    this.isTheFirstOfTheBuilder = true,
    this.maxLines,
  })  : //assert(isTheFirstOfTheBuilder || maxLines == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxLines == null ? double.infinity : filledText.lineHeigth * maxLines!,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (isTheFirstOfTheBuilder) filledText.initBuilderState();
          final text = filledText.getText(constraints, maxLines);

          if (builder != null) return builder!(text, filledText.mainStyle);
          return Text(text, style: filledText.mainStyle);
        },
      ),
    );
  }
}
