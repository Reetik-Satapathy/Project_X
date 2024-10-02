// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dashboard.dart';

class AddMoreStock extends StatefulWidget {
  final List<Map<String, dynamic>> inventory;

  AddMoreStock({required this.inventory});

  @override
  _AddMoreStockState createState() => _AddMoreStockState();
}

class _AddMoreStockState extends State<AddMoreStock> {
  String? selectedVegetable;
  final TextEditingController _quantityController = TextEditingController();

  void _updateStock() {
    String vegName = selectedVegetable ?? "";
    String addedQuantity = _quantityController.text;

    if (vegName.isEmpty || addedQuantity.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a vegetable and enter the quantity.')),
      );
      return;
    }

    double addedQty = double.parse(addedQuantity);
    bool found = false;

    for (var veg in widget.inventory) {
      if (veg['name'] == vegName) {
        double currentQty = double.parse(veg['quantity']);
        double updatedQty = currentQty + addedQty;
        veg['quantity'] = updatedQty.toString();
        veg['max'] = (double.parse(veg['max']) + addedQty).toString();
        found = true;
        break;
      }
    }

    if (!found) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected vegetable not found.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Dashboard(inventory: widget.inventory),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add More Stock'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedVegetable,
              items: widget.inventory.map((veg) {
                return DropdownMenuItem<String>(
                  value: veg['name'],
                  child: Text(veg['name']),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedVegetable = newValue;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Vegetable',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity to Add (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _updateStock,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  'Update Stock',
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
