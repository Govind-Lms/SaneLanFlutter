import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sane_lan_flutter/models/ferti.dart';
class FertiCardOnClick extends StatefulWidget {
  String image_url,name,fertiId,step,effect, price,usablePlants,amount;
  FertiCardOnClick({
    this.image_url,
    this.name,
    this.amount,
    this.effect,
    this.fertiId,
    this.price,
    this.step,
    this.usablePlants
  });



  _FertiCardOnClickState createState() => _FertiCardOnClickState();
}

class _FertiCardOnClickState extends State<FertiCardOnClick> {
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(widget.name,style: TextStyle(fontSize: 15.0,color: Colors.black),),
                    SizedBox(width: 10.0,),
                    Text(widget.price,style: TextStyle(fontSize: 12.0,color: Colors.black),),
                  ],
                ),
                background: CachedNetworkImage(imageUrl: widget.image_url,fit: BoxFit.cover,)
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
                        child: Text('ပမာဏ',style: TextStyle(fontSize: 18.0),)
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 30 ,
                        child: Scrollbar(
                          child: Text(
                            widget.amount,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 15.0,
                            ),
                          ),
                        )
                    ),

                    Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('သက်ရောက်မှု',style: TextStyle(fontSize: 18.0),)
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 30 ,
                        child: Scrollbar(
                          child: Text(
                            widget.effect,
                            style: TextStyle(
                                fontSize: 13.0
                            ),
                          ),
                        )
                    ),

                    Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('သုံးစွဲပုံအဆင့်ဆင့်',style: TextStyle(fontSize: 18.0),)
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
                    ),

                    Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('သုံးစွဲနိုင်သောအပင်များ',style: TextStyle(fontSize: 18.0),)
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 30 ,
                        child: Scrollbar(
                          child: Text(
                            widget.usablePlants,
                            style: TextStyle(
                                fontSize: 13.0
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
                      children: fertiTile,
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
                imageUrl: widget.fertilizer.image_url,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Text(
                widget.fertilizer.name,
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
