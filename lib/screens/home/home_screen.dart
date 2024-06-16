import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travelguide/constants/sizes.dart';
import 'package:travelguide/controllers/user/user_controller.dart';
import 'package:travelguide/models/user_model.dart';
import 'package:travelguide/repositories/authentication/auth_repo.dart';
import 'package:travelguide/screens/favourite/favourite_screen.dart';
import 'package:travelguide/screens/home/widgets/categories_widget.dart';
import 'package:travelguide/screens/home/widgets/search_and_filter.dart';
import 'package:travelguide/screens/home/widgets/top_trips_widget.dart';
import 'package:travelguide/screens/list_all/all_destination_screen.dart';
import 'package:travelguide/utils/device_utility.dart';
import 'package:travelguide/screens/home/showcase_destination.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Row(
//           children: [
//             Icon(
//               Iconsax.location,
//               color: Colors.black,
//             ),
//             SizedBox(width: 3),
//             Text(
//               'Surabaya, Jawa Timur',
//               style: GoogleFonts.poppins(fontSize: 16),
//             ),
//             SizedBox(width: 3),
//             Icon(
//               Icons.keyboard_arrow_down,
//               color: Colors.yellow,
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               Iconsax.notification5,
//               color: Colors.black,
//             ),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               SearchAndFilter(),
//               SizedBox(height: 16),
//               CategoriesWidget(),
//               SizedBox(height: 16),
//               TopTripsWidget(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class _HomeScreenState extends State<HomeScreen> {
  final userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    userController
        .fetchUserRecord(); // Fetch user record when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    final user = userController.user.value;

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
            top: TSizes.defaultSpace,
            left: TSizes.defaultSpace,
            right: TSizes.defaultSpace),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  // 'Hello ${user.firstName!.split(" ")[0]}!',
                  "Hello! How are you feeling today?",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  // '@${user.username}',
                  "Hoping for the rest of your day to be amazing!",
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ],
            ),
          ),
          ClipOval(
            child: Image.asset(
              'assets/images/profile.png',
              height: 54,
              width: 54,
            ),
          )
        ]),
      );
    }

    Widget bannerJelajahiDestinasiAll() {
      return GestureDetector(
        onTap: () {
          Get.put(AllDestinationScreen());
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          margin: EdgeInsets.only(
            top: TSizes.defaultSpace,
            right: TSizes.defaultSpace,
            left: TSizes.defaultSpace,
          ),
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFFFCD5D)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Jelajahi Destinasi",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "Sesuka Kamu",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Cek Sekarang",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 18,
                      )
                    ],
                  )
                ],
              ),
              Image.asset(
                'assets/images/onb_1.png',
                // height: 150,
                fit: BoxFit.contain,
              )
            ],
          ),
        ),
      );
    }

    Widget bannerKunjungiFavorit() {
      return GestureDetector(
        onTap: () {
          Get.to(FavouriteScreen());
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          margin: EdgeInsets.only(
            top: TSizes.defaultSpace,
            right: TSizes.defaultSpace,
            left: TSizes.defaultSpace,
          ),
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff38ABBE)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Lihat Apa Saja",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "Tempat Favoritmu",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Kunjungi Sekarang",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 18,
                      )
                    ],
                  )
                ],
              ),
              Image.asset(
                'assets/images/onb_1.png',
                // height: 150,
                fit: BoxFit.contain,
              )
            ],
          ),
        ),
      );
    }

    Widget TrendingDestinationTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: TSizes.defaultSpace,
          right: TSizes.defaultSpace,
          left: TSizes.defaultSpace,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trending Destinations',
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            GestureDetector(
              onTap: () {
                Get.to(AllDestinationScreen());
              },
              child: Text(
                "See All",
                style: GoogleFonts.poppins(
                    fontSize: 16, color: Colors.black.withOpacity(0.5)),
              ),
            )
          ],
        ),
      );
    }

    // List of destination data
    final destinations = [
      {
        "imageUrl": 'assets/images/komodo.jpeg',
        "title": 'Gua Jomblang',
        "rating": '4.7',
        "location": 'Lumajang',
        "price": '40',
      },
      {
        "imageUrl": 'assets/images/komodo.jpeg',
        "title": 'Bromo Mountain',
        "rating": '4.8',
        "location": 'Malang',
        "price": '50',
      },
      {
        "imageUrl": 'assets/images/komodo.jpeg',
        "title": 'Borobudur Temple',
        "rating": '4.9',
        "location": 'Magelang',
        "price": '60',
      },
    ];

    Widget showcaseDestinations() {
      return ListView.builder(
        shrinkWrap: true, // Important to prevent infinite height error
        physics: NeverScrollableScrollPhysics(), // Prevent scrolling inside ListView
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          final destination = destinations[index];
          return ShowcaseDestination(
            imageUrl: destination['imageUrl']?.toString() ?? '',
            title: destination['title']?.toString() ?? '',
            rating: destination['rating']?.toString() ?? '',
            location: destination['location']?.toString() ?? '',
            price: destination['price']?.toString() ?? '',
          );
        },
      );
    }
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 1), () {
          setState(() {
            // loadProduct();
          });
        });
      },
      child: ListView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          header(),
          bannerJelajahiDestinasiAll(),
          bannerKunjungiFavorit(),
          TrendingDestinationTitle(),
          showcaseDestinations(),
        ],
      ),
    );
  }
}
