import 'package:flutter/material.dart';
import 'package:menu_task/menu.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.034),
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.1,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                  color: Colors.green),
              child: Center(
                child: Text(
                  'Cart',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.08,
                      fontFamily: 'Schyler-Regular'),
                ),
              ),
            ),
          ),
          Container(
            width: screenWidth,
            height: screenHeight * 0.76,
            color: Colors.white,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: cartList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: screenHeight * 0.11,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 0.01,
                          blurRadius: 7,
                          offset: Offset(0, 5),
                        ),
                      ],
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '${cartList[index]["name"]}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Count: ' '${cartList[index]["count"]}',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Price: ' '${cartList[index]["price"]}',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('')
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: screenWidth,
            height: screenHeight * .106,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
                color: Colors.green),
            child: Center(
              child: Text(
                'Total Price:  $totalPrice',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
