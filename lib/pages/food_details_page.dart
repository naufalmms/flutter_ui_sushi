// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_ui_sushi/components/button.dart';

import 'package:flutter_ui_sushi/models/food.dart';
import 'package:flutter_ui_sushi/models/shop.dart';
import 'package:flutter_ui_sushi/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FoodDetailsPage extends StatefulWidget {
  final Food food;

  const FoodDetailsPage({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  // quantity
  int quantityCount = 0;

  // decrement quantity
  void decrementQuantity() {
    setState(() {
      quantityCount > 0 ? quantityCount-- : null;
    });
  }

  // increment quantity
  void incrementQuantity() {
    setState(() {
      quantityCount++;
    });
  }

  // add to cart
  void addToCart() {
    // only add to cart if there is something in the cart
    if (quantityCount > 0) {
      // get access to shop
      final shop = context.read<Shope>();

      // add to cart
      shop.addtoCart(widget.food, quantityCount);

      // let the user know it was successful
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: primaryColor,
          content: const Text(
            "Successfully added to cart",
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            // okay button,
            IconButton(
              onPressed: () {
                // pop once to remove dialog box
                Navigator.pop(context);

                // pop again to go previous screen
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.done,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey[900],
      ),
      body: Column(
        children: [
          //listvie of food details,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: ListView(
                children: [
                  // image,
                  Image.asset(
                    widget.food.imagePath,
                    height: 200,
                  ),

                  const SizedBox(
                    height: 25.0,
                  ),

                  // rating,
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        widget.food.rating,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // food name,
                  Text(
                    widget.food.name,
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 28,
                    ),
                  ),

                  const SizedBox(
                    height: 25.0,
                  ),

                  // description,

                  Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                    height: 10.0,
                  ),

                  Text(
                    "A ball of shaped, vinegared sushi rice is topped with a delicious looking slice of salmon. You can then dip this in soy sauce, or with wasabi and soy sauce, or alternatively salt and a bit of citrus. In homage to how salmon used to be eaten it can still be ordered grilled too.",
                    style: TextStyle(
                      color: Colors.grey[600],
                      height: 2,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // price + quantity + add to cart button,
          Container(
            padding: const EdgeInsets.all(25),
            color: primaryColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rp${widget.food.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        // minus button,
                        Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: decrementQuantity,
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // quantity count,
                        SizedBox(
                          width: 40,
                          child: Center(
                            child: Text(
                              quantityCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),

                        // plus button,
                        Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: incrementQuantity,
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),

                const SizedBox(
                  height: 25.0,
                ),

                // add to cart button,
                MyButton(text: "Add To Cart", onTap: addToCart),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
