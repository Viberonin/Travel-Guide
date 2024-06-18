// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:travelguide/models/brand_model.dart';
// import 'package:travelguide/models/categories_model.dart';

// import 'city_model.dart';
// // import 'product_attribute_model.dart';
// import 'destination_variation_model.dart';
// import 'package:logger/logger.dart';

// class DestinationModel {
//   String id;
//   // int stock;
//   // String? sku;
//   double price;
//   String title;
//   // DateTime? date;
//   // double salePrice;
//   String thumbnail;
//   // bool? isFeatured;
//   CityModel? city;
//   BrandModel? category;
//   String? categoryId;
//   // String destinationType;
//   String? description;
//   List<String>? images;
//   List<GeoPoint>? koordinat;
//   // List<destinationAttributeModel>? destinationAttributes;
//   // List<DestinationVariationModel>? destinationVariations;

//   DestinationModel({
//     required this.id,
//     required this.title,
//     // required this.stock,
//     required this.price,
//     required this.thumbnail,
//     // required this.destinationType,
//     // this.sku,
//     this.city,
//     this.category,
//     // this.date,
//     this.images,
//     // this.salePrice = 0.0,
//     // this.isFeatured,
//     this.categoryId,
//     this.description,
//     this.koordinat,
//     // this.destinationAttributes,
//     // this.destinationVariations,
//   });

//   /// Create Empty func for clean code
//   static DestinationModel empty() => DestinationModel(
//     id: '',
//     title: '',
//     // stock: 0,
//     price: 0,
//     thumbnail: '',
//     // destinationType: ''
//   );

//   /// Json Format
//   toJson() {
//     return {
//       // 'SKU': sku,
//       'Name': title,
//       // 'Stock': stock,
//       'Price': price,
//       'Image': images ?? [],
//       'Thumbnail': thumbnail,
//       // 'SalePrice': salePrice,
//       // 'IsFeatured': isFeatured,
//       'CategoryId': categoryId,
//       'City': city!.toJson(),
//       'Category': category!.toJson(),
//       'Description': description,
//       // 'DestinationType': destinationType,
//       // 'ProductAttributes': productAttributes != null ? productAttributes!.map((e) => e.toJson()).toList() : [],
//       // 'DestinationVariations': destinationVariations != null
//       //     ? destinationVariations!.map((e) => e.toJson()).toList()
//       //     : [],
//     };
//   }

//   static void logMappedData(DocumentSnapshot<Map<String, dynamic>> document, Map<String, dynamic> data) {
//     final logger = Logger(); // Create a logger instance within the method

//     logger.d('Mapping data for document ID: ${document.id}');
//     logger.d('Data: $data');
//   }

//   /// Map Json oriented document snapshot from Firebase to Model
//   factory DestinationModel.fromSnapshot(
//       DocumentSnapshot<Map<String, dynamic>> document) {
//     final data = document.data()!;
//     return DestinationModel(
//       id: document.id,
//       title: data['Name'],
//       price: double.parse((data['Price'] ?? 0.0).toString()),
//       // sku: data['SKU'],
//       // stock: data['Stock'] ?? 0,
//       // isFeatured: data['IsFeatured'] ?? false,
//       // salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
//       thumbnail: data['Thumbnail'] ?? '',
//       categoryId: data['CategoryId'] ?? '',
//       description: data['Description'] ?? '',
//       // destinationType: data['DestinationType'] ?? '',
//       city: CityModel.fromJson(data['Name']),
//       category: BrandModel.fromJson(data['Name']),
//       images: data['Image'] != null ? List<String>.from(data['Image']) : [],
//       // productAttributes: (data['ProductAttributes'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList(),
//       // destinationVariations: (data['DestinationVariations'] as List<dynamic>)
//       //     .map((e) => DestinationVariationModel.fromJson(e))
//       //     .toList(),
//     );
//   }

//   // Map Json-oriented document snapshot from Firebase to Model
//   factory DestinationModel.fromQuerySnapshot(
//       QueryDocumentSnapshot<Object?> document) {
//     final data = document.data() as Map<String, dynamic>;
//     return DestinationModel(
//       id: document.id,
//       title: data['Title'] ?? '',
//       price: double.parse((data['Price'] ?? 0.0).toString()),
//       // sku: data['SKU'] ?? '',
//       // stock: data['Stock'] ?? 0,
//       // isFeatured: data['IsFeatured'] ?? false,
//       // salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
//       thumbnail: data['Thumbnail'] ?? '',
//       categoryId: data['CategoryId'] ?? '',
//       description: data['Description'] ?? '',
//       // destinationType: data['DestinationType'] ?? '',
//       city: CityModel.fromJson(data['Name']),
//       category: BrandModel.fromJson(data['Name']),
//       images: data['Image'] != null ? List<String>.from(data['Image']) : [],
//       // productAttributes: (data['ProductAttributes'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList(),
//       // destinationVariations: (data['DestinationVariations'] as List<dynamic>)
//       //     .map((e) => DestinationVariationModel.fromJson(e))
//       //     .toList(),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelguide/models/brand_model.dart';
import 'package:travelguide/models/categories_model.dart';

import 'city_model.dart';
import 'destination_variation_model.dart';
import 'package:logger/logger.dart';

class DestinationModel {
  String id;
  double price;
  double rating;
  String title;
  String thumbnail;
  CityModel? city;
  BrandModel? category;
  String? categoryId;
  String? description;
  List<String>? images;

  DestinationModel({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.rating,
    this.city,
    this.category,
    this.categoryId,
    this.description,
    this.images,
  });

  /// Create Empty func for clean code
  static DestinationModel empty() => DestinationModel(
        id: '',
        title: '',
        price: 0,
        thumbnail: '',
        rating: 0,
      );

  /// Json Format
  toJson() {
    return {
      'Name': title,
      'Price': price,
      'Image': images ?? [],
      'Thumbnail': thumbnail,
      'CategoryId': categoryId,
      'City': city!.toJson(),
      'Category': category!.toJson(),
      'Description': description,
    };
  }

  /// Map Json-oriented document snapshot from Firebase to Model
  factory DestinationModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return DestinationModel(
      id: document.id,
      title: data['Name'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      rating: double.parse((data['Rating'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      city: CityModel.fromJson(data['City']),
      category: BrandModel.fromJson(data['Category']),
      images: data['Image'] != null ? List<String>.from(data['Image']) : [],
    );
  }

  factory DestinationModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return DestinationModel(
      id: document.id,
      title: data['Name'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      rating: double.parse((data['Rating'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      city: CityModel.fromJson(data['City']),
      category: BrandModel.fromJson(data['Category']),
      images: data['Image'] != null ? List<String>.from(data['Image']) : [],
    );
  }
}
