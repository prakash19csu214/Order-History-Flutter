import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:shopping_buyer_app/modules/models/orders.dart';
import '/modules/repository/product_repo.dart';

import '../models/product.dart';

class OrderHistory extends StatelessWidget {
  ProductRepository repo = ProductRepository();
  late Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: ReadJsonData(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(child: Text("${data.error}"));
        } else if (data.hasData) {
          var str = data.data.toString();
          var json = jsonDecode(str);
          List<dynamic> list = json['Orders'];
          var items = list.map((e) => Order.FromJSON(e)).toList();
          return ListView.builder(
              itemCount: items == null ? 0 : items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: Icon(Icons.shopping_bag,
                              color: Colors.blue.shade400, size: 50),
                        ),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, right: 8),
                                        child: Text(
                                          "Order No - #" +
                                              items[index].user_id.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, right: 8),
                                        child: Text(
                                          "Total Amount - Rs. " +
                                              items[index].price.toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, right: 8),
                                        child: Text(
                                          "No of Items - " +
                                              items[index]
                                                  .products_list
                                                  .length
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, right: 8),
                                        child: Text(
                                          "Date & Time - " +
                                              items[index].date.toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, right: 8),
                                        child: Text(
                                          "Delivered By - " +
                                              items[index]
                                                  .delivered_by
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, right: 8),
                                        child: Text(
                                          "Delivery Zone - " +
                                              items[index]
                                                  .delivery_zone
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 300.0,
                                        height: 50.0,
                                        child: Card(
                                          color: Colors.blue,
                                          child: Center(
                                            child: Text(
                                              items[index]
                                                  .order_status
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ), //Text
                                          ), //Center
                                        ), //Card
                                      ),
                                    ]),
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  ReadJsonData() {
    var jsondata = rootBundle.rootBundle.loadString('jsonfiles/orders.json');
    return jsondata;
  }
}
