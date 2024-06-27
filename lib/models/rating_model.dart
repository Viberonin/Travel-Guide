import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  // final String userId;
  final String paketId;
  final double rating;
  final String review;

  RatingModel({
    // required this.userId,
    required this.paketId,
    required this.rating,
    required this.review,
  });

  Map<String, dynamic> toJson() {
    return {
      // 'userId': userId,
      'paketId': paketId,
      'rating': rating,
      'review': review,
    };
  }

  factory RatingModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return RatingModel(
      // userId: data['userId'],
      paketId: data['paketId'],
      rating: data['rating'],
      review: data['review'],
    );
  }
}
