import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter2/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../model/http_exception.dart';

enum AuthMode { SIGNUP, LOGIN }

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<StatefulWidget> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  AuthMode _authMode = AuthMode.LOGIN;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authData = {'email': '', 'password': ''};
  final _passwordController = TextEditingController();
  var _isLoading = false;

  Future<void> _showErrorDialog(String message) async {
    await showDialog<Null>(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Login Error'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Okay'),
          onPressed: () => Navigator.of(ctx).pop(),
        ),
      ],
    ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState?.save();
    log(_authData.toString());
    setState(() { _isLoading = true; });
    if (_authMode == AuthMode.LOGIN) {
      /// log user in
      try {
        await context.read<AuthProvider>().login(
            _authData['email']!, _authData['password']!);
      } on HttpException catch(error) {
        log('in httpException');
        String errorMessage = error.toString();
        await _showErrorDialog(errorMessage);
      } catch(error) {
        log('in catch(error)');
        String errorMessage = 'Could not authenticate. Please try again later.';
        await _showErrorDialog(errorMessage);
      }
    } else {
      /// sign user up
      await context.read<AuthProvider>().signup(_authData['email']!, _authData['password']!);
    }
    setState(() { _isLoading = false; });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.LOGIN) {
      setState(() { _authMode = AuthMode.SIGNUP; });
    } else {
      setState(() { _authMode = AuthMode.LOGIN; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8.0,
      child: Container (
        padding: const EdgeInsets.all(16.0),
        height: _authMode == AuthMode.SIGNUP ? 320 : 260,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                    onSaved: (value) {_authData['email'] = value!; },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true, /// hide input password
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please input password';
                      }
                      return null;
                    },
                    onSaved: (value) {_authData['password'] = value!; },
                  ),
                  if (_authMode == AuthMode.SIGNUP)
                    TextFormField(
                      enabled: _authMode == AuthMode.SIGNUP,
                      decoration: const InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: _authMode == AuthMode.SIGNUP
                          ? (value) {
                        if (value != _passwordController.text) {
                          return 'Password do not match';
                        }
                        return null;
                      }
                          : null,
                    ),
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: _submit,
                      child: const Text('LOGIN'),
                    ),
                  TextButton(
                    onPressed: _switchAuthMode,
                    child: Text('${_authMode == AuthMode.LOGIN ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  ),
                ],
              )
          ),
        ),
      )
    );
  }
  
}