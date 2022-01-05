import 'package:flutter/material.dart';
import 'my_text_field.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  var userName = '';
  var password = '';

  void _login() {
    var valid = _formKey.currentState!.validate();
    if (valid) {
      print('userName = $userName');
      print('password = $password');
    }
    var message =
        valid ? 'Processing login ...' : 'One or more fields are invalid.';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Color errorColor = Theme.of(context).errorColor;
    Color primaryColor = Theme.of(context).primaryColor;

    bool valid = _formKey.currentState?.validate() ?? false;
    print('valid = $valid');

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Form Validation'),
      ),
      body: Form(
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              'Login',
              style: TextStyle(
                color: primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            MyTextField(
              labelText: 'User Name',
              initialValue: userName,
              onChanged: (value) => setState(() {
                userName = value;
              }),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'A username is required.';
                }
                return null;
              },
            ),
            MyTextField(
              labelText: 'Password',
              initialValue: password,
              obscureText: true,
              onChanged: (value) => setState(() {
                password = value;
              }),
              validator: validatePassword,
            ),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: valid ? _login : null,
            ),
          ],
        ),
      ),
    );
  }

  String? validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'A password is required.';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Must contain at least one uppercase letter.';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Must contain at least one lowercase letter.';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Must contain at least one digit.';
    }
    // I can't get a single quote to work below.
    if (!RegExp(r'[~@#$%^&*()\-_=+\[\]{\]}\\\|;:",<.>/?]').hasMatch(value)) {
      return 'Must contain at least one special character.';
    }
    return null;
  }
}
