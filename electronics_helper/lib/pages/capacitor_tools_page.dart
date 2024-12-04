import 'package:flutter/material.dart';

class CapacitorToolsPage extends StatefulWidget {
  @override
  _CapacitorToolsPageState createState() => _CapacitorToolsPageState();
}

class _CapacitorToolsPageState extends State<CapacitorToolsPage> {
  final TextEditingController _capacitanceController = TextEditingController();
  final TextEditingController _resistanceController = TextEditingController();
  final TextEditingController _voltageController = TextEditingController();
  final TextEditingController _capacitanceController2 = TextEditingController();

  double? _chargeTime;
  double? _energyCapacity;

  void _calculateChargeTime() {
    final capacitance = double.tryParse(_capacitanceController.text);
    final resistance = double.tryParse(_resistanceController.text);

    if (capacitance != null && resistance != null) {
      setState(() {
        _chargeTime = capacitance * resistance * 5;
      });
    } else {
      setState(() {
        _chargeTime = null;
      });
    }
  }

  void _calculateEnergyCapacity() {
    final capacitance = double.tryParse(_capacitanceController2.text);
    final voltage = double.tryParse(_voltageController.text);

    if (capacitance != null && voltage != null) {
      setState(() {
        _energyCapacity = 0.5 * capacitance * voltage * voltage;
      });
    } else {
      setState(() {
        _energyCapacity = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capacitor Tools'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0,0,16,16),
          child: LayoutBuilder(
            builder: (context, constraints) {

            final double screenWidth = MediaQuery.of(context).size.width;
            final double? containerWidth = screenWidth > 600 ? 400 : double.infinity; // Wider on large screens

              

              
              return SingleChildScrollView(
                child: Container(
                  width: containerWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Capacitor Charge Time',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _capacitanceController,
                        decoration: const InputDecoration(
                          labelText: 'Capacitance (F)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _resistanceController,
                        decoration: const InputDecoration(
                          labelText: 'Resistance (Ω)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: _calculateChargeTime,
                        child: Text('Calculate Charge Time'),
                      ),const SizedBox(height: 32),
                      if (_chargeTime != null)
                        Text(
                          'Charge Time: ${_chargeTime!.toStringAsFixed(2)} seconds',
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      const Padding(
                        padding: const EdgeInsets.only(top:45 , bottom:45),
                        child: Divider(height: 48, thickness: 2),
                      ),
                      const Text(
                        'Capacitor Energy Capacity',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _voltageController,
                        decoration: const InputDecoration(
                          labelText: 'Voltage (V)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _capacitanceController2,
                        decoration: const InputDecoration(
                          labelText: 'Capacitance (F)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _calculateEnergyCapacity,
                        child: const  Text('Calculate Energy Capacity'),
                      ),const SizedBox(height: 32),
                      if (_energyCapacity != null)
                        Text(
                          'Energy Capacity: ${_energyCapacity!.toStringAsFixed(2)} Joules',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
