import 'package:flutter/material.dart';
import 'AlphabetInputScreen.dart';

class GridInputScreen extends StatefulWidget {
  @override
  _GridInputScreenState createState() => _GridInputScreenState();
}

class _GridInputScreenState extends State<GridInputScreen> {
  late int m;
  late int n;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid Input'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter number of rows (m)'),
              onChanged: (value) {
                setState(() {
                  m = int.parse(value);
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter number of columns (n)'),
              onChanged: (value) {
                setState(() {
                  n = int.parse(value);
                });
              },
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (m > 0 && n > 0) {
                  // Navigate to the next screen (AlphabetInputScreen)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlphabetInputScreen(m: m, n: n),
                    ),
                  );
                } else {
                  // Show an error message if m or n is not valid
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Please enter valid values for m and n.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}