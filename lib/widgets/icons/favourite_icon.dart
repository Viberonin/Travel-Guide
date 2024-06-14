import '../../controllers/favourite/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants/colors.dart';
import '../../widgets/icons/circular_icon.dart';

class TFavouriteIcon extends StatelessWidget {
  /// A custom Icon widget which handles its own logic to add or remove products from the Wishlist.
  /// You just have to call this widget on your design and pass a product id.
  ///
  /// It will auto do the logic defined in this widget.
  const TFavouriteIcon({
    super.key,
    required this.destinationId,
  });

  final String destinationId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(
      () => TCircularIcon(
        icon: controller.isFavourite(destinationId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavourite(destinationId) ? TColors.error : null,
        onPressed: () => controller.toggleFavoriteDestination(destinationId),
      ),
    );
  }
}
