import 'package:cloud_firestore/cloud_firestore.dart';

class PaketWisataModel {
  final String id;
  final String title;
  final String imageUrl;
  final String harga;
  final List<String> rundown;

  PaketWisataModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.harga,
    required this.rundown,
  });

  factory PaketWisataModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PaketWisataModel(
      id: document.id,
      title: data['title'],
      imageUrl: data['imageUrl'],
      harga: data['harga'],
      rundown: List<String>.from(data['rundown']),
    );
  }
}
