import 'package:flutter/material.dart';

class Product {
  final String name;
  final String image;
  final String description;
  final double price;

  Product({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
  });
}

class ProductsPage extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'Product 1',
      image: 'assets/images/product1.jpg',
      description: 'Description for Product 1',
      price: 19.99,
    ),
    Product(
      name: 'Product 2',
      image: 'assets/images/product2.jpg',
      description: 'Description for Product 2',
      price: 29.99,
    ),
    Product(
      name: 'Product 3',
      image: 'assets/images/product3.jpg',
      description: 'Description for Product 3',
      price: 39.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.asset(
                products[index].image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(products[index].name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price: \$${products[index].price.toStringAsFixed(2)}'),
                  Text(products[index].description),
                ],
              ),
              onTap: () {
                // Handle product tap, e.g., navigate to product details page
              },
            ),
          );
        },
      ),
    );
  }
}
