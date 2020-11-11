class Health{
  final String image_url;
  final String name;
  final String healthId;
  final String cure;
  final String symtom;

  Health({this.image_url, this.name, this.healthId, this.cure, this.symtom});


  factory Health.fromDocument(doc){
    return Health(
      image_url: doc['image_url'],
      name: doc['name'],
      healthId: doc['healthId'],
      cure: doc['cure'],
      symtom: doc['symtom'],
    );
  }
}
