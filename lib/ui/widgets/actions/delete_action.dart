import 'package:flutter/material.dart';


class DeleteAction extends StatelessWidget {
  final void Function() onPressed;
  const DeleteAction({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete), 
      onPressed: onPressed,
    );
  }
}