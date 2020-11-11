import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sane_lan_flutter/onClick/husbandryCardOnClick.dart';
import 'package:sane_lan_flutter/services/database.dart';

class HusbandryPage extends StatefulWidget {
  @override
  _HusbandryPageState createState() => _HusbandryPageState();
}

class _HusbandryPageState extends State<HusbandryPage> {
  DatabaseService databaseService= DatabaseService();
  Stream husbandryStream;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff007084),
        title: Text('မွေးမြူရေး',),
      ),
      body: husbandryList(),
    );
  }
  void initState() {
    databaseService.getHusbandryData().then((val){
      setState(() {
        husbandryStream= val;
      });
    });
    super.initState();
  }

  Widget husbandryList() {
    return StreamBuilder(
      stream: husbandryStream,
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
              return HusbandryTile(
                image_url: snapshot.data.documents[index].data['image_url'],
                name: snapshot.data.documents[index].data['name'],
                husbandryId: snapshot.data.documents[index].data['husbandryId'],
                about: snapshot.data.documents[index].data['about'],
              );
            }
        );
      },
    );
  }
}


class HusbandryTile extends StatelessWidget {
  final String image_url, name, about,husbandryId;
  const HusbandryTile({this.image_url, this.about, this.name,this.husbandryId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HusbandryCardOnClick(image_url: image_url, about : about, name: name,husbandryId : husbandryId)));
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


