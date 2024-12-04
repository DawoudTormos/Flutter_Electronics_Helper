import 'package:flutter/material.dart';
import 'dart:math';

class TransistorBiasing extends StatefulWidget {
  @override
  _TransistorBiasingState createState() => _TransistorBiasingState();
}

class _TransistorBiasingState extends State<TransistorBiasing> {
  final TextEditingController _vccController = TextEditingController();
  final TextEditingController _vbeController = TextEditingController();
  final TextEditingController _icController = TextEditingController();
  final TextEditingController _vcController = TextEditingController();
  final TextEditingController _betaController = TextEditingController();
  final TextEditingController _veController = TextEditingController();

  double? _rb, _rc, _re;

  @override
  Widget build(BuildContext context) {

                final double screenWidth = MediaQuery.of(context).size.width;
            final double? containerWidth = screenWidth > 600 ? 400 : double.infinity; 

    return Scaffold(
      appBar: AppBar(
        title: Text('Transistor Biasing Assistant'),
      ),
      body: Center(
        child: LayoutBuilder(
            builder: (context, constraints) {

            final double screenWidth = MediaQuery.of(context).size.width;
            final double? containerWidth = screenWidth > 600 ? 400 : double.infinity; // Wider on large screens

              
              return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  width:containerWidth,
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      TextField(
                        controller: _vccController,
                        decoration: InputDecoration(labelText: 'Supply Voltage (Vcc in V)',border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                      ),SizedBox(height:20),
                      TextField(
                        controller: _vbeController,
                        decoration: InputDecoration(labelText: 'Base-Emitter Voltage (Vbe in V)',border: OutlineInputBorder(),),
                        keyboardType: TextInputType.number,
                      ),SizedBox(height:20),
                      TextField(
                        controller: _icController,
                        decoration: InputDecoration(labelText: 'Collector Current (Ic in A)',border: OutlineInputBorder(),),
                        keyboardType: TextInputType.number,
                      ),SizedBox(height:20),
                      TextField(
                        controller: _vcController,
                        decoration: InputDecoration(labelText: 'Collector Voltage (Vc in V)',border: OutlineInputBorder(),),
                        keyboardType: TextInputType.number,
                      ),SizedBox(height:20),
                      TextField(
                        controller: _betaController,
                        decoration: InputDecoration(labelText: 'Transistor Current Gain (β)',border: OutlineInputBorder(),),
                        keyboardType: TextInputType.number,
                      ),SizedBox(height:20),
                      TextField(
                        controller: _veController,
                        decoration: InputDecoration(labelText: 'Emitter Voltage (Ve in V)',border: OutlineInputBorder(),),
                        keyboardType: TextInputType.number,
                      ),SizedBox(height:20),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _calculateResistorValues,
                        child: Text('Calculate Resistor Values'),
                      ),
                      if (_rb != null && _rc != null && _re != null)
                        Column(
                          children: [
                            SizedBox(height:32),Text('Base Resistor (Rb): ${_rb!.toStringAsFixed(2)} Ω'),SizedBox(height:5),
                            Text('Collector Resistor (Rc): ${_rc!.toStringAsFixed(2)} Ω'),SizedBox(height:5),
                            Text('Emitter Resistor (Re): ${_re!.toStringAsFixed(2)} Ω'),SizedBox(height:5),
                          ],
                        ),SizedBox(height:20),
                    ],
                  ),
                ),
              ),
            );
  }),
      ),
      )
    ;
  }

  // Method to calculate resistor values
  void _calculateResistorValues() {
    double vcc = double.tryParse(_vccController.text) ?? 0.0;
    double vbe = double.tryParse(_vbeController.text) ?? 0.7;
    double ic = double.tryParse(_icController.text) ?? 0.0;
    double vc = double.tryParse(_vcController.text) ?? 0.0;
    double beta = double.tryParse(_betaController.text) ?? 100.0;
    double ve = double.tryParse(_veController.text) ?? 0.0;

    if (vcc > 0 && ic > 0 && beta > 0) {
      // Calculate the base current Ib
      double ib = ic / beta;

      // Calculate the base resistor (Rb)
      _rb = (vcc - vbe) / ib;

      // Calculate the collector resistor (Rc)
      _rc = (vcc - vc) / ic;

      // Calculate the emitter resistor (Re)
      _re = ve / ic;

      setState(() {});
    }
  }
}
