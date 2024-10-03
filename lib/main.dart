import 'package:flutter/material.dart';
import 'package:project_x/pages/stock_intake.dart';
import 'package:project_x/pages/dashboard.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vegetable Billing System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StockInput(),
    );
  }
}

