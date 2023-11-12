import 'package:flutter/material.dart';

import 'GridDisplayScreen.dart';

class AlphabetInputScreen extends StatefulWidget {
  final int m;
  final int n;

  AlphabetInputScreen({required this.m, required this.n});

  @override
  _AlphabetInputScreenState createState() => _AlphabetInputScreenState();
}

class _AlphabetInputScreenState extends State<AlphabetInputScreen> {
  late List<List<TextEditingController>> controllers;

  @override
  void initState() {
    super.initState();
    // Initialize the list of text controllers
    controllers = List.generate(widget.m, (row) {
      return List.generate(widget.n, (col) => TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alphabet Input'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Create a grid of text fields for alphabet input
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.n,
                ),
                itemCount: widget.m * widget.n,
                itemBuilder: (context, index) {
                  final row = index ~/ widget.n;
                  final col = index % widget.n;

                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controllers[row][col],
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        counterText: '', // Remove character count
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Extract the entered alphabets from the controllers
                  List<List<String>> alphabetGrid = List.generate(widget.m, (row) {
                    return List.generate(widget.n, (col) => controllers[row][col].text);
                  });

                  // Navigate to the next screen (GridDisplayScreen)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GridDisplayScreen(gridData: alphabetGrid),
                    ),
                  );
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}