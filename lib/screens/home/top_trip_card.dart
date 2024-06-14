import 'package:flutter/material.dart';
import 'package:travelguide/screens/home/heart_button.dart';

class TopTripCard extends StatelessWidget {
  final String title;
  final double rating;
  final String location;
  final String price;
  final String imageUrl;

  const TopTripCard({
    Key? key,
    required this.title,
    required this.rating,
    required this.location,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, // Set a fixed width for each card
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              width: 160,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis, // Ensure text doesn't overflow
          ),
          SizedBox(height: 4),
          Row(
            children: <Widget>[
              Icon(Icons.star, size: 14, color: Colors.amber),
              SizedBox(width: 4),
              Text(rating.toString()),
            ],
          ),
          SizedBox(height: 4),
          Text(
            location,
            overflow: TextOverflow.ellipsis, // Ensure text doesn't overflow
          ),
          SizedBox(height: 4),
          Text(
            price,
            overflow: TextOverflow.ellipsis, // Ensure text doesn't overflow
          ),
          Spacer(), // Use Spacer to push the HeartButton to the bottom
          Align(
            alignment: Alignment.bottomRight,
            child: HeartButton(),
          ),
        ],
      ),
    );
  }
}
