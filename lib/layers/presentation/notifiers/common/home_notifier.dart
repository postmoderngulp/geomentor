// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

import 'package:geolog/layers/data/source/supabase_source.dart';
import 'package:geolog/layers/domain/entities/favorite.dart';
import 'package:geolog/layers/domain/entities/plant.dart';

class HomeNotifier extends ChangeNotifier {
  List<Plant> plants = [];
  List<Favorite> favorites = [];
  bool isLoading = false;

  HomeNotifier() {
    _setup();
  }

  void _setup() async {
    setLoad();
    SupabaseSource source = SupabaseSource();
    plants = await source.getPlants();
    favorites = await source.getMyFavorites();
    setLoad();
  }

  void addFavorite(Plant stone) async {
    SupabaseSource source = SupabaseSource();
    await source.addFavorite(stone);
    plants = await source.getPlants();
    favorites = await source.getMyFavorites();
    notifyListeners();
  }

  void setLoad() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void removeFavorite(Plant stone) async {
    SupabaseSource source = SupabaseSource();
    await source.removeFavorite(stone);
    plants = await source.getPlants();
    favorites = await source.getMyFavorites();
    notifyListeners();
  }
}
