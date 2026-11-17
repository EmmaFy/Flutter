import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/cart.dart';
import '../model/product.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> products = context.read<Cart>().products;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Shop'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Votre panier total est de"),
                Text(computeTotalPrice(products).toString(), style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          if (context.watch<Cart>().products.isEmpty)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Votre panier est vide"), Icon(Icons.image)],
            ),
          ),
          if (context.watch<Cart>().products.isNotEmpty)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Votre panier est vide"), Icon(Icons.image)],
            ),
          ),
        ],
      ),
    );
  }
}

num computeTotalPrice(List<Product> products){
  num total = 0;
  for (var product in products) {
    total += product.price;
  }
  return total;
}