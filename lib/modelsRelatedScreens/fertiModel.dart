import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sane_lan_flutter/models/ferti.dart';
import 'package:sane_lan_flutter/models/health.dart';
import 'package:sane_lan_flutter/onClick/fertiCardOnClick.dart';
import 'package:sane_lan_flutter/onClick/healthCardOnClick.dart';
import 'package:uuid/uuid.dart';
class FertiModel extends StatefulWidget {
  @override
  _FertiModelState createState() => _FertiModelState();
}

class _FertiModelState extends State<FertiModel> {
  
  Fertilizer fertilizer;
  String name;
  String image_url;
  String amount;
  String effect;
  String step;
  String price;
  String usabelPlants;

  String fertiId= Uuid().v4();

  ///pick image
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color(0xff007084),
        title: Text('မြေဩဇာ',),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.0,),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('Fertilizer').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  List<FertiTile> fertiTile = [];
                  snapshot.data.documents.forEach((doc){
                    Fertilizer fertilizer = Fertilizer.fromDocument(doc);
                    fertiTile.add(FertiTile(fertilizer));
                  });
                  if(fertiTile.length==0){
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(height: 10.0,),
                          Icon(
                            Icons.system_update_alt,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text('No Data')
                        ],
                      ),
                    );
                  }
                  return ListView(
                    children: fertiTile,
                  );
                }
            ),
          ),

        ],
      ),
    );
  }

}
class FertiTile extends StatefulWidget {
  final Fertilizer fertilizer;

  const FertiTile(this.fertilizer);
  @override
  _FertiTileState createState() => _FertiTileState();
}

class _FertiTileState extends State<FertiTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FertiCardOnClick(
          fertiId: widget.fertilizer.fertiId,
          name: widget.fertilizer.name,
          image_url: widget.fertilizer.image_url,
          usablePlants: widget.fertilizer.usabelPlants,
          step: widget.fertilizer.step,
          amount: widget.fertilizer.amount,
          price: widget.fertilizer.price,
          effect: widget.fertilizer.effect,
        )));
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
                      imageUrl: widget.fertilizer.image_url,
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
                  widget.fertilizer.name,
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
