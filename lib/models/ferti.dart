class Fertilizer{
  final String image_url;
  final String amount;
  final String fertiId;
  final String effect;
  final String step;
  final String name;
  final String price;
  final String usabelPlants;

  Fertilizer({this.image_url, this.amount, this.fertiId, this.effect, this.step, this.name, this.price, this.usabelPlants});



factory Fertilizer.fromDocument(doc){
    return Fertilizer(
      image_url: doc['image_url'],
      name: doc['name'],
      fertiId: doc['fertiId'],
      amount: doc['amount'],
      step: doc['step'],
      effect: doc['effect'],
      price: doc['price'],
      usabelPlants: doc['usablePlants']
    );
  }
}
