import 'package:esilv_shop/model/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cart.g.dart';

@riverpod
class Cart extends _$Cart {
  @override
  List<Product> build() {
    return [];
  }

  void add(Product product){
    state = [...state, product];
  }

  void remove(Product product) {
    bool removed = false; // pour n'enlever que la première occurence
    state = state.where((element) {
      if (!removed && element.id == product.id) {
        removed = true;
        return false;
      }
      return true;
    }).toList();
  }
}
