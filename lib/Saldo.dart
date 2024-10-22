// Saldo.dart
import 'package:flutter/material.dart';

class Saldo extends StatefulWidget {
  final Function(int) onSuppliesChanged;

  Saldo({required this.onSuppliesChanged});

  @override
  _SaldoState createState() => _SaldoState();
}

class _SaldoState extends State<Saldo> {
  double _currentSupplies = 500;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.storage,
            color: Colors.blueAccent,
            size: 100,
          ),
          SizedBox(height: 20),
          Text(
            "Defina a Quantidade de Suprimentos",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(height: 20),
          Slider(
            value: _currentSupplies,
            min: 1,
            max: 1000,
            divisions: 999,
            activeColor: Colors.blueAccent,
            inactiveColor: Colors.grey,
            label: _currentSupplies.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSupplies = value;
                widget.onSuppliesChanged(_currentSupplies.round());
              });
            },
          ),
          SizedBox(height: 10),
          Text(
            "${_currentSupplies.round()} kg",
            style: TextStyle(fontSize: 18, color: Colors.blueAccent),
          ),
        ],
      ),
    );
  }
}
