import 'package:assignment_mobile_app/APIRequest.dart';
import 'package:assignment_mobile_app/productsPage.dart';
import 'package:flutter/material.dart';
import 'package:assignment_mobile_app/APIRequest.dart';

class AddProduct extends StatelessWidget {
  final APIRequest apiRequest;
  final BuildContext context;

  AddProduct({required this.apiRequest, required this.context});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  addProduct() async {
    try {
      var res = await apiRequest.postProduct('product', {
        "name": _nameController.text,
        "price": _priceController.text,
        "description": _descriptionController.text,
      });
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Sign up successful!'),
      //   ),
      // );
      //  Navigator.pushReplacementNamed(context, '/products'); // Navigate to ProductsPage

      if (res == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('add product successful! '),
          ),
        );
        //  Navigator.pushReplacementNamed(context, '/products'); // Navigate to ProductsPage
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('add product failed'),
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
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'price'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your description';
                  }
                  // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  //     .hasMatch(value)) {
                  //   return 'Please enter a valid email';
                  // }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // if (_formKey.currentState!.validate()) {
                  await addProduct();
                  // Process sign up
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(
                  //     content: Text('Sign up successful!'),
                  //   ),
                  // );
                  // }
                },
                child: Text('add Product'),
              ),
              const SizedBox(height: 10),
              // TextButton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, '/login');
              //   },
              //   child: const Text('Already have an account? Log in'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
