import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopTripsWidget extends StatefulWidget {
  @override
  _TopTripsWidgetState createState() => _TopTripsWidgetState();
}

class _TopTripsWidgetState extends State<TopTripsWidget> {
  List<bool> favorites = List.generate(3, (index) => false);

  final List<Map<String, dynamic>> trips = [
    {
      'image': 'assets/images/onb_1.png',
      'name': 'Gua Jomblang',
      'location': 'Lumajang',
      'price': '\$40 /Visit',
      'rating': 4.7
    },
    {
      'image': 'assets/images/onb_1.png',
      'name': 'Gua Pindul',
      'location': 'Pasuruan',
      'price': '\$40 /Visit',
      'rating': 4.6
    },
    {
      'image': 'assets/images/onb_1.png',
      'name': 'Gua Maria',
      'location': 'Lamongan',
      'price': '\$40 /Visit',
      'rating': 4.5
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top Trips',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: trips.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(DetailScreen());
                },
                child: Container(
                  width: 160,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              trips[index]['image'],
                              height: 100,
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(
                                favorites[index]
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: favorites[index]
                                    ? Colors.red
                                    : Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  favorites[index] = !favorites[index];
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        trips[index]['name'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        trips[index]['location'],
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            trips[index]['price'],
                            style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 16,
                              ),
                              Text(
                                trips[index]['rating'].toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: Center(
        child: Text('Detail Content Here'),
      ),
    );
  }
}
