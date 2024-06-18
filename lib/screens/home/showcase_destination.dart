// import 'package:flutter/material.dart';
// import 'package:travelguide/screens/list_all/all_destination_screen.dart';
// import 'package:travelguide/constants/sizes.dart';
// import 'package:get/get.dart';

// class ShowcaseDestination extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String rating;
//   final String location;
//   final String price;

//   ShowcaseDestination({
//     required this.imageUrl,
//     required this.title,
//     required this.rating,
//     required this.location,
//     required this.price,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Get.to(AllDestinationScreen());
//       },
//       child: Container(
//         margin: EdgeInsets.only(
//           top: TSizes.defaultSpace,
//           right: TSizes.defaultSpace,
//           left: TSizes.defaultSpace,
//         ),
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           elevation: 5,
//           child: Container(
//             width: 200,
//             padding: EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(15.0),
//                   child: Image.asset(
//                     imageUrl, // Use the parameter imageUrl
//                     height: 120,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 SizedBox(height: 8.0),
//                 Text(
//                   title, // Use the parameter title
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.star,
//                       color: Colors.amber,
//                       size: 20.0,
//                     ),
//                     Text(
//                       rating.toString(), // Use the parameter rating
//                       style: TextStyle(
//                         fontSize: 14.0,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.location_on,
//                       color: Colors.grey,
//                       size: 20.0,
//                     ),
//                     Text(
//                       location, // Use the parameter location
//                       style: TextStyle(
//                         fontSize: 14.0,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 8.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '\$$price / Visit', // Use the parameter price
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     Icon(
//                       Icons.favorite,
//                       color: Colors.teal,
//                       size: 20.0,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelguide/screens/list_all/all_destination_screen.dart';
import 'package:travelguide/constants/sizes.dart';
import 'package:get/get.dart';

class ShowcaseDestination extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String rating;
  final String location;
  final String price;

  ShowcaseDestination({
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.location,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(AllDestinationScreen());
      },
      child: Container(
        margin: EdgeInsets.only(
          top: TSizes.defaultSpace,
          right: TSizes.defaultSpace,
          left: TSizes.defaultSpace,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Container(
            width: 200,
            constraints: BoxConstraints(
              minHeight: 250, // Adjust the minimum height as needed
              maxHeight: 300, // Adjust the maximum height as needed
            ),
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    imageUrl, // Use the parameter imageUrl
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title, // Use the parameter title
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 30.0,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          rating, // Use the parameter rating
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 25.0,
                    ),
                    SizedBox(width: 4.0),
                    Expanded(
                      child: Text(
                        location, // Use the parameter location
                        style: GoogleFonts.poppins(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$$price / Visit', // Use the parameter price
                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.blue),
                    ),
                    // Icon(
                    //   Icons.favorite,
                    //   color: Colors.teal,
                    //   size: 30.0,
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
