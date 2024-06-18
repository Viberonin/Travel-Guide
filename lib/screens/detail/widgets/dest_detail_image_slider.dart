import 'package:cached_network_image/cached_network_image.dart';
import '../../../controllers/destination/images_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/shapes/curved_edges_widget.dart';
import '../../../widgets/shapes/rounded_image.dart';
import '../../../widgets/icons/favourite_icon.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../../utils/helper_functions.dart';
import '../../../models/destination_model.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider(
      {super.key, required this.destination, this.isNetworkImage = true});

  final DestinationModel destination;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    Get.put(ImagesController());
    final controller = ImagesController.instance;
    final isDark = THelperFunctions.isDarkMode(context);
    final images = controller.getAllDestinationImages(destination);
    
    return TCurvedEdgesWidget(
      child: Container(
        color: isDark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            /// Main Large Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace * 2),
                child: Center(
                  child: Obx(
                    () {
                      final image =
                          controller.selectedDestinationImage.value.isEmpty
                              ? destination.thumbnail
                              : controller.selectedDestinationImage.value;
                      return GestureDetector(
                        onTap: () => controller.showEnlargedImage(image),
                        child: isNetworkImage
                            ? CachedNetworkImage(
                                imageUrl: image,
                                progressIndicatorBuilder:
                                    (_, __, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                            color: TColors.primary),
                                errorWidget: (_, __, ___) =>
                                    const Icon(Icons.error),
                              )
                            : Image(image: AssetImage(image)),
                      );
                    },
                  ),
                ),
              ),
            ),

            /// Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: images.length,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: TSizes.spaceBtwItems),
                  itemBuilder: (_, index) {
                    return Obx(
                      () {
                        final imageSelected =
                            controller.selectedDestinationImage.value ==
                                images[index];
                        return TRoundedImage(
                          isNetworkImage: isNetworkImage,
                          width: 80,
                          fit: BoxFit.cover,
                          imageUrl: images[index],
                          padding: const EdgeInsets.all(TSizes.sm),
                          backgroundColor:
                              isDark ? TColors.dark : TColors.white,
                          onPressed: () => controller
                              .selectedDestinationImage.value = images[index],
                          border: Border.all(
                              color: imageSelected
                                  ? TColors.primary
                                  : Colors.transparent),
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            /// Appbar Icons
            TAppBar(
                showBackArrow: true,
                actions: [TFavouriteIcon(destinationId: destination.id)]),
          ],
        ),
      ),
    );
  }
}
