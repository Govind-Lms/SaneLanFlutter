import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sane_lan_flutter/models/agri.dart';
class AgriCardOnClick extends StatefulWidget {
  final image_url;
  final bio;
  final name;
  final step;
  final plantId;
  const AgriCardOnClick({this.image_url, this.bio, this.name, this.step,this.plantId});

  _AgriCardOnClickState createState() => _AgriCardOnClickState();
}

class _AgriCardOnClickState extends State<AgriCardOnClick> {
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
              background: Image.network(widget.image_url,fit: BoxFit.cover,)
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
                          widget.bio,
                          style: TextStyle(
                            fontSize: 13.0
                          ),
                        ),
                      )
                    ),
                    Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('စိုက်ပျိူးပုံအဆင့်ဆင့်',style: TextStyle(fontSize: 18.0),)
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 30 ,
                        child: Scrollbar(
                          child: Text(
                            widget.step,
                            style: TextStyle(
                                fontSize: 13.0
                            ),
                          ),
                        )
                    )
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
                        child: Row(
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
                      children: plantTile ,
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
                imageUrl: widget.agriculture.image_url,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Text(
                widget.agriculture.name,
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
