import 'package:flutter/material.dart';

class LedResistorCalculatorPage extends StatefulWidget {
  @override
  _LedResistorCalculatorPageState createState() =>
      _LedResistorCalculatorPageState();
}

class _LedResistorCalculatorPageState
    extends State<LedResistorCalculatorPage> {
  final TextEditingController _supplyVoltageController =
      TextEditingController();
  String? _selectedColor;
  double? _resistorValue;
  double? _resistorWattage;

  final Map<String, double> _ledForwardVoltages = {
    'Red': 1.63,
    'Yellow': 2.1,
    'Orange': 2.03,
    'Blue': 2.48,
    'Green': 1.9,
    'Violet': 2.76,
    'UV': 3.1,
    'White': 3.5,
  };

  void _calculateResistor() {
    final supplyVoltage = double.tryParse(_supplyVoltageController.text);

    if (supplyVoltage != null && _selectedColor != null) {
      final forwardVoltage = _ledForwardVoltages[_selectedColor]!;
      final resistance = (supplyVoltage - forwardVoltage) / 0.020;
      final wattage = resistance * 0.020 * 0.020;

      setState(() {
        _resistorValue = resistance;
        _resistorWattage = wattage;
      });
    } else {
      setState(() {
        _resistorValue = null;
        _resistorWattage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('LED Resistor Calculator'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth > 600 ? 400 : double.infinity, // Wider on large screens
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Select LED Color'),
                    items: _ledForwardVoltages.keys
                        .map((color) => DropdownMenuItem(
                              value: color,
                              child: Text(color),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedColor = value;
                      });
                    },
                    value: _selectedColor,
                  ),
                ),
                SizedBox(height: 24), // Increased vertical padding
                SizedBox(
                  width: screenWidth > 600 ? 400 : double.infinity, // Wider on large screens
                  child: TextField(
                    controller: _supplyVoltageController,
                    decoration: InputDecoration(
                      labelText: 'Supply Voltage (V)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: 24), // Increased vertical padding
                SizedBox(
                  width: screenWidth > 600 ? 400 : double.infinity, // Wider on large screens
                  child: ElevatedButton(
                    onPressed: _calculateResistor,
                    child: Text('Calculate Resistor'),
                  ),
                ),
                SizedBox(height: 24), // Increased vertical padding
                if (_resistorValue != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Resistor Value: ${_resistorValue!.toStringAsFixed(2)} Ω',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16), // Padding between results
                      Text(
                        'Resistor Wattage: ${_resistorWattage!.toStringAsFixed(4)} W',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
