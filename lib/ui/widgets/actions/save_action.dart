import 'package:flutter/material.dart';


class SaveAction extends StatelessWidget {
  final void Function() onPressed;
  const SaveAction({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.check), 
      onPressed: onPressed,
    );
  }
}