// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_task/cart.dart';
import 'package:menu_task/poducts.dart';
import 'package:menu_task/product/bloc/product_bloc.dart';

List<dynamic> cartList = [];
double totalPrice = 0.0;
bool isItemAdded(String id) {
  int itemExists = 0;
  cartList.forEach((element) {
    if (element['id'] == id) {
      itemExists++;
    }
  });
  if (itemExists > 0) {
    return true;
  }
  return false;
}

class mainmenu extends StatefulWidget {
  const mainmenu({super.key});

  @override
  State<mainmenu> createState() => _mainmenuState();
}

class _mainmenuState extends State<mainmenu> {
  ProductModel Productmodel = ProductModel();
  var loadingValue = 0;

  @override
  Widget build(BuildContext context) {
    // int _itemCount = 0;
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductLoadingState) {
          print('loading');
        }

        if (state is ProductSuccessState) {
          setState(() {
            loadingValue = 1;
            print('state is set');
            Productmodel = state.Productmodel;
          });
        }
      },
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return loadingValue == 0
              ? Container(
                  width: screenWidth,
                  height: screenHeight,
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.green[200],
                    ),
                  ),
                )
              : Scaffold(
                  backgroundColor: Colors.white,
                  body: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.034),
                        child: Row(
                          children: [
                            Container(
                              width: screenWidth,
                              height: screenHeight * 0.1,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0)),
                                  color: Colors.green),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Our Menu',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenWidth * 0.08,
                                        fontFamily: 'Schyler-Regular'),
                                  ),
                                  Container(
                                    width: screenWidth * 0.05,
                                    height: screenHeight * 0.05,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Cart()));
                                    },
                                    child: Container(
                                      width: screenWidth * 0.1,
                                      height: screenHeight * 0.1,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Container(
                                        // width: screenWidth * 0.0,
                                        // height: screenHeight * 0.01,
                                        child: const Icon(
                                          Icons.shopping_cart,
                                          color: Colors.black,
                                          size: 25.0,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: screenWidth,
                          height: screenHeight * 0.866,
                          color: Colors.white,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: Productmodel.products!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return categories(
                                  Productmodel.products![index].id.toString(),
                                  Productmodel.products![index].images!.first,
                                  Productmodel.products![index].title,
                                  Productmodel.products![index].price,
                                  screenWidth,
                                  screenHeight);
                            },
                          ))
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget categories(String id, String img, String productName,
      double productPrice, screenWidth, screenHeight) {
    return Padding(
        padding: EdgeInsets.only(
            top: screenHeight * 0.02,
            left: screenWidth * 0.02,
            right: screenWidth * 0.02),
        child: Container(
          width: screenWidth,
          height: screenHeight * 0.15,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 0.01,
                  blurRadius: 7,
                  offset: Offset(0, 5),
                ),
              ],
              border: Border.all(),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              Container(
                width: screenWidth * 0.3,
                height: screenHeight * 0.13,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(img), fit: BoxFit.fill)),
              ),
              Container(
                width: screenWidth * 0.4,
                height: screenHeight * 0.1,
                child: Column(
                  children: [
                    Text(
                      productName,
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      productPrice.toString(),
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                width: screenWidth * 0.25,
                height: screenHeight * 0.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Container(
                    //   width: screenWidth * 1,
                    //   height: screenHeight * 0.05,
                    //   // color: Colors.blue,
                    //   decoration: BoxDecoration(
                    //       color: Colors.blue,
                    //       borderRadius: BorderRadius.all(Radius.circular(10))),
                    //   child: _buildTrailingWidget(),
                    // ),

                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Item Added to cart!'),
                            duration: Durations.short4,
                            backgroundColor: Colors.green,
                          ),
                        );
                        if (cartList.isEmpty) {
                          cartList.add({
                            'id': id,
                            'name': productName,
                            'price': productPrice
                          });
                          totalPrice = totalPrice + productPrice;
                        } else {
                          if (isItemAdded(id)) {
                            for (var i = 0; i < cartList.length; i++) {
                              if (cartList[i]['id'] == id) {
                                cartList[i]['price'] =
                                    cartList[i]['price'] + productPrice;
                                totalPrice = totalPrice + productPrice;
                              }
                            }
                          } else {
                            cartList.add({
                              'id': id,
                              'name': productName,
                              'price': productPrice
                            });
                            totalPrice = totalPrice + productPrice;
                          }
                        }

                        print(cartList);
                        print('Total Price = $totalPrice');
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: screenHeight * 0.01),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green[200],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: _buildTrailingWidget(),
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.25,
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                                color: Colors.green[200],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: Text(
                                'Add to Cart',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.03,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildTrailingWidget() {
    int itemCount = 0;
    return FittedBox(
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.remove,
              color: const Color.fromARGB(255, 255, 37, 22),
            ),
            onPressed: () =>
                setState(() => itemCount != 0 ? itemCount-- : itemCount),
          ),
          Text(
            itemCount.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: const Color.fromARGB(255, 49, 255, 56),
            ),
            onPressed: () => setState(() => itemCount++),
          )
        ],
      ),
    );
  }
}
