import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travelguide/constants/sizes.dart';
import 'package:travelguide/controllers/search/search_controller.dart';
import 'package:travelguide/widgets/appbar.dart';
import 'package:travelguide/widgets/destination_card_vertical.dart';
import 'package:travelguide/widgets/layouts/grid_layout.dart';


class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final searchController = Get.put(TSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title:
            Text('Search', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace / 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Search bar & Filter Button
              Row(
                children: [
                  /// Search
                  Expanded(
                    // child: TextFormField(
                    //   autofocus: true,
                    //   onChanged: (search) =>
                    //       searchController.searchDestinations(search),
                    //   decoration: const InputDecoration(
                    //       prefixIcon: Icon(Iconsax.search_normal),
                    //       hintText: 'Search'),
                    // ),
                    child: TextField(
                      autofocus: true,
                      onChanged: (search) =>
                        searchController.searchDestinations(search),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.search_normal_1),
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(width: TSizes.spaceBtwItems),

                  /// Filter
                  // OutlinedButton(
                  //   onPressed: () => filterModalBottomSheet(context),
                  //   style: OutlinedButton.styleFrom(
                  //       side: const BorderSide(color: Colors.grey)),
                  //   child: const Icon(Iconsax.setting, color: Colors.grey),
                  // ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Search
              Obx(
                () => searchController.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    :
                    // Show search if not Empty
                    searchController.searchResults.isNotEmpty
                        ? TGridLayout(
                            itemCount: searchController.searchResults.length,
                            itemBuilder: (_, index) => TDestinationCardVertical(
                                destination: searchController.searchResults[index]),
                          )
                        : const SizedBox(),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
