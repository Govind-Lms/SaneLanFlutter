class PriceList{
  final String count;
  final String name;
  final String price;

  PriceList({this.count, this.name, this.price});

  factory PriceList.fromDocument(doc){
    return PriceList(
      price: doc['price'],
      name: doc['name'],
      count: doc['count'],
    );
  }
}
