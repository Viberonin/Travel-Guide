import '../../repositories/destination/destination_repo.dart';
import 'package:get/get.dart';

import '../../repositories/category/categories_repo.dart';
import '../../utils/loaders.dart';
import '../../models/categories_model.dart';
import '../../models/destination_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  RxBool isLoading = true.obs;
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  final _categoryRepository = Get.put(CategoryRepository());

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// -- Load category data
  Future<void> fetchCategories() async {
    try {
      // Show loader while loading categories
      isLoading.value = true;

      // Fetch categories from data source (Firestore, API, etc.)
      final fetchedCategories = await _categoryRepository.getAllCategories();

      // Update the categories list
      allCategories.assignAll(fetchedCategories);

      // Filter featured categories
      featuredCategories.assignAll(allCategories.where((category) => (category.isFeatured) && category.parentId.isEmpty).take(8).toList());

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  /// -- Load selected category data
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    // Fetch all categories where ParentId = categoryId;
    try {
      final subCategories = await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Get Category or Sub-Category Products.
  /// If you want to fetch all the products in this category SET [limit] to -1
  Future<List<DestinationModel>> getCategoryDestinations({required String categoryId, int limit = 4}) async {
    // Fetch limited (4) products against each subCategory;
    final destinations = await DestinationRepository.instance.getDestinationsForCategory(categoryId: categoryId, limit: limit);
    return destinations;
  }
}
