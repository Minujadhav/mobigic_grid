import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ResultScreen.dart';

class SearchTextScreen extends StatefulWidget {
  final List<List<String>> gridData;
  final void Function(String searchText) onSearch;

  SearchTextScreen({required this.gridData, required this.onSearch});

  @override
  _SearchTextScreenState createState() => _SearchTextScreenState();
}

class _SearchTextScreenState extends State<SearchTextScreen> {
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Text'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: searchTextController,
              decoration: InputDecoration(labelText: 'Enter Text to Search'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Call the onSearch callback to update search results
                widget.onSearch(searchTextController.text);

                // Navigate to the ResultScreen with the entered search text
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(
                      gridData: widget.gridData,
                      searchText: searchTextController.text,
                    ),
                  ),
                );
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}