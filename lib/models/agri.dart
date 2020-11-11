class Agriculture{
  final String image_url;
  final String bio;
  final String plantId;
  final String name;
  final String step;

  Agriculture({this.bio, this.plantId, this.step, this.image_url, this.name});


  factory Agriculture.fromDocument(doc){
    return Agriculture(
      image_url: doc['image_url'],
      name: doc['name'],
      plantId: doc['plantId'],
      bio: doc['bio'],
      step: doc['step'],
    );
  }
}
