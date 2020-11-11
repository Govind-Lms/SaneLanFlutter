import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sane_lan_flutter/models/pricelist.dart';
class PriceListModel extends StatefulWidget {
  @override
  _PriceListModelState createState() => _PriceListModelState();
}

class _PriceListModelState extends State<PriceListModel> {
  
  String name;
  String price;
  String count;

  ///pick image
  bool isLoading = false;
  Widget vegRow(){
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('PriceList').document('mandalay').collection('mandalay').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(),);
          }
          List<PriceTile> priceTile = [];
          snapshot.data.documents.forEach((doc){
            PriceList priceList = PriceList.fromDocument(doc);
            priceTile.add(PriceTile(priceList));
          });
          if(priceTile.length==0){
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
            shrinkWrap: false,
            children: priceTile,
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: vegRow(),
      width: MediaQuery.of(context).size.width,
      height: 300.0,
    );
  }

}
class PriceTile extends StatefulWidget {
  final PriceList priceList;

  const PriceTile(this.priceList);
  @override
  _PriceTileState createState() => _PriceTileState();
}

class _PriceTileState extends State<PriceTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              widget.priceList.name,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            Text(
              widget.priceList.count,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            Text(
              widget.priceList.price,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 1.0,left: 30.0,right: 30.0),
          child: Divider(
            height: 1.0,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
