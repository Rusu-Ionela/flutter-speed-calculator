//Am pornit aplicația și am rulat clasa MyApp
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());
//Am făcut o aplicație de tip MaterialApp, i-am pus titlu,
// temă și am setat pagina principală SpeedCalculator
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator viteză medie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const SpeedCalculator(),
    );
  }
}

//Am creat un StatefulWidget,
// ca să pot schimba rezultatul când apăsam pe buton.
class SpeedCalculator extends StatefulWidget {
  const SpeedCalculator({super.key});

  @override
  State<SpeedCalculator> createState() => _SpeedCalculatorState();
}

class _SpeedCalculatorState extends State<SpeedCalculator> {
  //Am folosit două TextEditingController, unul pentru distanță și altul pentru timp.
  // Am pregătit și o variabilă _result unde am salvat rezultatul.
  final _distanceController = TextEditingController();
  final _timeController = TextEditingController();

  String _result = '';
//Am citit valorile din text, le-am transformat în numere.
//Dacă timpul era 0 sau nu era număr, am afișat mesaj de eroare.
//Dacă erau corecte, am împărțit distanța la timp și am calculat viteza medie.
  void _calculateSpeed() {
    final distance = double.tryParse(_distanceController.text);
    final time = double.tryParse(_timeController.text);

    if (distance == null || time == null || time <= 0) {
      setState(() {
        _result = 'Introduceți valori corecte (timp > 0)';
      });
      return;
    }

    final speed = distance / time;
    setState(() {
      _result = 'Viteza medie: ${speed.toStringAsFixed(2)} km/h';
    });
  }
//Am pus două câmpuri TextField pentru date.
//Am adăugat un ElevatedButton care apela funcția de calcul.
//Am afișat rezultatul într-un Text sub buton.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator viteză medie')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _distanceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Distanța (km)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _timeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Timpul (ore)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateSpeed,
              child: const Text('Calculează'),
            ),
            const SizedBox(height: 16),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Adică distanța împărțită la timp.

//  Cum citești corect două valori numerice din două TextField?
// Folosesc TextEditingController pentru fiecare TextField.
// Valoarea se ia ca text cu .text, apoi o transform în număr cu double.tryParse().
//
// Ce verificări trebuie făcute înainte de calcul?
// Să fie valori numerice corecte (nu litere sau gol).
// Timpul să fie mai mare ca 0, altfel nu putem împărți.
//
//  Cum afișezi rezultatul într-un Text după apăsarea butonului?
// Salvez rezultatul într-o variabilă String.
// Folosesc setState() ca să actualizez ecranul.
// Apoi îl afișez simplu cu Text(_result).
//
// Cum extinzi aplicația să lucreze și cu minute/secunde?
// Transform minutele și secundele în ore:
// minute ÷ 60,
// secunde ÷ 3600.
// Apoi le adun la ore și calculez viteza normal.
