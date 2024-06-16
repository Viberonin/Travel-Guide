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
import 'package:travelguide/utils/device_utility.dart';

class AllDestinationScreen extends StatefulWidget {
  @override
  _AllDestinationScreenState createState() => _AllDestinationScreenState();
}

class _AllDestinationScreenState extends State<AllDestinationScreen> {
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

    Widget eAppBar() {
      return AppBar(
        elevation: 0,
        // backgroundColor: Colors.white,
        // surfaceTintColor: Colors.white,
        // leading: IconButton(
        //     onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left)),
        title: Text("Explore Destinations",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
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
          eAppBar(),
          
        ],
      ),
    );
  }
}
