import 'package:cloud_firestore/cloud_firestore.dart';

class CityModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  CityModel({required this.id, required this.image, required this.name, this.isFeatured, this.productsCount});

  /// Empty Helper Function
  static CityModel empty() => CityModel(id: '', image: '', name: '');

  /// Convert model to Json structure so that you can store data in Firebase
  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
    };
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory CityModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return CityModel.empty();
    return CityModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      productsCount: int.parse((data['ProductsCount'] ?? 0).toString()),
    );
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory CityModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // Map JSON Record to the Model
      return CityModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        productsCount: data['ProductsCount'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
      );
    } else {
      return CityModel.empty();
    }
  }
}
