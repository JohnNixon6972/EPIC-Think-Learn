import 'package:epic/features/auth/repository/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                'EPIC Think Learn',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                ref.read(authServiceProvider).signInWithGoogle();
              },
              child: const Text('Login'),
            )
          ],
        ),
      )),
    );
  }
}
