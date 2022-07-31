part of filled_text;

/// A widget to use [FilledText] in an easy way, getting the available space.
///
/// Use all the [FilledTextWidget] of the page in the same builder.
class FilledTextWidget extends StatelessWidget {
  final FilledText filledText;

  /// If it is not the first [FilledTextWidget] of the page, then, set its builder position with
  /// [builderPosition].
  ///
  /// Example:
  /// ```dart
  /// FilledTextWidget(
  ///   filledText: filledText,
  ///   // Default is 1, then, it does not need to be setted
  /// ),
  /// SomeOtherWidget(),
  /// FilledTextWidget(
  ///   filledText: filledText,
  ///   builderPosition: 2, // 2nd position
  /// ),
  /// SomeOtherWidget(),
  /// FilledTextWidget(
  ///   filledText: filledText,
  ///   builderPosition: 3, // 3rd position
  /// ),
  /// ```
  final int builderPosition;

  /// It can be used to build a child with another [Widget].
  /// The [text] and the [style] is the same of [filledText].
  ///
  /// Example:
  /// ```dart
  /// FilledTextWidget(
  ///   filledText: filledText,
  ///   builder: (String text, TextStyle? style) => Text(
  ///     text,
  ///     style: style,
  ///     textAlign: TextAlign.center,
  ///   ),
  /// ),
  /// ```
  final Widget Function(String text, TextStyle? style)? builder;

  /// Used to set a max height constraint to fill with the lines according to [maxLines].
  final int? maxLines;

  const FilledTextWidget({
    Key? key,
    required this.filledText,
    this.builder,
    this.builderPosition = 1,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxLines == null ? double.infinity : filledText.lineHeigth * maxLines!,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final text = filledText.computeFilledText(
            constraints: constraints,
            builderPosition: builderPosition,
            maxLines: maxLines,
          );

          return builder?.call(text, filledText.mainStyle) ??
              Text(text, style: filledText.mainStyle);
        },
      ),
    );
  }
}
