import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // compute

// Hàm chạy trong isolate riêng
BigInt _factorial(int n) {
  BigInt result = BigInt.one;
  for (int i = 1; i <= n; i++) {
    result *= BigInt.from(i);
  }
  return result;
}

class FactorialIsolateScreen extends StatefulWidget {
  const FactorialIsolateScreen({super.key});

  @override
  State<FactorialIsolateScreen> createState() =>
      _FactorialIsolateScreenState();
}

class _FactorialIsolateScreenState extends State<FactorialIsolateScreen> {
  final _nController = TextEditingController(text: '3000');
  bool _isLoading = false;
  String _resultSummary = 'No calculation yet';

  Future<void> _startFactorial() async {
    final n = int.tryParse(_nController.text.trim());
    if (n == null || n < 0) {
      setState(() => _resultSummary = 'Invalid n');
      return;
    }

    setState(() {
      _isLoading = true;
      _resultSummary = 'Calculating $n! in isolate...';
    });

    try {
      final big = await compute(_factorial, n);

      final text = big.toString();
      final length = text.length;
      final preview =
      text.length > 30 ? '${text.substring(0, 30)}...' : text;

      setState(() {
        _resultSummary =
        'n = $n\nDigits: $length\nFirst digits: $preview';
      });
    } catch (e) {
      setState(() {
        _resultSummary = 'Error: $e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Factorial with Isolate')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Calculates n! using compute() isolate.\n'
                  'Warning: very large n may be slow.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter n (e.g. 3000)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _isLoading ? null : _startFactorial,
              child: const Text('Start Factorial'),
            ),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_resultSummary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
