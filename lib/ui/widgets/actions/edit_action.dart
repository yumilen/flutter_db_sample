import 'package:flutter/material.dart';


class EditAction extends StatelessWidget {
  final void Function() onPressed;
  const EditAction({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit), 
      onPressed: onPressed,
    );
  }
}