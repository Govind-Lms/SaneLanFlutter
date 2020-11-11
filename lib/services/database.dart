import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  Future<void> addPlantData(Map plantData, String plantId) async {
    await Firestore.instance
        .collection("Plant")
        .document(plantId)
        .setData(plantData)
        .catchError((e) {
      print(e);
    });
  }
  Future<void> addHealthData(Map healthData, String healthId) async {
    await Firestore.instance
        .collection("Health")
        .document(healthId)
        .setData(healthData)
        .catchError((e) {
      print(e);
    });
  }
  Future<void> addHusbandryData(Map husbandryData, String husbandryId) async {
    await Firestore.instance
        .collection("Husbandry")
        .document(husbandryId)
        .setData(husbandryData)
        .catchError((e) {
      print(e);
    });
  }
  Future<void> addFertiData(Map fertiData, String fertiId) async {
    await Firestore.instance
        .collection("Fertilizer")
        .document(fertiId)
        .setData(fertiData)
        .catchError((e) {
      print(e);
    });
  }



  getPlantData() async {
    return await Firestore.instance.collection("Plant").snapshots();
  }
  getHealthData() async {
    return await Firestore.instance.collection("Health").snapshots();
  }
  getFertiData() async {
    return await Firestore.instance.collection("Fertilizer").snapshots();
  }
  getHusbandryData() async {
    return await Firestore.instance.collection("Husbandry").snapshots();
  }
  getPriceList() async {
    return await Firestore.instance.collection("PriceList").snapshots();
  }

}
