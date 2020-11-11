import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sane_lan_flutter/models/health.dart';
import 'package:sane_lan_flutter/models/husbandry.dart';
import 'package:sane_lan_flutter/onClick/healthCardOnClick.dart';
import 'package:sane_lan_flutter/onClick/husbandryCardOnClick.dart';
import 'package:uuid/uuid.dart';
class HusbandryModel extends StatefulWidget {
  @override
  _HusbandryModelState createState() => _HusbandryModelState();
}

class _HusbandryModelState extends State<HusbandryModel> {

  PriceList husbandry;
  String name;
  String image_url;
  String about;
  String husbandryId= Uuid().v4();

  ///pick image
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color(0xff007084),
        title: Text('မွေးမြူရေး'),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.0,),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('Husbandry').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  List<HusbandryTile> husbandryTile = [];
                  snapshot.data.documents.forEach((doc){
                    PriceList husbandry = PriceList.fromDocument(doc);
                    husbandryTile.add(HusbandryTile(husbandry));
                  });
                  if(husbandryTile.length==0){
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
                    children: husbandryTile,
                  );
                }
            ),
          ),

        ],
      ),
    );
  }

}
class HusbandryTile extends StatefulWidget {
  final PriceList husbandry;

  const HusbandryTile(this.husbandry);
  @override
  _HusbandryTileState createState() => _HusbandryTileState();
}

class _HusbandryTileState extends State<HusbandryTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HusbandryCardOnClick(
          husbandryId: widget.husbandry.hustbandryId,
          name: widget.husbandry.name,
          image_url: widget.husbandry.image_url,
          about: widget.husbandry.about,
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
                      imageUrl: widget.husbandry.image_url,
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
                  widget.husbandry.name,
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
