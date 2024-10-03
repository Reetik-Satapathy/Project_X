import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  final int totalOrders;
  final double totalRevenue;

  StatisticsPage({required this.totalOrders, required this.totalRevenue});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Orders: ${widget.totalOrders}',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          Text(
            'Total Revenue: ₹${widget.totalRevenue.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
