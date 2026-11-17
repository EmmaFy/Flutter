import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/cart.dart';
import '../model/product.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Shop'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Votre panier total est de"),
                Text(
                  computeTotalPrice(ref.watch(cartProvider)).toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          if (ref.watch(cartProvider).isEmpty)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Votre panier est vide"),
                  Icon(Icons.shopping_cart_outlined),
                ],
              ),
            )
          else
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Votre panier n'est pas vide"),
                  Icon(Icons.shopping_cart_outlined),
                ],
              ),
            )
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