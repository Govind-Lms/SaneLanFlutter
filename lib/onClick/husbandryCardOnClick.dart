import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sane_lan_flutter/models/husbandry.dart';
class HusbandryCardOnClick extends StatefulWidget {
  final image_url;
  final name;
  final about;
  final husbandryId;
  HusbandryCardOnClick({this.image_url, this.about, this.name,this.husbandryId});

  _HusbandryCardOnClickState createState() => _HusbandryCardOnClickState();
}

class _HusbandryCardOnClickState extends State<HusbandryCardOnClick> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.name,style: TextStyle(fontSize: 18.0),),
                background: CachedNetworkImage(imageUrl: widget.image_url,fit: BoxFit.cover,),
            ),
            backgroundColor: Color(0xff007084),
          ),
          SliverFillRemaining(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('ဗဟုသုတ',style: TextStyle(fontSize: 18.0),)
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 30 ,
                        child: Scrollbar(
                          child: Text(
                            widget.about,
                            style: TextStyle(
                                fontSize: 15.0
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.0)
        ),
        margin: EdgeInsets.only(top: 10.0),
        height: 220.0,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      'Related Topics'
                  ),
                  Text(
                    '',style: TextStyle(color: Color(0xff007084),fontWeight: FontWeight.w600),
                  )

                ],
              ),
            ),

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
                      scrollDirection: Axis.horizontal,
                      children: husbandryTile,
                    );
                  }
              ),
            ),


          ],
        ),
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
        margin: EdgeInsets.all(10.0),
        width: 120.0,
        height: 170.0,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                // color: Colors.white.withOpacity(0.9),
                width: 120.0,
                height: 170.0,
                imageUrl: widget.husbandry.image_url,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Text(
                widget.husbandry.name,
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),

          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            begin: Alignment(0.0, -1.0),
            end: Alignment(0.0, 3.0),
            colors: [
              const Color(0xd9008577),
              const Color(0x1f262626)
            ],
            stops: [0.0, 1.0],
          ),
        ),
      ),
    );
  }
}
