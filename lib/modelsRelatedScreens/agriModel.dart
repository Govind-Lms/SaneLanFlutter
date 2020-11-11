import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sane_lan_flutter/models/agri.dart';
import 'package:sane_lan_flutter/onClick/agriCardOnClick.dart';
import 'package:sane_lan_flutter/onClick/healthCardOnClick.dart';
import 'package:uuid/uuid.dart';
class AgriModel extends StatefulWidget {
  @override
  _AgriModelState createState() => _AgriModelState();
}

class _AgriModelState extends State<AgriModel> {

  Agriculture agriculture;
  String name;
  String image_url;
  String bio;
  String step;
  String plantId= Uuid().v4();

  ///pick image
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color(0xff007084),
        title: Text('စိုက်ပျိုးရေး',),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.0,),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('Plant').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  List<PlantTile> plantTile = [];
                  snapshot.data.documents.forEach((doc){
                    Agriculture agriculture = Agriculture.fromDocument(doc);
                    plantTile.add(PlantTile(agriculture));
                  });
                  if(plantTile.length==0){
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
                    children: plantTile,
                  );
                }
            ),
          ),

        ],
      ),
    );
  }

}
class PlantTile extends StatefulWidget {
  final Agriculture agriculture;

  const PlantTile(this.agriculture);
  @override
  _PlantTileState createState() => _PlantTileState();
}

class _PlantTileState extends State<PlantTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AgriCardOnClick(
          plantId: widget.agriculture.plantId,
          name: widget.agriculture.name,
          image_url: widget.agriculture.image_url,
          bio: widget.agriculture.bio,
          step: widget.agriculture.step,
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
                      imageUrl: widget.agriculture.image_url,
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
                  widget.agriculture.name,
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
