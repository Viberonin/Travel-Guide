import 'dart:convert';

import 'package:get/get.dart';
import '../../repositories/destination/destination_repo.dart';
import '../../utils/local_storage.dart';
import '../../utils/loaders.dart';
import '../../models/destination_model.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  /// Variables
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize by fetching the list of already added favorites
    initFavorites();
  }

  // Method to initialize favorites by reading from storage
  Future<void> initFavorites() async {
    final json = TLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  /// Method to check if a product is selected (favorite)
  bool isFavourite(String destinationId) {
    return favorites[destinationId] ?? false;
  }

  /// Add Product to Favourites
  void toggleFavoriteDestination(String destinationId) {
    // If favorites do not have this Destination, Add. Else Toggle
    if (!favorites.containsKey(destinationId)) {
      favorites[destinationId] = true;
      saveFavoritesToStorage();
      TLoaders.customToast(message: 'Destination has been added to the Wishlist.');
    } else {
      TLocalStorage.instance().removeData(destinationId);
      favorites.remove(destinationId);
      saveFavoritesToStorage();
      favorites.refresh();
      TLoaders.customToast(message: 'Destination has been removed from the Wishlist.');
    }
  }

  // Save the updated favorites to storage
  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    TLocalStorage.instance().writeData('favorites', encodedFavorites);
  }

  /// Method to get the list of favorite Destinations
  Future<List<DestinationModel>> favoriteDestinations() {
    return DestinationRepository.instance.getFavouriteDestinations(favorites.keys.toList());
  }
}
