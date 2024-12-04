import 'package:flutter/material.dart';

class PowerConsumptionPage extends StatefulWidget {
  @override
  _PowerConsumptionPageState createState() => _PowerConsumptionPageState();
}

class _PowerConsumptionPageState extends State<PowerConsumptionPage> {
  final TextEditingController _voltageController = TextEditingController();
  final TextEditingController _currentController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  num? _power;
  num? _energy;

  void _calculatePower() {
    final voltage = num.tryParse(_voltageController.text);
    final current = num.tryParse(_currentController.text);

    if (voltage != null && current != null) {
      setState(() {
        _power = voltage * current; // P = V * I
      });
    } else {
      setState(() {
        _power = null;
      });
    }
  }

  void _calculateEnergy() {
    final time = num.tryParse(_timeController.text);

    if (_power != null && time != null) {
      setState(() {
        _energy = _power! * time; // E = P * time
      });
    } else {
      setState(() {
        _energy = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Power Consumption Tracker'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width > 500 ? 500 : double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _voltageController,
                decoration: InputDecoration(
                  labelText: 'Voltage (V)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _currentController,
                decoration: InputDecoration(
                  labelText: 'Current (A)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _calculatePower,
                child: Text('Calculate Power (W)'),
              ),
              if (_power != null)
                Text(
                  'Power: ${_power!.toStringAsFixed(2)} W',
                  style: TextStyle(fontSize: 18),
                ),
              SizedBox(height: 32),
              TextField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Time (hours)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _calculateEnergy,
                child: Text('Calculate Energy (Wh)'),
              ),
              if (_energy != null)
                Text(
                  'Energy: ${_energy!.toStringAsFixed(2)} Wh',
                  style: TextStyle(fontSize: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
