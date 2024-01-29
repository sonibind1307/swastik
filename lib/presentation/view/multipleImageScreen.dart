import 'package:flutter/material.dart';

class MultiImageScreen extends StatelessWidget {
  final List<String> items = List.generate(0, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          icon: const Icon(Icons.image),
          label: const Text("Generate Pdf")),
      appBar: AppBar(
        title: const Text("Generate PDF"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: items.length + 1, // Add 1 for the "Add" button
        itemBuilder: (BuildContext context, int index) {
          if (index == items.length) {
            return InkWell(
              onTap: () {
                // Handle add button tap
                print('Add button tapped');
              },
              child: Container(
                color: Colors.grey.withOpacity(0.5),
                child: Icon(Icons.add),
              ),
            );
          }
          return Container(
            color: Colors.blueAccent,
            alignment: Alignment.center,
            child: Text(items[index]),
          );
        },
      ),
    );
  }
}
