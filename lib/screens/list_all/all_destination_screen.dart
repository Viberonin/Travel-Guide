import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travelguide/constants/sizes.dart';
import 'package:travelguide/controllers/category/category_controller.dart';
import 'package:travelguide/controllers/category/brand_controller.dart';
import 'package:travelguide/controllers/destination/all_destination_controller.dart';
import 'package:travelguide/controllers/destination/destination_controller.dart';
import 'package:travelguide/controllers/search/search_controller.dart';
import 'package:travelguide/controllers/user/user_controller.dart';
import 'package:travelguide/models/destination_model.dart';
import 'package:travelguide/models/user_model.dart';
import 'package:travelguide/repositories/authentication/auth_repo.dart';
import 'package:travelguide/screens/favourite/favourite_screen.dart';
import 'package:travelguide/screens/home/widgets/categories_widget.dart';
import 'package:travelguide/screens/home/widgets/search_and_filter.dart';
import 'package:travelguide/screens/home/widgets/top_trips_widget.dart';
import 'package:travelguide/utils/cloud_helper_functions.dart';
import 'package:travelguide/utils/device_utility.dart';
import 'package:travelguide/widgets/cards/categories_card.dart';
import 'package:travelguide/widgets/destination_card_vertical.dart';
import 'package:travelguide/widgets/layouts/grid_layout.dart';
import 'package:travelguide/widgets/shimmers/vertical_destination.dart';
import 'package:travelguide/widgets/texts/section_heading.dart';
import 'package:logger/logger.dart';

import '../../widgets/shimmers/categories_shimmer.dart';

class AllDestinationScreen extends StatefulWidget {
  @override
  _AllDestinationScreenState createState() => _AllDestinationScreenState();
}

class _AllDestinationScreenState extends State<AllDestinationScreen> {
  final searchController = Get.put(TSearchController());
  final userController = Get.put(UserController());
  // Query? query;
  Query<Map<String, dynamic>>? query;
  Future<List<DestinationModel>>? futureMethod;
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    userController
        .fetchUserRecord(); // Fetch user record when the screen is initialized
    initializeQuery();
    futureMethod = fetchDestinations();
  }

  void initializeQuery() {
    // Initialize the query variable with the desired Firestore query
    query = FirebaseFirestore.instance.collection('destinations');
  }

  Future<List<DestinationModel>> fetchDestinations() async {
    final snapshot = await query?.get();
    if (snapshot != null) {
      final documents = snapshot.docs;
      final destinations = documents.map((doc) {
        return DestinationModel.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>);
      }).toList();
      return destinations;
    } else {
      print('Snapshot is null'); // Print a message if the snapshot is null
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(TSearchController());
    Get.put(DestinationController());
    Get.put(CategoryController());
    final controller = Get.put(AllDestinationsController());
    final user = userController.user.value;
    final categoryController = Get.put(CategoryController());
    final categories = CategoryController.instance.featuredCategories;
    final brandController = Get.put(BrandController());

    Widget categoriesGrid() {
      return Obx(
        () {
          // Check if categories are still loading
          if (brandController.isLoading.value) return const TBrandsShimmer();

          // Check if there are no featured categories found
          if (brandController.featuredBrands.isEmpty) {
            return Center(
                child: Text('HAHAHAHAHAH',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: Colors.white)));
          } else {
            /// Data Found
            return TGridLayout(
              itemCount: 4,
              mainAxisExtent: 80,
              itemBuilder: (_, index) {
                final brand = brandController.featuredBrands[index];
                return TBrandCard(
                  brand: brand,
                  showBorder: true,
                  // onTap: () => Get.to(() => BrandScreen(brand: brand)),
                );
              },
            );
          }
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
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Explore Destinations",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace / 1.5),
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              SearchAndFilter(),
              const SizedBox(height: TSizes.spaceBtwItems / 1.5),
              // TSectionHeading(title: "Categories", onPressed: () {}),
              const SizedBox(height: TSizes.spaceBtwItems / 1.5),
              // categoriesGrid(),
              FutureBuilder<List<DestinationModel>>(
                future: futureMethod ?? controller.fetchProductsByQuery(query),
                builder: (_, snapshot) {
                  const loader = TVerticalProductShimmer();
                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  final destinations = snapshot.data!;
                  return TGridLayout(
                    itemCount: destinations.length,
                    itemBuilder: (_, index) => TDestinationCardVertical(
                        destination: destinations[index], isNetworkImage: true),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}