import 'package:flutter/material.dart';

class EvenOddPage extends StatefulWidget {
  const EvenOddPage({super.key});

  @override
  State<EvenOddPage> createState() => _EvenOddPageState();
}

class _EvenOddPageState extends State<EvenOddPage> {
  final TextEditingController _bilanganController = TextEditingController();
  String _hasil = '';

  void _cekGanjilGenap() {
    if (_bilanganController.text.isEmpty) {
      setState(() {
        _hasil = 'Silakan masukkan bilangan';
      });
      return;
    }

    int? bilangan = int.tryParse(_bilanganController.text);

    if (bilangan == null) {
      setState(() {
        _hasil = 'Input tidak valid! Harap masukkan angka saja';
      });
      return;
    }

    if (bilangan % 2 == 0) {
      setState(() {
        _hasil = '$bilangan adalah bilangan GENAP';
      });
    } else {
      setState(() {
        _hasil = '$bilangan adalah bilangan GANJIL';
      });
    }
  }

  void _reset() {
    _bilanganController.clear();
    setState(() {
      _hasil = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cek Ganjil/Genap'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: _bilanganController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Masukkan Bilangan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _cekGanjilGenap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('Cek'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _reset,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('Reset'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _hasil.isEmpty ? 'Hasil' : _hasil,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
