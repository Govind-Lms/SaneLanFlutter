import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sane_lan_flutter/onClick/healthCardOnClick.dart';
import 'package:sane_lan_flutter/services/database.dart';

class Health extends StatefulWidget {
  @override
  _HealthState createState() => _HealthState();
}

class _HealthState extends State<Health> {

  DatabaseService databaseService= new DatabaseService();
  Stream healthKid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff007084),
        title: Text('ကျမ်းမာရေး',),
      ),
      body: healthList(),
    );
  }
  void initState() {
    databaseService.getHealthData().then((val){
      setState(() {
        healthKid= val;
      });
    });
    super.initState();
  }

  Widget healthList() {
    return StreamBuilder(
      stream: healthKid,
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
              return HealthTile(
                image_url: snapshot.data.documents[index].data['image_url'],
                name: snapshot.data.documents[index].data['name'],
                healthId: snapshot.data.documents[index].data['healthId'],
                cure  :  snapshot.data.documents[index].data['cure'],
                symtom  :  snapshot.data.documents[index].data['symtom'],
              );
            }
        );
      },
    );
  }

}

class HealthTile extends StatelessWidget{
  // ignore: non_constant_identifier_names
  String image_url ,name,healthId,cure,symtom;
  HealthTile({this.image_url,this.name,this.healthId,this.cure,this.symtom});
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>HealthCardOnClick(cure: cure,healthId: healthId,image_url: image_url,name: name,symtom: symtom,) ));
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