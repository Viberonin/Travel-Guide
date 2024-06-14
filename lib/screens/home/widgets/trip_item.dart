import 'package:flutter/material.dart';

class TripItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String price;
  final double rating;

  TripItem({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            SizedBox(height: 10),
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            Text(location, style: Theme.of(context).textTheme.titleSmall),
            Text(price, style: Theme.of(context).textTheme.titleSmall),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                Text(rating.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
