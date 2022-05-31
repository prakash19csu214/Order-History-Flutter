import 'package:flutter/material.dart';
import 'package:shopping_buyer_app/modules/widgets/view_product.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(top: 10),
        child: OrderHistory(),
      )),
    );
  }
}
