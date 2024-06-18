import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/sizes.dart';
import '../../models/destination_model.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  /// Variables
  RxString selectedDestinationImage = ''.obs;


  /// -- Get All Images from Destination and Variations
  List<String> getAllDestinationImages(DestinationModel destination) {
    // Use Set to add unique images only
    Set<String> images = {};

    // Load thumbnail image
    images.add(destination.thumbnail);
    // Assign Thumbnail as Selected Image
    selectedDestinationImage.value = destination.thumbnail;

    // Get all images from the Product Model if not null.
    if (destination.images != null) {
      images.addAll(destination.images!);
    }

    // Get all images from the destination Variations if not null.
    // if (destination.destinationVariations != null || destination.destinationVariations!.isNotEmpty) {
    //   images.addAll(destination.destinationVariations!.map((variation) => variation.image));
    // }

    return images.toList();
  }

  /// -- Show Image Popup
  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace * 2, horizontal: TSizes.defaultSpace),
                child: CachedNetworkImage(imageUrl: image),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 150,
                  child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Close')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
