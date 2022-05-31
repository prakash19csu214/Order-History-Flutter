import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:shopping_buyer_app/modules/models/orders.dart';
import '/modules/repository/product_repo.dart';

import '../models/product.dart';

class ViewProduct extends StatelessWidget {
  ProductRepository repo = ProductRepository();
  late Product product;

  @override
  //   Size deviceSize = MediaQuery.of(context).size;
  //   return Scaffold(
  //       body: FutureBuilder(
  //       future: ReadJsonData(),
  //       builder: (context,snapshot){
  //         if (snapshot.hasError) {
  //               print("Error is ...");
  //               print(snapshot.error);
  //               return Center(
  //                 child: Text('Some error in retrieving products'),
  //               );
  //             } else {
  //               var items =snapshot.data as List<Order>;
  //           return ListView.builder(
  //             itemCount: items == null? 0: items.length,
  //               itemBuilder: (context,index){
  //                 return Container(
  //                           width: deviceSize.width / 5.2,
  //                           child: Image.network(product.url)),
  //                       title: Text(product.name),
  //                       // subtitle: Text(snapshot.data![index].desc),
  //                       subtitle: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(product.desc),
  //                           Text("Quantity : ${product.qty}")
  //                         ],
  //                       ),
  //                       trailing: Row(
  //                         mainAxisSize: MainAxisSize
  //                             .min, //without this it takes main axis size as size which overflow and gives error
  //                         children: [
  //                           IconButton(
  //                               onPressed: () {
  //                                 //update the product
  //                               },
  //                               icon: Icon(Icons.edit)),
  //                           IconButton(
  //                               onPressed: () {
  //                                 //delete the product
  //                               },
  //                               icon: Icon(
  //                                 Icons.delete,
  //                                 color: Colors.red,
  //                               ))
  //                         ],
  //                       ));
  //                 },
  //                 itemCount: snapshot.data!.docs.length,
  //               );
  //             }
  //           })));
  // }
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
          // var items = data.data as List<Order>;
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
                        //   Image(
                        //     image:
                        //         NetworkImage(items[index].imageURL.toString()),
                        //     fit: BoxFit.fill,
                        //   ),
                        // ),
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
    // Future<List> ReadJsonData() async {
    var jsondata = rootBundle.rootBundle.loadString('jsonfiles/orders.json');
    // var listtemp = json.decode(jsondata);
    // final list = jsonDecode(jsondata);
    // print(list[0]);
    // var list = listtemp['Orders'];
    // print(list[0]['id']);
    // return list.map((e) => Order.FromJSON(e)).toList();
    return jsondata;
  }
  // Widget build(BuildContext context) {
  //   Size deviceSize = MediaQuery.of(context).size;
  //   ProductRepository repo = ProductRepository();
  //   return Container(
  //     child: FutureBuilder(
  //       future: repo.read(), //Firebase read operation, which give future
  //       builder: (BuildContext ctx, AsyncSnapshot<List<Product>> snapshot) {
  //         ConnectionState state = snapshot.connectionState;
  //         if (state == ConnectionState.waiting) {
  //           //loading
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         } else if (snapshot.hasError) {
  //           print("Error is ...");
  //           print(snapshot.error);
  //           return Center(
  //             child: Text('Some error in retrieving products'),
  //           );
  //         } else {
  //           //it has data
  //           return ListView.builder(
  //             itemBuilder: (BuildContext ctx, int index) {
  //               return ListTile(
  //                   leading: Container(
  //                       width: deviceSize.width / 5.2,
  //                       child: Image.network(snapshot.data![index].url)),
  //                   title: Text(snapshot.data![index].name),
  //                   // subtitle: Text(snapshot.data![index].desc),
  //                   subtitle: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(snapshot.data![index].desc),
  //                       Text("Quantity : ${snapshot.data![index].qty}")
  //                     ],
  //                   ),
  //                   trailing: Row(
  //                     mainAxisSize: MainAxisSize.min,//without this it takes main axis size as size which overflow and gives error
  //                     children: [
  //                       IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
  //                       IconButton(
  //                           onPressed: () {},
  //                           icon: Icon(
  //                             Icons.delete,
  //                             color: Colors.red,
  //                           ))
  //                     ],
  //                   )
  //                   );
  //             },
  //             itemCount: snapshot.data!.length,
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }
}
