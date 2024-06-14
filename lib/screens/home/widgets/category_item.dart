import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String label;
  final IconData icon;

  CategoryItem({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          child: Icon(icon),
          radius: 25,
        ),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
