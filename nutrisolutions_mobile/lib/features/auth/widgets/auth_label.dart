import 'package:flutter/material.dart';

class AuthLabel extends StatelessWidget {
  final String labelText;
  const AuthLabel({
    required this.labelText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        labelText,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
