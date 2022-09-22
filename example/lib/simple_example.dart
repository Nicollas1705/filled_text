import 'package:filled_text/filled_text.dart';
import 'package:flutter/material.dart';

class FilledTextSimpleExample extends StatelessWidget {
  final FilledText filledText;

  const FilledTextSimpleExample({
    Key? key,
    required this.filledText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FilledText Simple Example')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[300],
          ),
          child: Column(
            children: [
              Expanded(
                child: FilledTextWidget(filledText: filledText),
              ),
              Container(
                color: Colors.white,
                height: 32,
              ),
              Expanded(
                child: FilledTextWidget(
                  filledText: filledText,
                  builderPosition: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
