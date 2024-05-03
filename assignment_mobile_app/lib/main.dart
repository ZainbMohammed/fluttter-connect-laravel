// import 'dart:js';

import 'package:assignment_mobile_app/APIRequest.dart';
import 'package:assignment_mobile_app/addProduct.dart';
import 'package:assignment_mobile_app/productsPage.dart';
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
        '/products': (context) => ProductsPage(), 
        '/addproducts' : (context) => AddProduct(
            apiRequest: apiRequest, context: context), // Add ProductsPage route
      },
    );
  }
}

class SignUpPage extends StatelessWidget {
  final APIRequest apiRequest;
  final BuildContext context;

  SignUpPage({required this.apiRequest, required this.context});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  
  signUp() async {
    try {
      var res = await apiRequest.postRequest('register', {
        "name": _usernameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
      });
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Sign up successful!'),
      //   ),
      // );
      //  Navigator.pushReplacementNamed(context, '/products'); // Navigate to ProductsPage
      
      if (res == null ) {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign up successful! '),
        ),
      );
       Navigator.pushReplacementNamed(context, '/products'); // Navigate to ProductsPage

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign up failed'),
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
                  if (_formKey.currentState!.validate()) {
                  await signUp();
                  //Process sign up
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sign up successful!'),
                    ),
                  );
                  }

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

      if (res['token'] == null) {
        // print('login gooood');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed!'),
          ),
        );
      } else {
        // print('login bad');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successful'),
          ),
        );
                Navigator.pushReplacementNamed(context, '/products'); // Navigate to ProductsPage

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
                onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    await login();
                    //Process login
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
