// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_x/pages/dashboard.dart';

class StockInput extends StatefulWidget {
  @override
  _StockInputState createState() => _StockInputState();
}

class _StockInputState extends State<StockInput> {
  final TextEditingController _merchantNameController = TextEditingController();
  final TextEditingController _counterNumberController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final List<Map<String, dynamic>> _vegetables = [
    {'name': TextEditingController(),'price': TextEditingController(), 'quantity': TextEditingController(),'max': TextEditingController()},
  ];

  void _addVegetableField() {
    setState(() {
      _vegetables.add({'name': TextEditingController(),'price': TextEditingController(), 'quantity': TextEditingController(),'max': TextEditingController()});
    });
  }

  void _saveInventory() {
    String merchantName = _merchantNameController.text;
    String counterNumber = _counterNumberController.text;
    String phoneNumber = _phoneNumberController.text;

    if (merchantName.isEmpty || counterNumber.isEmpty || phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter Merchant Name, Phone No. and Counter No.'))
      );
      return;
    }

    List<Map<String, dynamic>> inventory = [];
    bool valid = true;

    for (var veg in _vegetables) {
      String vegName = veg['name'].text;
      String vegQuantity = veg['quantity'].text;
      String price= veg['price'].text;

      if (vegName.isEmpty || vegQuantity.isEmpty || price.isEmpty) {
        valid = false;
        break;
      }
      inventory.add({
        'name': vegName,
        'quantity': vegQuantity,
        'price': price,
        'max': vegQuantity,
      });
    }

    if (!valid) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter all vegetable details.'))
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Dashboard(inventory: inventory),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Inventory Management'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              TextFormField(
                controller: _merchantNameController,
                decoration: InputDecoration(
                  labelText: 'Merchant Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone No.',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),

              TextFormField(
                controller: _counterNumberController,
                decoration: InputDecoration(
                  labelText: 'Counter Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 40),

              Text(
                "Stock Quantity Input",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              Column(
                children: List.generate(_vegetables.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _vegetables[index]['name'],
                            decoration: InputDecoration(
                              labelText: 'Vegetable Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 3),

                        Expanded(
                          child: TextFormField(
                            controller: _vegetables[index]['quantity'],
                            decoration: InputDecoration(
                              labelText: 'Quantity (kg)',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                          ),
                        ),
                        SizedBox(width: 3),

                        Expanded(
                          child: TextFormField(
                            controller: _vegetables[index]['price'],
                            decoration: InputDecoration(
                              labelText: 'Price',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                          ),
                        ),


                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              if (_vegetables.length > 1) {
                                _vegetables.removeAt(index);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }),
              ),

              SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _saveInventory();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    'Save Inventory',
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
      ),

      // Floating Action Button to add more vegetable fields
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20.0,bottom: 20.0),
        child: FloatingActionButton(
          onPressed: _addVegetableField,
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
