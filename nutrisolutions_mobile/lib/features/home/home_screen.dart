import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Welcome to the Home Screen!'),
          ElevatedButton(
            onPressed: () {
              context.go('/login');
            },
            child: Text('Go to Login'),
          ),
        ],
      ),
    );
  }
}
