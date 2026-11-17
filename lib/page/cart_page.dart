import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../model/cart.dart';
import '../model/product.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Panier'),
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
                  "${computeTotalPrice(ref.watch(cartProvider))} €",
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
            Expanded(
              child: ListView.builder(
                itemCount: ref.watch(cartProvider).length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  onTap: () => context.go('/product/${ref.watch(cartProvider)[index].id}'),
                  title: Text(ref.watch(cartProvider)[index].title, maxLines: 1),
                  subtitle: Text(
                    ref.watch(cartProvider)[index].getPrice(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Image.network(ref.watch(cartProvider)[index].image, width: 80),
                  trailing: TextButton(
                    onPressed: () => ref.read(cartProvider.notifier).remove(ref.watch(cartProvider)[index]),
                    child: Text("Retirer".toUpperCase()),
                  ),
                ),
              ),
            ),
          if (ref.watch(cartProvider).isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FilledButton(
                onPressed: () {},
                child: Text("Procéder au paiement"),
              ),
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