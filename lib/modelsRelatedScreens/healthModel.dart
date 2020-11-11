import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:sane_lan_flutter/models/health.dart';
import 'package:sane_lan_flutter/onClick/healthCardOnClick.dart';
import 'package:uuid/uuid.dart';
class HealthModel extends StatefulWidget {
  @override
  _HealthModelState createState() => _HealthModelState();
}

class _HealthModelState extends State<HealthModel> {

  Health health;
  String name;
  String image_url;
  String cure;
  String symtom;
  String healthId= Uuid().v4();

  ///pick image
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color(0xff007084),
        title: Text('ကျမ်းမာရေး',),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.0,),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('Health').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  List<HealthTile> healthTile = [];
                  snapshot.data.documents.forEach((doc){
                    Health health = Health.fromDocument(doc);
                    healthTile.add(HealthTile(health));
                  });
                  if(healthTile.length==0){
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
                    children: healthTile,
                  );
                }
            ),
          ),

        ],
      ),
    );
  }

}
class HealthTile extends StatefulWidget {
  final Health health;

  const HealthTile(this.health);
  @override
  _HealthTileState createState() => _HealthTileState();
}

class _HealthTileState extends State<HealthTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HealthCardOnClick(
          healthId: widget.health.healthId,
          name: widget.health.name,
          image_url: widget.health.image_url,
          cure: widget.health.cure,
          symtom: widget.health.symtom,
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
                      imageUrl: widget.health.image_url,
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
                  widget.health.name,
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
