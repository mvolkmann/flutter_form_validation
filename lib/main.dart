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
      home: const MyHomePage(),
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
    var message = _formKey.currentState!.validate()
        ? 'Processing login ...'
        : 'One or more fields are invalid.';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color errorColor = Theme.of(context).errorColor;

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
                color: errorColor,
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
                userName = value;
              }),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'A password is required.';
                }
                return null;
              },
            ),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: _login,
            ),
          ],
        ),
      ),
    );
  }
}
