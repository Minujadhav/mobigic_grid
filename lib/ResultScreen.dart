import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final List<List<String>> gridData;
  final String searchText;
  final List<List<bool>> highlightedCells;

  ResultScreen({
    required this.gridData,
    required this.searchText,
    List<List<bool>> highlightedCells = const [], // Add a default value here
  }) : this.highlightedCells = highlightedCells;

  @override
  Widget build(BuildContext context) {
    // Initialize the highlighted cells list
    List<List<bool>> updatedHighlightedCells = List.generate(
      gridData.length,
          (row) => List.generate(gridData[row].length, (col) => false),
    );

    for (int row = 0; row < gridData.length; row++) {
      for (int col = 0; col < gridData[row].length; col++) {
        // Search left-to-right (east)
        if (_searchInDirection(row, col, 0, 1)) {
          _highlightInDirection(row, col, 0, 1, updatedHighlightedCells);
        }
        // Search top-to-bottom (south)
        if (_searchInDirection(row, col, 1, 0)) {
          _highlightInDirection(row, col, 1, 0, updatedHighlightedCells);
        }
        // Search diagonal (south-east)
        if (_searchInDirection(row, col, 1, 1)) {
          _highlightInDirection(row, col, 1, 1, updatedHighlightedCells);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the grid with highlighted alphabets
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridData[0].length,
                ),
                itemCount: gridData.length * gridData[0].length,
                itemBuilder: (context, index) {
                  final row = index ~/ gridData[0].length;
                  final col = index % gridData[0].length;

                  return Container(
                    margin: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: updatedHighlightedCells[row][col] ? Colors.yellow : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        gridData[row][col],
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the SearchTextScreen
                  Navigator.pop(context);
                },
                child: Text('Change Search Text'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _searchInDirection(int row, int col, int rowIncrement, int colIncrement) {
    String word = '';

    for (int i = 0; i < searchText.length; i++) {
      int newRow = row + i * rowIncrement;
      int newCol = col + i * colIncrement;

      if (newRow >= 0 &&
          newRow < gridData.length &&
          newCol >= 0 &&
          newCol < gridData[row].length) {
        word += gridData[newRow][newCol];
      } else {
        break;
      }
    }

    return word == searchText;
  }

  void _highlightInDirection(int row, int col, int rowIncrement, int colIncrement, List<List<bool>> updatedHighlightedCells) {
    for (int i = 0; i < searchText.length; i++) {
      int newRow = row + i * rowIncrement;
      int newCol = col + i * colIncrement;
      updatedHighlightedCells[newRow][newCol] = true;
    }
  }
}

