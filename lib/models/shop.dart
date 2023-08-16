import 'package:flutter/material.dart';

import 'food.dart';

class Shope extends ChangeNotifier {
  final List<Food> _foodMenu = [
    Food(
      name: "Salmon Sushi",
      price: "20.000",
      imagePath: "assets/many_sushi.png",
      rating: "4.9",
    ),
    Food(
      name: "Tuna",
      price: "22.000",
      imagePath: "assets/tuna.png",
      rating: "4.9",
    ),
  ];

  // customer cart
  final List<Food> _cart = [];

  // getter method
  List<Food> get foodMenu => _foodMenu;
  List<Food> get cart => _cart;

  // add to cart
  void addtoCart(Food foodItem, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(foodItem);
    }
    notifyListeners();
  }

  // remove from cart
  void removeFromCart(Food food) {
    _cart.remove(food);
    notifyListeners();
  }
}
