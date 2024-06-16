import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesWidget extends StatefulWidget {
  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.terrain, 'label': 'Cave'},
    {'icon': Icons.museum, 'label': 'Museum'},
    {'icon': Icons.account_balance, 'label': 'Religious'},
    {'icon': Icons.history, 'label': 'Historical'},
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
              'Categories',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selectedIndex == index ? Colors.teal : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        categories[index]['icon'],
                        color: Colors.teal,
                      ),
                      SizedBox(width: 8),
                      Text(categories[index]['label']),
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
