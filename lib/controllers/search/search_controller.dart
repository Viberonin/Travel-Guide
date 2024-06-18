import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelguide/utils/firebase_exceptions.dart';
import 'package:travelguide/utils/platform_exceptions.dart';

import '../../repositories/destination/destination_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../models/destination_model.dart';

class TSearchController extends GetxController {
  static TSearchController get instance => Get.find();

  RxList<DestinationModel> searchResults = <DestinationModel>[].obs;
  RxBool isLoading = false.obs;
  RxString lastSearchQuery = ''.obs;
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = double.infinity.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedCategoryId = ''.obs;
  List<String> sortingOptions = ['Name', 'Lowest Price', 'Highest Price', 'Popular', 'Newest', 'Suitable'];
  RxString selectedSortingOption = 'Name'.obs; // Default sorting option

  void search() {
    searchDestinations(
      searchQuery.value,
    );
  }


  // void searchDestinations(String query, {String? categoryId, String? brandId, double? minPrice, double? maxPrice}) async {
  //   lastSearchQuery.value = query;
  //   isLoading.value = true;

  //   try {
  //     final results = await DestinationRepository.instance
  //         .searchDestinations(query);

  //     // Apply sorting
  //     switch (selectedSortingOption.value) {
  //       case 'Name':
  //       // Sort by name
  //         results.sort((a, b) => a.title.compareTo(b.title));
  //         break;
  //       case 'Lowest Price':
  //       // Sort by price in ascending order
  //         results.sort((a, b) => a.price.compareTo(b.price));
  //         break;
  //       case 'Highest Price':
  //       // Sort by price in descending order
  //         results.sort((a, b) => b.price.compareTo(a.price));
  //         break;
  //       // Add other sorting cases as needed
  //     }

  //     // Update searchResults with sorted results
  //     searchResults.assignAll(results);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error fetching data: $e');
  //     }
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<List<DestinationModel>> searchDestinations(String query) async {
    try {
      // Reference to the 'Destinations' collection in Firestore
      CollectionReference destinationsCollection =
          FirebaseFirestore.instance.collection('destinations');

      // Start with a basic query to search for destinations where the name contains the query
      Query queryRef = destinationsCollection.where('Name', isGreaterThanOrEqualTo: query).where('Name', isLessThanOrEqualTo: query + '\uf8ff');

      // Execute the query
      QuerySnapshot querySnapshot = await queryRef.get();

      // Map the documents to DestinationModel objects
      final destinations = querySnapshot.docs
          .map((doc) => DestinationModel.fromQuerySnapshot(doc))
          .toList();

      return destinations;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

}
