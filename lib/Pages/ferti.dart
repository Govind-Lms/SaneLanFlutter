import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sane_lan_flutter/onClick/fertiCardOnClick.dart';
import 'package:sane_lan_flutter/services/database.dart';

class Fertilizer extends StatefulWidget {
  @override
  _FertilizerState createState() => _FertilizerState();
}

class _FertilizerState extends State<Fertilizer> {

  DatabaseService databaseService= new DatabaseService();
  Stream fertilizerStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff007084),
        title: Text('မြေဩဇာ',),
      ),
      body: fertiList(),
    );
  }
  void initState() {
    databaseService.getFertiData().then((val){
      setState(() {
        fertilizerStream= val;
      });
    });
    super.initState();
  }

  Widget fertiList() {
    return StreamBuilder(
      stream: fertilizerStream,
      builder: (context, snapshot) {
        return snapshot.data == null
            ? Container(
          child: Center(child: CircularProgressIndicator()),
        )
            :
        ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return FertilizerTile(
                image_url: snapshot.data.documents[index].data['image_url'],
                name: snapshot.data.documents[index].data['name'],
                fertiId  :  snapshot.data.documents[index].data['fertiId'],
                amount: snapshot.data.documents[index].data['amount'],
                effect  :  snapshot.data.documents[index].data['effect'],
                step  :  snapshot.data.documents[index].data['step'],
                usablePlants  :  snapshot.data.documents[index].data['usablePlants'],
                price  :  snapshot.data.documents[index].data['price'],
              );
            }
        );
      },
    );
  }

}

class FertilizerTile extends StatelessWidget{
  @override
  String image_url,name,fertiId,step,effect, price,usablePlants,amount;
  FertilizerTile({
    this.image_url,
    this.name,
    this.amount,
    this.effect,
    this.fertiId,
    this.price,
    this.step,
    this.usablePlants
  });
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                FertiCardOnClick(amount: amount,name: name,image_url: image_url, effect: effect,fertiId: fertiId,price: price,step: step,usablePlants: usablePlants,)
        )
        );
      },
      child: Container(
        child: Card(
          margin: EdgeInsets.only(top:5.0,left: 10.0,right: 10.0),
          elevation: 1.0,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: 105.0,
                    height: 80.0,
                    child: CachedNetworkImage(
                      imageUrl: image_url,
                      fit: BoxFit.cover,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color(0xff000000),
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}