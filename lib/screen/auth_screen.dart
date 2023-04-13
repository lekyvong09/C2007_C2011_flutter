
import 'package:flutter/material.dart';
import 'package:flutter2/widget/auth_card_widget.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthCard(),
    );
  }

}