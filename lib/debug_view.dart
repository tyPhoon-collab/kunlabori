import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kunlabori/src/rust/api/interface.dart';

class DebugView extends StatelessWidget {
  const DebugView({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Debug View'),
        _TimestampDebugView(id: id),
        _StateVectorDebugView(id: id),
        _DiffDebugView(id: id),
        _MergeDebugView(id: id),
      ],
    );
  }
}

class _TextAndButton extends StatelessWidget {
  const _TextAndButton({
    required this.text,
    required this.onPressed,
    required this.buttonText,
  });

  final String text;
  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SelectableText(text)),
        ElevatedButton(
          onPressed: onPressed,
          child: Text(buttonText),
        ),
      ],
    );
  }
}

class _InputAndButton extends StatelessWidget {
  const _InputAndButton({
    required this.controller,
    required this.onPressed,
    required this.buttonText,
  });

  final TextEditingController controller;
  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
          ),
        ),
        ElevatedButton(
          onPressed: onPressed,
          child: Text(buttonText),
        ),
      ],
    );
  }
}

class _TimestampDebugView extends HookWidget {
  const _TimestampDebugView({
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final timestampValue = useState('');

    return _TextAndButton(
      text: timestampValue.value,
      onPressed: () {
        final ts = timestamp(id: id);
        timestampValue.value = ts.toString();
      },
      buttonText: 'Get Timestamp',
    );
  }
}

class _StateVectorDebugView extends HookWidget {
  const _StateVectorDebugView({
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final stateVectorValue = useState('');

    return _TextAndButton(
      text: stateVectorValue.value,
      onPressed: () {
        final sv = stateVector(id: id);
        stateVectorValue.value = sv.toString();
      },
      buttonText: 'Get State Vector',
    );
  }
}

class _DiffDebugView extends HookWidget {
  const _DiffDebugView({
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final diffValue = useState('');

    return _TextAndButton(
      text: diffValue.value,
      onPressed: () {
        final sv = stateVector(id: id);
        final diffBytes = diff(id: id, since: sv);
        diffValue.value = diffBytes.toString();
      },
      buttonText: 'Get Diff',
    );
  }
}

class _MergeDebugView extends HookWidget {
  const _MergeDebugView({
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final mergeInputController = useTextEditingController();

    return _InputAndButton(
      controller: mergeInputController,
      onPressed: () {
        final input = mergeInputController.text;
        final bytes = input.split(',').map((e) => int.parse(e.trim())).toList();
        merge(id: id, update: bytes);
      },
      buttonText: 'Merge',
    );
  }
}
