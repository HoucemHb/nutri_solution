import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Login Screen'),
          ElevatedButton(
            onPressed: () {
              context.go('/profile/123');
            },
            child: Text('Go to Profile'),
          ),
        ],
      ),
    );
  }
}
