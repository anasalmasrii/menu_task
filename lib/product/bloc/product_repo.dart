import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// import 'package:azzad_app/utils/utility.dart';
import 'package:http/http.dart' as http;
import 'package:menu_task/poducts.dart';
import 'package:menu_task/utility.dart';

class MenuRepository with Utility
// with Utility

{
  Future<ProductModel> ProductRepoFuture() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    String host = 'https://dummyjson.com/products';
    final response = await http.get(
      Uri.parse(host),
      headers: requestHeaders,
    );

    final responseJson = jsonDecode(response.body);

    return ProductModel.fromJson(responseJson);
  }
}
