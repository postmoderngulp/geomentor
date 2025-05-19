// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:geolog/layers/domain/entities/favorite.dart';
import 'package:geolog/layers/domain/entities/genus.dart';
import 'package:geolog/layers/domain/entities/geo_deposit.dart';
import 'package:geolog/layers/domain/entities/locate.dart';
import 'package:geolog/layers/domain/entities/profile.dart';
import 'package:geolog/layers/domain/entities/plant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSource {
  final supabase = Supabase.instance.client;

  Future<String> signUp(String email, String password) async {
    final response =
        await supabase.auth.signUp(password: password, email: email);
    return response.user?.id as String;
  }

  Future<void> registerProfile(
    String userId,
    String nickname,
  ) async {
    await supabase.from('profile').insert({
      'user_id': userId,
      'fio': nickname,
    });
  }

  Future<void> loadAvatar(String avatar) async {
    await supabase.from('profile').update({'avatar': avatar}).eq(
        'user_id', supabase.auth.currentSession!.user.id);
  }

  Future<void> signIn(String email, String password) async {
    await supabase.auth.signInWithPassword(password: password, email: email);
  }

  Future<void> logOut() async {
    await supabase.auth.signOut();
  }

  Future<Profile> getMyProfile() async {
    final profilesMaps = await supabase
        .from('profile')
        .select()
        .eq('user_id', supabase.auth.currentSession!.user.id);
    return Profile.fromMap(profilesMaps.first);
  }

  Future<List<Plant>> getPlants() async {
    final plants = await supabase.from('plants').select();

    List<Plant> Plants = [];
    for (int i = 0; i < plants.length; i++) {
      Plants.add(Plant.fromMap(plants[i]));
    }

    debugPrint(Plants[0].toString());
    debugPrint(Plants[1].toString());
    debugPrint(Plants[2].toString());

    return Plants;
  }

  Future<Ccategory> getGenus(genusId) async {
    final genuses =
        await supabase.from('plant_genuses').select().eq('id', genusId);

    List<Ccategory> Genuses = [];
    for (int i = 0; i < genuses.length; i++) {
      Genuses.add(Ccategory.fromMap(genuses[i]));
    }
    return Genuses.first;
  }

  Future<Ccategory> getFamily( genusId) async {
    final family =
        await supabase.from('plant_families').select().eq('id', genusId);

    List<Ccategory> Family = [];
    for (int i = 0; i < family.length; i++) {
      Family.add(Ccategory.fromMap(family[i]));
    }
    return Family.first;
  }

  Future<Ccategory> getPlantType(plantTypeId) async {
    final plantType =
        await supabase.from('plant_types').select().eq('id', plantTypeId);

    List<Ccategory> PlantType = [];
    for (int i = 0; i < plantType.length; i++) {
      PlantType.add(Ccategory.fromMap(plantType[i]));
    }
    return PlantType.first;
  }

  Future<Ccategory> getLifeCycle(lifeCycleId) async {
    final lifeCycle =
        await supabase.from('life_cycle').select().eq('id', lifeCycleId);

    List<Ccategory> LifeCycle = [];
    for (int i = 0; i < lifeCycle.length; i++) {
      LifeCycle.add(Ccategory.fromMap(lifeCycle[i]));
    }
    return LifeCycle.first;
  }

  Future<Ccategory> getHabitat(habitatId) async {
    final habitat =
        await supabase.from('plant_habitats').select().eq('id', habitatId);

    List<Ccategory> Habitat = [];
    for (int i = 0; i < habitat.length; i++) {
      Habitat.add(Ccategory.fromMap(habitat[i]));
    }
    return Habitat.first;
  }

  Future<Plant> getPlant(int plant) async {
    final plants = await supabase.from('plants').select().eq('id', plant);

    return Plant.fromMap(plants.first);
  }

  Future<List<Locate>> getDeposits() async {
    final locates =
        await supabase.rpc('get_plant_location', params: {'plant': 16});

    List<Locate> list = [];
    for (int i = 0; i < locates.length; i++) {
      list.add(Locate.fromMap(locates[i]));
    }
    return list;
  }

  Future<Uint8List> downloadAsset(String bucketName, String path) async {
    Uint8List bytes = await supabase.storage.from(bucketName).download(path);
    return bytes;
  }

  Future<void> addFavorite(Plant plant) async {
    await supabase.from('favoritues').insert({
      'plant_id': plant.id,
      'created_at': plant.created_at,
      'user_id': supabase.auth.currentSession!.user.id,
    });
  }

  Future<void> addMyPLace(GeoDeposit geoDeposit) async {
    await supabase.from('myPlaces').insert({
      'id': geoDeposit.id,
      'name': geoDeposit.name,
      'description': geoDeposit.description,
      'image': geoDeposit.image,
      'icon_uri': geoDeposit.icon_uri,
      'latitude': geoDeposit.latitude,
      'longitude': geoDeposit.longitude,
      'user_id': supabase.auth.currentSession!.user.id,
    });
  }

  Future<void> removeMyPlaces(GeoDeposit geoDeposit) async {
    await supabase
        .from('myPlaces')
        .delete()
        .eq('user_id', supabase.auth.currentSession!.user.id)
        .eq('id', '${geoDeposit.id}');
  }

  Future<void> removeFavorite(Plant plant) async {
    await supabase
        .from('favoritues')
        .delete()
        .eq('user_id', supabase.auth.currentSession!.user.id)
        .eq('plant_id', '${plant.id}');
  }

  Future<List<Favorite>> getMyFavorites() async {
    final maps = await supabase
        .from('favoritues')
        .select()
        .eq('user_id', supabase.auth.currentSession!.user.id);
    List<Favorite> favorites = [];
    for (int i = 0; i < maps.length; i++) {
      favorites.add(Favorite.fromMap(maps[i]));
    }
    return favorites;
  }

  Future<List<GeoDeposit>> getMyPLaces() async {
    final maps = await supabase
        .from('myPlaces')
        .select()
        .eq('user_id', supabase.auth.currentSession!.user.id);
    List<GeoDeposit> myPlaces = [];
    for (int i = 0; i < maps.length; i++) {
      myPlaces.add(GeoDeposit.fromMap(maps[i]));
    }
    return myPlaces;
  }
}
