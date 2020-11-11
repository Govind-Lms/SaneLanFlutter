import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sane_lan_flutter/onClick/agriCardOnClick.dart';
import 'package:sane_lan_flutter/services/database.dart';

class Agriculture extends StatefulWidget {
  @override
  _AgricultureState createState() => _AgricultureState();
}

class _AgricultureState extends State<Agriculture> {
  DatabaseService databaseService= new DatabaseService();
  Stream agriStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff007084),
        title: Text('စိုက်ပျိုးရေး',),
      ),
      body: fertiList(),
    );
  }
  void initState() {
    databaseService.getPlantData().then((val){
      setState(() {
        agriStream= val;
      });
    });
    super.initState();
  }

  Widget fertiList() {
    return StreamBuilder(
      stream: agriStream,
      builder: (context, snapshot) {
        return snapshot.data == null
            ? Container(
          child: Center(child: CircularProgressIndicator()),
        )
            :
        ListView.builder(
          scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return AgriTile(
                image_url: snapshot.data.documents[index].data['image_url'],
                name: snapshot.data.documents[index].data['name'],
                plantId  :  snapshot.data.documents[index].data['plantId'],
                bio: snapshot.data.documents[index].data['bio'],
                step  :  snapshot.data.documents[index].data['step'],
              );
            }
        );
      },
    );
  }

}

// ignore: must_be_immutable
class AgriTile extends StatelessWidget{
  // ignore: non_constant_identifier_names
  String image_url,name,plantId,step,bio;
  AgriTile({
    // ignore: non_constant_identifier_names
    this.image_url,
    this.name,

    this.plantId,
    this.step,
    this.bio
  });
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
          AgriCardOnClick(
            image_url: image_url,
            bio: bio,
            plantId: plantId,
            step: step,
            name: name,
          )
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