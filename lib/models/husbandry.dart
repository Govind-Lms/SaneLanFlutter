class PriceList{
  final String image_url;
  final String name;
  final String hustbandryId;
  final String about;

  PriceList({this.image_url, this.name, this.hustbandryId, this.about});




  factory PriceList.fromDocument(doc){
    return PriceList(
      image_url: doc['image_url'],
      name: doc['name'],
      hustbandryId: doc['husbandryId'],
      about: doc['about'],
    );
  }
}
