import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sane_lan_flutter/services/database.dart';
class PriceList extends StatefulWidget {
  @override
  _PriceListState createState() => _PriceListState();
}

class _PriceListState extends State<PriceList> {
  Stream priceListData;
  DatabaseService databaseService = DatabaseService();

  void initState() {
    databaseService.getPriceList().then((val){
      setState(() {
        priceListData= val;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return priceList();
  }
  Widget priceList() {
    return Container(
      child: Column(
        children: [
          StreamBuilder(
            stream: priceListData,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container(
                child: Center(child: CircularProgressIndicator()),
              ) :
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return PriceTile(
                      name: snapshot.data.documents[index].data['name'],
                      count: snapshot.data.documents[index].data['count'],
                      price: snapshot.data.documents[index].data['price'],

                    );
                  }
              );
            },
          )
        ],
      ),
    );
  }
}
class PriceTile extends StatelessWidget {
  final String name, count, price;

  const PriceTile({this.name, this.count, this.price});


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
        Text(
          count,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
