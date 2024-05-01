// import 'dart:js';

import 'package:assignment_mobile_app/APIRequest.dart';
import 'package:flutter/material.dart';
import 'package:assignment_mobile_app/APIRequest.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final APIRequest apiRequest = APIRequest(baseURL: 'http://10.0.2.2:8000/api');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SignUpPage(
              apiRequest: apiRequest,
              context: context,
            ),
        '/login': (context) => LoginPage(
              apiRequest: apiRequest,
              context: context,
            ),
      },
    );
  }
}

class SignUpPage extends StatelessWidget {
  final APIRequest apiRequest;
  final BuildContext context; // Add this line

  SignUpPage({required this.apiRequest, required this.context});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // signUp() async {
  //   var res = await _info.postReq(LinkSignUp, {
  //     "userName": _usernameController.text,
  //     "password": _passwordController.text,
  //     "email": _emailController.text,
  //   });
  //   // if (res['status'] == 'success') {
  //   //   Navigator.of( context).pushNamed('/login');
  //   // } else {

  //   // }
  // }
  signUp() async {
    // try {
      var res = await apiRequest.postRequest('register', {
        "name": _usernameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
      });
      if (res != null && res['status'] == 'success') {
        // Navigator.of(context).pushNamed('/login');
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign up successful!'),
        ),
      );
        print('sign up gooood');
      } else {
        print('sign up baaad');

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Sign up failed:'),
        //   ),
        // );
       }
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Failed to connect to the server'),
    //     ),
    //   );
    //   print(e);
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // if (_formKey.currentState!.validate()) {
                  await signUp();
                  // Process sign up
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sign up successful!'),
                    ),
                  );
                  // }
                },
                child: Text('Sign Up'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Already have an account? Log in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final APIRequest apiRequest;
  final BuildContext context; // Add this line

  LoginPage({required this.apiRequest, required this.context});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  login() async {
    try {
      var res = await apiRequest.postRequest('login', {
        "email": _emailController.text,
        "password": _passwordController.text,
      });

      if (res['status'] == 'success') {
        print('login gooood');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
          ),
        );
      } else {
        print('login bad');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${res['message']}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to connect to the server'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process login
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login successful!'),
                      ),
                    );
                  }
                },
                child: Text('Login'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () async {
                  await login();
                  // Navigator.pop(context);
                },
                child: const Text('Don\'t have an account? Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
