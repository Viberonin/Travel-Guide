import 'dart:io';
// import 'package:cwt_ecommerce_app/data/repositories/brands/brand_repository.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/destination_model.dart';
import '../../constants/enums.dart';
import '../../utils/firebase_exceptions.dart';
import '../../utils/platform_exceptions.dart';
import '../../services/firebase_storage_service.dart';
import 'package:path/path.dart' as path;

/// Repository for managing destination-related data and operations.
class DestinationRepository extends GetxController {
  static DestinationRepository get instance => Get.find();

  /// Firestore instance for database interactions.
  final _db = FirebaseFirestore.instance;

  /* ---------------------------- FUNCTIONS ---------------------------------*/

  /// Get limited featured destinations.
  // Future<List<destinationModel>> getFeaturedDestinations() async {
  //   try {
  //     final snapshot = await _db.collection('destinations').where('IsFeatured', isEqualTo: true).limit(4).get();
  //     return snapshot.docs.map((querySnapshot) => destinationModel.fromSnapshot(querySnapshot)).toList();
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }

  /// Get all featured destinations using Stream.
  // Future<List<destinationModel>> getAllFeatureddestinations() async {
  //   final snapshot = await _db.collection('destinations').where('IsFeatured', isEqualTo: true).get();
  //   return snapshot.docs.map((querySnapshot) => destinationModel.fromSnapshot(querySnapshot)).toList();
  // }

  /// Get Products based on the Brand
  Future<List<DestinationModel>> fetchDestinationsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<DestinationModel> destionationList = querySnapshot.docs
          .map((doc) => DestinationModel.fromQuerySnapshot(doc))
          .toList();
      return destionationList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get favorite products based on a list of product IDs.
  Future<List<DestinationModel>> getFavouriteDestinations(
      List<String> destinationIds) async {
    try {
      // final snapshot = await _db.collection('destinations').where(FieldPath.documentId, whereIn: destinationIds).get();
      // return snapshot.docs.map((querySnapshot) => DestinationModel.fromSnapshot(querySnapshot)).toList();
      if (destinationIds.isNotEmpty) {
        final snapshot = await _db
            .collection('destinations')
            .where(FieldPath.documentId, whereIn: destinationIds)
            .get();
        return snapshot.docs
            .map(
                (querySnapshot) => DestinationModel.fromSnapshot(querySnapshot))
            .toList();
      } else {
        return []; // Return an empty list if destinationIds is empty
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Fetches Destinations for a specific category.
  /// If the limit is -1, retrieves all Destinations for the category; otherwise, limits the result based on the provided limit.
  /// Returns a list of [DestinationModel] objects.
  Future<List<DestinationModel>> getDestinationsForCategory(
      {required String categoryId, int limit = 4}) async {
    try {
      // Query to get all documents where productId matches the provided categoryId & Fetch limited or unlimited based on limit
      QuerySnapshot destinationCategoryQuery = limit == -1
          ? await _db
              .collection('DestinationCategory')
              .where('categoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('DestinationCategory')
              .where('categoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      // Extract productIds from the documents
      List<String> destinationIds = destinationCategoryQuery.docs
          .map((doc) => doc['destinationId'] as String)
          .toList();

      // Query to get all documents where the brandId is in the list of brandIds, FieldPath.documentId to query documents in Collection
      final destinationsQuery = await _db
          .collection('destinations')
          .where(FieldPath.documentId, whereIn: destinationIds)
          .get();

      // Extract brand names or other relevant data from the documents
      List<DestinationModel> destinations = destinationsQuery.docs
          .map((doc) => DestinationModel.fromSnapshot(doc))
          .toList();

      return destinations;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Fetches products for a specific brand.
  /// If the limit is -1, retrieves all products for the brand; otherwise, limits the result based on the provided limit.
  /// Returns a list of [ProductModel] objects.
  Future<List<DestinationModel>> getDestinationsForBrand(
      String brandId, int limit) async {
    try {
      // Query to get all documents where DestinationId matches the provided categoryId & Fetch limited or unlimited based on limit
      QuerySnapshot<Map<String, dynamic>> querySnapshot = limit == -1
          ? await _db
              .collection('destinations')
              .where('Brand.Id', isEqualTo: brandId)
              .get()
          : await _db
              .collection('destinations')
              .where('Brand.Id', isEqualTo: brandId)
              .limit(limit)
              .get();

      // Map Products
      final destinations = querySnapshot.docs
          .map((doc) => DestinationModel.fromSnapshot(doc))
          .toList();

      return destinations;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<DestinationModel>> searchDestinations(String query) async {
    try {
      // Reference to the 'Destinations' collection in Firestore
      CollectionReference destinationsCollection =
          FirebaseFirestore.instance.collection('destinations');

      // Start with a basic query to search for products where the name contains the query
      Query queryRef = destinationsCollection;

      // Apply the search filter
      if (query.isNotEmpty) {
        queryRef = queryRef.where('Name', isEqualTo: query);
      }

      // Apply filters
      // if (categoryId != null) {
      //   queryRef = queryRef.where('CategoryId', isEqualTo: categoryId);
      // }

      // if (brandId != null) {
      //   queryRef = queryRef.where('BrandId', isEqualTo: brandId);
      // }

      // if (minPrice != null) {
      //   queryRef = queryRef.where('Price', isGreaterThanOrEqualTo: minPrice);
      // }

      // if (maxPrice != null) {
      //   queryRef = queryRef.where('Price', isLessThanOrEqualTo: maxPrice);
      // }

      // Execute the query
      QuerySnapshot querySnapshot = await queryRef.get();

      // Map the documents to ProductModel objects
      final destinations = querySnapshot.docs
          .map((doc) => DestinationModel.fromQuerySnapshot(doc))
          .toList();

      return destinations;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload dummy data to the Cloud Firebase.
  Future<void> uploadDummyData(List<DestinationModel> destinations) async {
    try {
      // Upload all the products along with their images
      final storage = Get.put(TFirebaseStorageService());

      // Get Product Brand
      // final brandRepository = Get.put(BrandRepository());

      // Loop through each product
      // for (var destination in destinations) {
      //   // Extract the selected brand
      //   final brand = await brandRepository.getSingleBrand(destination.brand!.id);

      //   // Upload Brand image if Brand Not found
      //   if (brand == null || brand.image.isEmpty) {
      //     throw 'No Brands found. Please upload brands first.';
      //   } else {
      //     destination.brand!.image = brand.image;
      //   }

      //   // Get image data link from local assets
      //   final thumbnail = await storage.getImageDataFromAssets(destination.thumbnail);

      //   // Upload image and get its URL
      //   final url = await storage.uploadImageData('Destinations', thumbnail, path.basename(destination.thumbnail));

      //   // Assign URL to product.thumbnail attribute
      //   destination.thumbnail = url;

      //   // destination list of images
      //   if (destination.images != null && destination.images!.isNotEmpty) {
      //     List<String> imagesUrl = [];
      //     for (var image in destination.images!) {
      //       // Get image data link from local assets
      //       final assetImage = await storage.getImageDataFromAssets(image);

      //       // Upload image and get its URL
      //       final url = await storage.uploadImageData('Destinations', assetImage, path.basename(image));

      //       // Assign URL to product.thumbnail attribute
      //       imagesUrl.add(url);
      //     }
      //     destination.images!.clear();
      //     destination.images!.addAll(imagesUrl);
      //   }

      //   // Upload Variation Images
      //   if (destination.destinationType == DestinationType.variable.toString()) {
      //     for (var variation in destination.destinationVariations!) {
      //       // Get image data link from local assets
      //       final assetImage = await storage.getImageDataFromAssets(variation.image);

      //       // Upload image and get its URL
      //       final url = await storage.uploadImageData('Destinations', assetImage, path.basename(variation.image));

      //       // Assign URL to variation.image attribute
      //       variation.image = url;
      //     }
      //   }

      //   // Store Destination in Firestore
      //   await _db.collection("Destinations").doc(destination.id).set(destination.toJson());
      // }
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
