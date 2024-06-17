import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travelguide/constants/image_strings.dart';
import 'package:travelguide/constants/sizes.dart';
import 'package:travelguide/controllers/favourite/favourite_controller.dart';
import 'package:travelguide/screens/home/home_screen.dart';
import 'package:travelguide/screens/list_all/all_destination_screen.dart';
import 'package:travelguide/utils/cloud_helper_functions.dart';
import 'package:travelguide/utils/device_utility.dart';
import 'package:travelguide/widgets/loaders/animation_loader.dart';
import 'package:travelguide/widgets/appbar.dart';
import 'package:travelguide/widgets/layouts/grid_layout.dart';
import 'package:travelguide/widgets/shimmers/vertical_destination.dart';
import 'package:travelguide/widgets/destination_card_vertical.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FavouritesController()); 
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: TAppBar(
      //   title: Text('Wishlist',
      //       style: Theme.of(context).textTheme.headlineMedium),
      //   // actions: [TCircularIcon(icon: Iconsax.add, onPressed: () => Get.to(() => const StoreScreen()))],
      // ),
      appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      // leading: IconButton(
      //     onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left)),
      title: Text("Your Saved Places", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
      centerTitle: true,
    ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Products Grid
              Obx(() {
                return FutureBuilder(
                  future:
                      FavouritesController.instance.favoriteDestinations(),
                  builder: (_, snapshot) {
                    /// Nothing Found Widget
                    final emptyWidget = TAnimationLoaderWidget(
                      text: 'Whoops! Wishlist is Empty...',
                      animation: TImages.pencilAnimation,
                      showAction: true,
                      actionText: 'Let\'s add some',
                      onActionPressed: () => Get.to(() => AllDestinationScreen()),
                    );
                    const loader = TVerticalProductShimmer(itemCount: 6);
                    final widget =
                        TCloudHelperFunctions.checkMultiRecordState(
                            snapshot: snapshot,
                            loader: loader,
                            nothingFound: emptyWidget);
                    if (widget != null) return widget;
    
                    final destinations = snapshot.data!;
                    return TGridLayout(
                      itemCount: destinations.length,
                      itemBuilder: (_, index) => TDestinationCardVertical(
                          destination: destinations[index]),
                    );
                  },
                );
              }),
              SizedBox(
                  height: TDeviceUtils.getBottomNavigationBarHeight() +
                      TSizes.defaultSpace),
            ],
          ),
        ),
      ),
    );
  }
}
