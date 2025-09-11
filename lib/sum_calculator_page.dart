import 'package:flutter/material.dart';

class DataCounterScreen extends StatefulWidget {
  const DataCounterScreen({super.key});

  @override
  _DataCounterScreenState createState() => _DataCounterScreenState();
}

class _DataCounterScreenState extends State<DataCounterScreen>
    with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();

  int _characterCount = 0;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _textController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _updateCounts() {
    setState(() {
      String text = _textController.text;
      _characterCount = text.length;
    });
  }

  void _clearText() {
    _textController.clear();
    setState(() {
      _characterCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Counter'),
        backgroundColor: Colors.teal.shade400,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade400, Colors.teal.shade700],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // Input Field
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          controller: _textController,
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText:
                                'Masukkan teks, angka, atau data apapun...\nContoh: Hello World 123 testing 456',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),

                      // Tombol Hitung & Reset
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _updateCounts,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal.shade600,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                  ),
                                ),
                              ),
                              child: Text('Hitung'),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _clearText,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade100,
                                foregroundColor: Colors.teal.shade600,
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                              ),
                              child: Text('Reset'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Count Card
                Expanded(
                  child: SingleChildScrollView(
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.teal.shade800,
                                    Colors.teal.shade400,
                                  ],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.text_fields,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    _characterCount.toString(),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Total Karakter',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
