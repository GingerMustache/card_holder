import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: GridViewBuilderWidget(),
      ),
    );
  }
}

class GridViewBuilderWidget extends StatelessWidget {
  const GridViewBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 16.0, // Spacing between columns
        mainAxisSpacing: 16.0, // Spacing between rows
        childAspectRatio: 1.65, // Aspect ratio of each item
      ),
      itemCount: 10, // Number of items
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.orange[300],
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6,
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Item ${index + 1}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
