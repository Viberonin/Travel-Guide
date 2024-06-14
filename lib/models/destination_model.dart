import 'package:cloud_firestore/cloud_firestore.dart';

import 'city_model.dart';
// import 'product_attribute_model.dart';
import 'destination_variation_model.dart';

class DestinationModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  CityModel? city;
  String? categoryId;
  String destinationType;
  String? description;
  List<String>? images;
  // List<destinationAttributeModel>? destinationAttributes;
  List<DestinationVariationModel>? destinationVariations;

  DestinationModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.destinationType,
    this.sku,
    this.city,
    this.date,
    this.images,
    this.salePrice = 0.0,
    this.isFeatured,
    this.categoryId,
    this.description,
    // this.destinationAttributes,
    this.destinationVariations,
  });

  /// Create Empty func for clean code
  static DestinationModel empty() => DestinationModel(id: '', title: '', stock: 0, price: 0, thumbnail: '', destinationType: '');

  /// Json Format
  toJson() {
    return {
      'SKU': sku,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Images': images ?? [],
      'Thumbnail': thumbnail,
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'City': city!.toJson(),
      'Description': description,
      'DestinationType': destinationType,
      // 'ProductAttributes': productAttributes != null ? productAttributes!.map((e) => e.toJson()).toList() : [],
      'DestinationVariations': destinationVariations != null ? destinationVariations!.map((e) => e.toJson()).toList() : [],
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory DestinationModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return DestinationModel(
      id: document.id,
      title: data['Title'],
      price: double.parse((data['Price'] ?? 0.0).toString()),
      sku: data['SKU'],
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      destinationType: data['DestinationType'] ?? '',
      city: CityModel.fromJson(data['City']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      // productAttributes: (data['ProductAttributes'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList(),
      destinationVariations: (data['DestinationVariations'] as List<dynamic>).map((e) => DestinationVariationModel.fromJson(e)).toList(),
    );
  }

  // Map Json-oriented document snapshot from Firebase to Model
  factory DestinationModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return DestinationModel(
      id: document.id,
      title: data['Title'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      sku: data['SKU'] ?? '',
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      destinationType: data['DestinationType'] ?? '',
      city: CityModel.fromJson(data['City']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      // productAttributes: (data['ProductAttributes'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList(),
      destinationVariations: (data['DestinationVariations'] as List<dynamic>).map((e) => DestinationVariationModel.fromJson(e)).toList(),
    );
  }
}
