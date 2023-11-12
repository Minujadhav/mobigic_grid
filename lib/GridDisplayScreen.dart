import 'package:flutter/material.dart';
import 'SearchTextScreen.dart';

class GridDisplayScreen extends StatefulWidget {
  final List<List<String>> gridData;

  GridDisplayScreen({required this.gridData});

  @override
  _GridDisplayScreenState createState() => _GridDisplayScreenState();
}

class _GridDisplayScreenState extends State<GridDisplayScreen> {
  late List<List<bool>> highlightedCells;

  @override
  void initState() {
    super.initState();
    _searchAndHighlight('');
  }

  void _searchAndHighlight(String searchText) {
    highlightedCells = List.generate(
      widget.gridData.length,
          (row) => List.generate(widget.gridData[row].length, (col) => false),
    );

    if (searchText.isNotEmpty) {
      for (int row = 0; row < widget.gridData.length; row++) {
        for (int col = 0; col < widget.gridData[row].length; col++) {
          // Search left-to-right (east)
          if (_searchInDirection(row, col, 0, 1, searchText)) {
            _highlightInDirection(row, col, 0, 1);
          }
          // Search top-to-bottom (south)
          if (_searchInDirection(row, col, 1, 0, searchText)) {
            _highlightInDirection(row, col, 1, 0);
          }
          // Search diagonal (south-east)
          if (_searchInDirection(row, col, 1, 1, searchText)) {
            _highlightInDirection(row, col, 1, 1);
          }
        }
      }
    }
  }

  bool _searchInDirection(int row, int col, int rowIncrement, int colIncrement, String searchText) {
    String word = '';

    for (int i = 0; i < searchText.length; i++) {
      int newRow = row + i * rowIncrement;
      int newCol = col + i * colIncrement;

      if (newRow >= 0 &&
          newRow < widget.gridData.length &&
          newCol >= 0 &&
          newCol < widget.gridData[row].length) {
        word += widget.gridData[newRow][newCol];
      } else {
        break;
      }
    }

    return word == searchText;
  }

  void _highlightInDirection(int row, int col, int rowIncrement, int colIncrement) {
    for (int i = 0; i < widget.gridData.length; i++) {
      int newRow = row + i * rowIncrement;
      int newCol = col + i * colIncrement;
      highlightedCells[newRow][newCol] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid Display'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the grid with highlighting
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.gridData[0].length,
                ),
                itemCount: widget.gridData.length * widget.gridData[0].length,
                itemBuilder: (context, index) {
                  final row = index ~/ widget.gridData[0].length;
                  final col = index % widget.gridData[0].length;

                  return Container(
                    margin: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: highlightedCells[row][col] ? Colors.yellow : null,
                    ),
                    child: Center(
                      child: Text(
                        widget.gridData[row][col],
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the next screen (SearchTextScreen)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchTextScreen(
                        gridData: widget.gridData,
                        onSearch: (searchText) {
                          setState(() {
                            _searchAndHighlight(searchText);
                          });
                        },
                      ),
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