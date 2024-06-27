import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelguide/utils/firebase_exceptions.dart';
import 'package:travelguide/utils/platform_exceptions.dart';

import '../../repositories/destination/destination_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../models/destination_model.dart';

class TSearchController extends GetxController {
  static TSearchController get instance => Get.find();

  // RxList<DestinationModel> searchResults = <DestinationModel>[].obs;
  var searchResults = <DestinationModel>[].obs;
  // RxBool isLoading = false.obs;
  var isLoading = false.obs;
  RxString lastSearchQuery = ''.obs;
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = double.infinity.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedCategoryId = ''.obs;
  List<String> sortingOptions = [
    'Name',
    'Lowest Price',
    'Highest Price',
    'Popular',
    'Newest',
    'Suitable'
  ];
  // RxString selectedSortingOption = 'Name'.obs;

  // void search() {
  //   searchDestinations(
  //     searchQuery.value,
  //   );
  // }

  // Future<List<DestinationModel>> searchDestinations(String query) async {
  //   try {
  //     // Reference to the 'Destinations' collection in Firestore
  //     CollectionReference destinationsCollection =
  //         FirebaseFirestore.instance.collection('destinations');

  //     // Start with a basic query to search for destinations where the name contains the query
  //     Query queryRef = destinationsCollection
  //         .where('Name', isGreaterThanOrEqualTo: query)
  //         .where('Name', isLessThanOrEqualTo: query + '\uf8ff');

  //     // Execute the query
  //     QuerySnapshot querySnapshot = await queryRef.get();

  //     // Map the documents to DestinationModel objects
  //     final destinations = querySnapshot.docs
  //         .map((doc) => DestinationModel.fromQuerySnapshot(doc))
  //         .toList();

  //     return destinations;
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on TPlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }
  void searchDestinations(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true;

    try {
      final result = await FirebaseFirestore.instance
          .collection('destinations')
          .get();

      if (result.docs.isEmpty) {
        print('No documents found');
      } else {
        print('Documents found: ${result.docs.length}');
      }

      final destinations = result.docs.map((doc) {
        return DestinationModel.fromSnapshot(
            doc as DocumentSnapshot<Map<String, dynamic>>);
      }).toList();

      final filteredDestinations = destinations.where((destination) {
        return destination.title.toLowerCase().contains(query.toLowerCase());
      }).toList();

      if (filteredDestinations.isEmpty) {
        print('No matching destinations found');
      } else {
        print('Matching destinations found: ${filteredDestinations.length}');
      }

      searchResults.assignAll(filteredDestinations);
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
