import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kunlabori/src/rust/api/interface.dart';

class EditorView extends HookWidget {
  const EditorView({required this.docId, super.key});

  final String docId;

  @override
  Widget build(BuildContext context) {
    final insertPositionController = useTextEditingController(text: '0');
    final insertTextController = useTextEditingController(text: 'hello world');

    final deletePositionController = useTextEditingController(text: '0');
    final deleteCountController = useTextEditingController();

    void executeInsert() {
      final position = insertPositionController.text;
      final text = insertTextController.text;

      if (position.isEmpty || text.isEmpty) {
        debugPrint('Position and text must be filled');
        return;
      }

      try {
        insert(
          id: docId,
          position: int.parse(position),
          text: text,
        );
      } catch (e) {
        debugPrint('Error: $e');
      }
    }

    void executeDelete() {
      final position = deletePositionController.text;
      final count = deleteCountController.text;

      if (position.isEmpty || count.isEmpty) {
        debugPrint('Position and count must be filled');
        return;
      }

      try {
        delete(
          id: docId,
          position: int.parse(position),
          deleteCount: int.parse(count),
        );
      } catch (e) {
        debugPrint('Error: $e');
      }
    }

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Insert'),
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: TextField(
                    controller: insertPositionController,
                    decoration: const InputDecoration(
                      labelText: 'Position',
                      hintText: '0',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: insertTextController,
                    decoration: const InputDecoration(
                      labelText: 'Text',
                      hintText: 'Text to insert',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: executeInsert,
                  child: const Text('Insert'),
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Delete'),
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: TextField(
                    controller: deletePositionController,
                    decoration: const InputDecoration(
                      labelText: 'Position',
                      hintText: '0',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: deleteCountController,
                    decoration: const InputDecoration(
                      labelText: 'Count',
                      hintText: 'Characters to delete',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                ElevatedButton(
                  onPressed: executeDelete,
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
