// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'transaction_page.dart';
import 'add_extra_stock.dart';
import 'stats.dart';

class Dashboard extends StatefulWidget {
  final List<Map<String, dynamic>> inventory;

  Dashboard({required this.inventory});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int numberOfOrders = 0;
  double totalRevenue = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void updateTotalRevenue(double amount) {
    setState(() {
      totalRevenue += amount;
      // print(totalRevenue);
    });
  }

  void updateOrderCount(int count) {
    setState(() {
      numberOfOrders += count;
      // print(numberOfOrders);
    });
  }

  Color _getProgressColor(double progress) {
    if (progress <= 0.3) {
      return Colors.red;
    } else if (progress <= 0.6) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 35.0,
            ),
          ),
        ),
        //toolbarHeight: 40.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Colors.red, Colors.blue]),
          ),
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          indicatorColor: Colors.black,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 14),
          tabs: [
            Tab(text: 'Inventory'),
            Tab(text: 'Transaction'),
            Tab(text: 'Add Stock'),
            Tab(text: 'Stats'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Inventory Page
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.inventory.length,
                    itemBuilder: (context, index) {
                      String vegetableName = widget.inventory[index]['name'];
                      double quantity = double.parse(widget.inventory[index]['quantity']);
                      double maxQuantity = double.parse(widget.inventory[index]['max']);
                      double progressValue = quantity / maxQuantity;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vegetableName,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 35,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  LiquidLinearProgressIndicator(
                                    value: progressValue,
                                    valueColor: AlwaysStoppedAnimation(_getProgressColor(progressValue)),
                                    backgroundColor: Colors.white,
                                    borderColor: _getProgressColor(progressValue),
                                    borderWidth: 1.0,
                                    borderRadius: 30.0,
                                    direction: Axis.horizontal,
                                  ),
                                  Text(
                                    '$quantity / $maxQuantity kg',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 3),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          TransactionPage(
            inventory: widget.inventory,
            updateOrderCount: updateOrderCount,
            updateTotalRevenue: updateTotalRevenue,
          ),
          AddMoreStock(inventory: widget.inventory),
          StatisticsPage(
            totalOrders: numberOfOrders,
            totalRevenue: totalRevenue,
          ),
        ],
      ),
    );
  }
}
