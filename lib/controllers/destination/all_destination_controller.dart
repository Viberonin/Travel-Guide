import 'package:cloud_firestore/cloud_firestore.dart';
import '../../repositories/destination/destination_repo.dart';
import 'package:get/get.dart';

import '../../utils/loaders.dart';
import '../../models/destination_model.dart';
import 'package:logger/logger.dart';

class AllDestinationsController extends GetxController {
  static AllDestinationsController get instance => Get.find();

  final repository = DestinationRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<DestinationModel> destinations = <DestinationModel>[].obs;
  final logger = Logger();

  Future<List<DestinationModel>> fetchProductsByQuery(Query? query) async {
    try {
      if (query == null) return [];
      return await repository.fetchDestinationsByQuery(query);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void assignProducts(List<DestinationModel> products) {
    // Assign products to the 'products' list
    this.destinations.assignAll(products);
    // sortProducts('Name');
  }

  // void sortProducts(String sortOption) {
  //   selectedSortOption.value = sortOption;

  //   switch (sortOption) {
  //     case 'Name':
  //       destinations.sort((a, b) => a.title.compareTo(b.title));
  //       break;
  //     case 'Higher Price':
  //       destinations.sort((a, b) => b.price.compareTo(a.price));
  //       break;
  //     case 'Lower Price':
  //       destinations.sort((a, b) => a.price.compareTo(b.price));
  //       break;
  //     case 'Newest':
  //       destinations.sort((a, b) => a.date!.compareTo(b.date!));
  //       break;
  //     case 'Sale':
  //       destinations.sort((a, b) {
  //         if (b.salePrice > 0) {
  //           return b.salePrice.compareTo(a.salePrice);
  //         } else if (a.salePrice > 0) {
  //           return -1;
  //         } else {
  //           return 1;
  //         }
  //       });
  //       break;
  //     default:
  //       // Default sorting option: Name
  //       destinations.sort((a, b) => a.title.compareTo(b.title));
  //   }
  // }
}
