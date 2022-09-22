import 'package:example/pages_example.dart';
import 'package:example/simple_example.dart';
import 'package:filled_text/filled_text.dart';
import 'package:flutter/material.dart';

const _longText =
    '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.''';

const _shortText = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.';

class FilledTextHomeExamples extends StatelessWidget {
  const FilledTextHomeExamples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FilledText examples')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _HomeButton(
              label: 'Simple example',
              pageBuilder: (_) => FilledTextSimpleExample(
                filledText: FilledText(
                  text: _shortText,
                  mainStyle: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _HomeButton(
              label: 'Pages example',
              pageBuilder: (_) => FilledTextPagesExample(
                filledText: FilledText(
                  text: _longText,
                  mainStyle: const TextStyle(fontSize: 20),
                ),
                // Controller used only to rebuild the next page button
                nextPageButtonController: Controller(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeButton extends StatelessWidget {
  final String label;
  final Widget Function(BuildContext) pageBuilder;

  const _HomeButton({
    Key? key,
    required this.label,
    required this.pageBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: pageBuilder));
      },
      child: Text(label),
    );
  }
}
