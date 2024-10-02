// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'transaction_page.dart';
import 'add_extra_stock.dart';

class Dashboard extends StatelessWidget {
  final List<Map<String, dynamic>> inventory;

  Dashboard({required this.inventory});

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
        title: Text('Inventory Dashboard'),
        backgroundColor: Colors.blue,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu), // Menu icon on the left
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer when clicked
              },
            );
          },
        ),
      ),
      drawer: Container(
        width: 350, // Set the desired width for the drawer
        child: Drawer(
          child: Container(
            color: Colors.white, // Change this to your desired background color
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  tileColor: Colors.lightBlueAccent,
                  title: Text(
                    'Add More Stock',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddMoreStock(inventory: inventory)),
                    );
                  },
                ),
                ListTile(
                  tileColor: Colors.lightGreenAccent,
                  title: Text(
                    'Transaction',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TransactionPage(inventory: inventory)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: inventory.length,
                itemBuilder: (context, index) {
                  String vegetableName = inventory[index]['name'];
                  double quantity = double.parse(inventory[index]['quantity']);
                  double maxQuantity = double.parse(inventory[index]['max']);
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
                          height: 45,
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
            // Button to navigate to Transaction Page
            SizedBox(height: 20), // Space before button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionPage(inventory: inventory),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  'Go to Transaction Page',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
