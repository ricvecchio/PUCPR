import 'package:flutter/material.dart';
import 'screens/classification_medicine.dart';
import 'screens/list_medicine.dart';
import 'screens/add_medicine.dart';

void main() {
  runApp(MediCareApp());
}

class MediCareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediCare',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/classification-medicine': (context) => ClassificationMedicine(),
        '/list-medicine': (context) => ListMedicine(),
        '/add-medicine': (context) => AddMedicine(),
      },
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('MediCare'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/logo-medicare.jpeg',
              fit: BoxFit.cover, // Cobrir toda a tela sem distorção
            ),
          ),
          Positioned(
            bottom: screenSize.height * 0.05, // Responsivo com base na altura
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/classification-medicine');
                },
                child: Text(
                  'Comece aqui!',
                  style: TextStyle(
                    fontSize: screenSize.width * 0.03, // Fonte responsiva
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.06, // Largura responsiva
                    vertical: screenSize.height * 0.010, // Altura responsiva
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
