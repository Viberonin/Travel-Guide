// import 'package:flutter/material.dart';
// import 'package:travelguide/screens/home/top_trip_card.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: _buildLocationIndicator(),
//         actions: [
//           _buildNotificationIcon(),
//         ],
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: _buildSearchSection(),
//             ),
//             SizedBox(height: 10),
//             _buildTopTripsSection(),
//             // The rest of your UI will go here.
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLocationIndicator() {
//     return Row(
//       children: <Widget>[
//         Icon(Icons.location_on, color: Colors.black54),
//         SizedBox(width: 4.0),
//         Text(
//           'Surabaya, Jawa Timur',
//           style: TextStyle(
//             color: Colors.black54,
//             fontSize: 16.0,
//           ),
//         ),
//         Icon(Icons.arrow_drop_down, color: Colors.black54),
//       ],
//     );
//   }

//   Widget _buildNotificationIcon() {
//     return IconButton(
//       icon: Icon(Icons.notifications_none, color: Colors.black54),
//       onPressed: () {
//         // Define the action when the notification icon is pressed.
//       },
//     );
//   }

//   Widget _buildSearchSection() {
//     // Assuming 48.0 is the height you want for both the TextField and the ElevatedButton
//     final double buttonHeight = 48.0;
//     final double buttonWidth = buttonHeight; // To make the button a circle with equal width and height

//     return Row(
//       children: <Widget>[
//         Expanded(
//           child: TextField(
//             decoration: InputDecoration(
//               hintText: 'Search',
//               prefixIcon: Icon(Icons.search),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30.0),
//                 borderSide: BorderSide.none,
//               ),
//               filled: true,
//               fillColor: Colors.grey[200],
//               isDense: true, // Added to control the field's density
//               contentPadding: EdgeInsets.fromLTRB(20, buttonHeight / 2 - 12, 20, buttonHeight / 2 - 12), // Adjusts padding to center the text vertically
//             ),
//           ),
//         ),
//         SizedBox(width: 10),
//         ElevatedButton(
//           onPressed: () {
//             // Define the action for the filter button.
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blue, // Background color
//             shape: CircleBorder(),
//             padding: EdgeInsets.zero, // Padding is set to zero
//           ).copyWith( // Using copyWith to specify the fixedSize
//             fixedSize: WidgetStateProperty.all<Size>(Size(buttonWidth, buttonHeight)),
//           ),
//           child: Icon(Icons.filter_list, color: Colors.white),
//         ),
//       ],
//     );
//   }

//   Widget _buildTopTripsSection() {
//     return Container(
//       height: 220, // Set a fixed height for the horizontal list
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 10, // The number of top trips cards
//         itemBuilder: (BuildContext context, int index) {
//           return TopTripCard(
//             // Assuming you have a model or data structure, pass the relevant data here
//             title: 'Gua Jomblang',
//             rating: 4.7,
//             location: 'Lumajang',
//             price: '\$40/Visit',
//             imageUrl: 'assets/images/trip_image.jpg', // Replace with your actual image asset or network image path
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'widgets/category_item.dart';
// import 'widgets/trip_item.dart';
// import 'widgets/location_search.dart';
// import 'widgets/search_bar.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: LocationSearch(),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SearchBarWid(),
//             SizedBox(height: 10),
//             Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CategoryItem(label: 'Cave', icon: Icons.terrain),
//                 CategoryItem(label: 'Museum', icon: Icons.museum),
//                 CategoryItem(label: 'Religious', icon: Icons.account_balance),
//                 CategoryItem(label: 'Historical', icon: Icons.history),
//               ],
//             ),
//             SizedBox(height: 20),
//             Text('Top Trips', style: Theme.of(context).textTheme.headlineSmall),
//             SizedBox(height: 10),
//             Expanded(
//               child: ListView(
//                 children: [
//                   TripItem(
//                     imageUrl: 'https://example.com/gua_jomblang.jpg',
//                     title: 'Gua Jomblang',
//                     location: 'Lumajang',
//                     price: '\$40 / Visit',
//                     rating: 4.7,
//                   ),
//                   TripItem(
//                     imageUrl: 'https://example.com/gua_pindul.jpg',
//                     title: 'Gua Pindul',
//                     location: 'Pasuruan',
//                     price: '\$40 / Visit',
//                     rating: 4.6,
//                   ),
//                   TripItem(
//                     imageUrl: 'https://example.com/mt_semeru.jpg',
//                     title: 'Mountain Trip',
//                     location: 'Mt. Semeru, Probolinggo',
//                     price: '\$50 / Visit',
//                     rating: 4.8,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Location'),
//           BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
//           BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:travelguide/components/navbar/navigation_bar.dart';
// import 'package:travelguide/screens/profile/profile_screen.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   TextEditingController _searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HomeScreen UI'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     'Welcome to the HomeScreen!',
//                     style: TextStyle(fontSize: 24),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       Get.to(NavigationMenu());
//                     },
//                     child: Text('Button 1'),
//                   ),
//                   SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       Get.to(ProfileScreen());
//                     },
//                     child: Text('Button 2'),
//                   ),
//                   SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Add your onPressed code here!
//                     },
//                     child: Text('Button 3'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travelguide/screens/home/widgets/categories_widget.dart';
import 'package:travelguide/screens/home/widgets/top_trips_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(
              Icons.location_on,
              color: Colors.black,
            ),
            SizedBox(width: 8),
            Text(
              'Surabaya, Jawa Timur',
              style: TextStyle(color: Colors.black),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.yellow,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(Iconsax.filter4),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), backgroundColor: Colors.teal,
                    padding: EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            CategoriesWidget(),
            SizedBox(height: 16),
            TopTripsWidget(),
          ],
        ),
      ),
    );
  }
}
