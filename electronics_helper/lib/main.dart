import 'package:flutter/material.dart';
import '/pages/led_resistor_calculator_page.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cool Page Selector',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<_Page> pages = [
      _Page(
        title: "LED Resistor Calculator",
        icon: Icons.electrical_services,
        navigateTo: LedResistorCalculatorPage(),
      ),
      _Page(
        title: "Another Feature",
        icon: Icons.lightbulb,
        navigateTo: Placeholder(), // Replace with your next page
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Cool Page Selector'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two items per row
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: pages.length,
          itemBuilder: (context, index) {
            final page = pages[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page.navigateTo),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      page.icon,
                      size: 50,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: 16),
                    Text(
                      page.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Page {
  final String title;
  final IconData icon;
  final Widget navigateTo;

  _Page({
    required this.title,
    required this.icon,
    required this.navigateTo,
  });
}
