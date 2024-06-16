import 'package:travelguide/models/brand_model.dart';
import 'package:travelguide/repositories/category/brand_repo.dart';

import '../../repositories/destination/destination_repo.dart';
import 'package:get/get.dart';

import '../../repositories/category/categories_repo.dart';
import '../../utils/loaders.dart';
import '../../models/categories_model.dart';
import '../../models/destination_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  /// -- Load Brands
  Future<void> getFeaturedBrands() async {
    try {
      // Show loader while loading Brands
      isLoading.value = true;

      // Fetch Brands from your data source (Firestore, API, etc.)
      final fetchedBrands = await brandRepository.getAllBrands();

      // Update the brands list
      allBrands.assignAll(fetchedBrands);

      // Update the featured brands list
      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).take(4).toList());

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// -- Get Brands For Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    final brands = await brandRepository.getBrandsForCategory(categoryId);
    return brands;
  }

  /// Get Brand Specific Products from your data source
  Future<List<DestinationModel>> getBrandDestinations(String brandId, int limit) async {
    final destinations = await DestinationRepository.instance.getDestinationsForBrand(brandId, limit);
    return destinations;
  }
}