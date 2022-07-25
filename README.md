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
  filled_text:
    git:
      url: https://github.com/Nicollas1705/filled_text
      ref: main
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

## FilledText options

TODO:

<!-- text
mainStyle
initBuilderState()
isTheTextFinished
lastIndex
remainingText
lineHeigth
getText()
nextPage -->

## FilledTextWidget options

TODO:

<!-- filledText
builder
isTheFirstOfTheBuilder
maxLines -->
