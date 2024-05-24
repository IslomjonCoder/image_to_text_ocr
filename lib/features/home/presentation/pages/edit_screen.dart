import 'package:flutter/material.dart';
import 'package:image_to_text_ocr/generated/l10n.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).edit), actions: [
        IconButton(
          icon: Icon(Icons.check_rounded),
          onPressed: () {},
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          expands: true,
          maxLines: null,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
            labelText: 'Text',
          ),
        ),
      ),
    );
  }
}
