import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travelguide/controllers/favourite/favourite_controller.dart';
import 'package:travelguide/screens/favourite/favourite_screen.dart';
import 'package:travelguide/screens/home/home_screen.dart';
import 'package:travelguide/screens/list_all/all_destination_screen.dart';
import 'package:travelguide/screens/map_view/view_in_map_button_test.dart';
import 'package:travelguide/screens/profile/profile_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Obx(
        () => NavigationBar(
          backgroundColor: Colors.white,
          indicatorColor: Color(0xFF008FA0).withOpacity(0.5),
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.map), label: 'Destinations'),
            NavigationDestination(
                icon: Icon(Iconsax.heart), label: 'Favorites'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
            // NavigationDestination(icon: Icon(Iconsax.location), label: 'Test'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    HomeScreen(),
    AllDestinationScreen(),
    FavouriteScreen(),
    const ProfileScreen(),
    // ViewInMapButtonTest(),
    // CoordinateList(),
  ];
}
