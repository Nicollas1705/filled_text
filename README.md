# filled_text

This package provides a class and a widget that calculate the available space to fill with a text, while the remaining text can be put in other part of the page (or in another page).

<br>
<img WIDTH="60%" src="https://user-images.githubusercontent.com/84534787/120998591-a95c6980-c7a1-11eb-9435-7d7587f0b32b.png">
<br>
<br>


## Example

![Filled text widget example](https://user-images.githubusercontent.com/58062436/180695238-df8037c6-580d-4bf6-8d5e-1100d0aa57ef.gif)

[Example code](https://github.com/Nicollas1705/filled_text_example)


## Usage

1. Add the dependency into pubspec.yaml.

```yaml
dependencies:
  filled_text: ^1.0.0
```

2. Import the library:

```dart
import 'package:filled_text/filled_text.dart';
```

3. Create the and initialize the FilledText class:

Can be setted a style with [mainStyle] (optional).

```dart
final filledText = FilledText(
  text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
  mainStyle: const TextStyle(fontSize: 20),
);
```

4. Use the [FilledTextWidget] that simplify the usage of [FilledText]:

This widget simply get the [constraints] to calculate the available space.

```dart
FilledTextWidget(filledText: filledText),
```

5. Finally, put the [FilledTextWidget] into the page:

'build' method example.

```dart
Widget build(BuildContext context) {
  return Scaffold(
    body: FilledTextWidget(filledText: filledText),
  );
}
```


### Result

![Filled text - Simple example](https://user-images.githubusercontent.com/58062436/180695575-e8b151c2-362b-40a5-8a5b-e909e5682739.gif)


### Example code result:

```dart
class FilledTextExample extends StatelessWidget {
  FilledTextExample({ Key? key }) : super(key: key);

  final filledText = FilledText(
    text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    mainStyle: const TextStyle(fontSize: 20),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FilledTextWidget(filledText: filledText),
    );
  }
}
```


# FilledText options

## text and mainStyle

These attributes are to set the [text] that will fill the available space and its [style].
It is defined in the [FilledText] constructor.

The [mainStyle] can be not defined.


## isTheTextFinished

This method can be used to check if the [text] finished in the page.

It can be used for example to show/hide a button to go to the next page of a book.

Click [here](https://github.com/Nicollas1705/filled_text_example) to check the project example (using multiple pages with isTheTextFinished).


## remainingText

This method can be used to get the remaining text. If there is no text, it will return an empty String.


## lineHeigth

This method can be used to get a single line heigth according to the style defined on [mainStyle].


## computeFilledText

This method is used by [FilledTextWidget] to get the text based on the available space and compute the usage of multiple [FilledTextWidget] in a single page.

To use this, needs a [constraints] (provided by [LayoutBuilder] widget).


## nextPage

This method can be used to pass a new instance of [FilledText] with the [remainingText] of the previous [FilledText].

Example:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => AnotherPage(
      filledText: filledText.nextPage,
    ),
  ),
);
```


# FilledTextWidget options

## filledText

This is a required attribute to get the [FilledText] instance.


## builderPosition

This is used only if there are more than one [FilledTextWidget] in the same page.

To use this, set it according to [FilledTextWidget]'s position in the page.

Example:

```dart
FilledTextWidget(
  filledText: filledText,
  // Default builderPosition is 1, then, it does not need to be setted
),
SomeOtherWidget(),
FilledTextWidget(
  filledText: filledText,
  builderPosition: 2, // 2nd position
),
SomeOtherWidget(),
FilledTextWidget(
  filledText: filledText,
  builderPosition: 3, // 3rd position
),
```


## builder

This is used to set a different [Widget] in the [FilledTextWidget], or different attributes to a normal text, like [TextAlign.center].

Example:

```dart
FilledTextWidget(
  filledText: filledText,
  builder: (String text, TextStyle? style) => Text(
    text,
    style: style,
    textAlign: TextAlign.center,
  ),
),
```


## maxLines

This can be used to set the maximum number of lines.


# TODO

## [ ] Add a way to put TextSpan (InlineText)

Nowadays, the package doesn't support TextSpan (InlineSpan).

Example:

```dart
final filledText = FilledText(
  inlineText: TextSpan(text: 'Some text.'),
);
```

Maybe can be done a new class for this (moving the shared attributes/methods to a super class).

Example:

```dart
final example = FilledTextSpan(...);
final example = FilledTextInlineSpan(...);
```


## [ ] Add a easy way to use StringBuffer

If needed to show a whole book, the complete String can be expansive in terms of memory. Using a [StringBuffer], it can be done easier.

Due to nowadays not having a easy way to use [StringBuffer], there are another approach that can be done to try to solve this:

Can be get a part of the whole [text] that ensures the available space will be filled. Then, to the next page, can be given a new [FilledText] with the previous [FilledText.remainingText] + another part of the whole [text].
