import '../../constants/enums.dart';
import 'package:get/get.dart';
import '../../repositories/destination/destination_repo.dart';
import '../../utils/loaders.dart';
import '../../models/destination_model.dart';

class DestinationController extends GetxController {
  static DestinationController get instance => Get.find();

  final isLoading = false.obs;
  final destinationRepository = Get.put(DestinationRepository());
  RxList<DestinationModel> featuredDestinations = <DestinationModel>[].obs;

  /// -- Initialize Products from your backend
  @override
  void onInit() {
    // fetchFeaturedDestinations();
    super.onInit();
  }

  /// Fetch Products using Stream so, any change can immediately take effect.
  // void fetchFeaturedDestinations() async {
  //   try {
  //     // Show loader while loading Products
  //     isLoading.value = true;

  //     // Fetch Products
  //     final destinations = await destinationRepository.getFeaturedDestinations();

  //     // Assign Products
  //     featuredDestinations.assignAll(destinations);
  //   } catch (e) {
  //     TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  /// Get the product price or price range for variations.
  // String getDestinationPrice(DestinationModel destination) {
  //   double smallestPrice = double.infinity;
  //   double largestPrice = 0.0;

  //   // If no variations exist, return the simple price or sale price
  //   if (destination.destinationType == DestinationType.single.toString()) {
  //     return (destination.salePrice > 0.0 ? destination.salePrice : destination.price).toString();
  //   } else {
  //     // Calculate the smallest and largest prices among variations
  //     for (var variation in destination.destinationVariations!) {
  //       // Determine the price to consider (sale price if available, otherwise regular price)
  //       double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

  //       // Update smallest and largest prices
  //       if (priceToConsider < smallestPrice) {
  //         smallestPrice = priceToConsider;
  //       }

  //       if (priceToConsider > largestPrice) {
  //         largestPrice = priceToConsider;
  //       }
  //     }

  //     // If smallest and largest prices are the same, return a single price
  //     if (smallestPrice.isEqual(largestPrice)) {
  //       return largestPrice.toString();
  //     } else {
  //       // Otherwise, return a price range
  //       return '$smallestPrice - \$$largestPrice';
  //     }
  //   }
  // }

  /// -- Calculate Discount Percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  /// -- Check Product Stock Status
  // String getProductStockStatus(ProductModel product) {
  //   if (product.productType == ProductType.single.toString()) {
  //     return product.stock > 0 ? 'In Stock' : 'Out of Stock';
  //   } else {
  //     final stock = product.productVariations?.fold(0, (previousValue, element) => previousValue + element.stock);
  //     return stock != null && stock > 0 ? 'In Stock' : 'Out of Stock';
  //   }
  // }
}
