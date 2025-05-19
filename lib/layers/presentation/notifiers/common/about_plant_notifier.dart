// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:geolog/layers/data/source/supabase_source.dart';
import 'package:geolog/layers/domain/entities/genus.dart';
import 'package:geolog/layers/domain/entities/plant.dart';

class AboutPlantNotifier extends ChangeNotifier {
  int favoritePlant;
  Plant? plant;
  SupabaseSource source = SupabaseSource();
  String genus = "";
  String family = "";
  String habitat = "";
  String life_cycle = "";
  String plant_type = "";

  AboutPlantNotifier({
    required this.favoritePlant,
  }) {
    _setup();
  }

  void _setup() async {
    SupabaseSource source = SupabaseSource();
    plant = await source.getPlant(favoritePlant);
    if (plant!.genus != null) {
      Ccategory gen = await source.getGenus(plant!.genus);
      genus = gen.name;
    }
    if (plant!.family != null) {
      Ccategory fam = await source.getFamily(plant!.family);
      family = fam.name;
    }
    Ccategory hab = await source.getHabitat(plant!.habitat);
    habitat = hab.name;
    Ccategory life_c = await source.getLifeCycle(plant!.life_cycle);
    life_cycle = life_c.name;
    Ccategory plant_t = await source.getPlantType(plant!.plant_type);
    plant_type = plant_t.name;
    notifyListeners();
  }
}
