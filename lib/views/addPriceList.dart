//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:sanelanflutter/screens/home.dart';
//import 'package:sanelanflutter/services/database.dart';
//class AddPriceList extends StatefulWidget {
//  @override
//  _AddPriceState createState() => _AddPriceState();
//}
//
//class _AddPriceState extends State<AddPriceList> {
//  final _formKey = GlobalKey<FormState>();
//  // ignore: non_constant_identifier_names
//  String count, name, price;
//  bool isLoading = false;
//  DatabaseService databaseService = new DatabaseService();
//
//  createPriceList(){
//    if(_formKey.currentState.validate()){
//      setState(() {
//        isLoading = true;
//      });
//      Map<String, String> priceList = {
//        "name" : name,
//        "count" : count,
//        "price" : price
//      };
//
//      ///after adding data to name,count,price
//      databaseService.addPriceList(priceList).then((value){
//        setState(() {
//          isLoading = false;
//        });
//        Navigator.pushReplacement(context, MaterialPageRoute(
//            builder: (context) =>  Home()
//        ));
//      });
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      resizeToAvoidBottomPadding: false,
//      appBar: AppBar(
//        backgroundColor: Color(0xff007084),
//        title: Text('Add Plant Data',),
//      ),
//      body: Form(
//        key: _formKey,
//        child: Container(
//          padding: EdgeInsets.symmetric(horizontal: 24),
//          child: Column(
//            children: [
//              ///info
//              TextFormField(
//                validator: (val) => val.isEmpty ? "Enter Plant Image Url" : null,
//                decoration: InputDecoration(
//                    hintText: "Veg Name"
//                ),
//                onChanged: (val){
//                  name = val;
//                },
//              ),
//              SizedBox(height: 10,),
//              TextFormField(
//                validator: (val) => val.isEmpty ? "Enter Plant Name" : null,
//                decoration: InputDecoration(
//                    hintText: "Veg Count"
//                ),
//                onChanged: (val){
//                  count = val;
//                },
//              ),
//              SizedBox(height: 10,),
//              TextFormField(
//                validator: (val) => val.isEmpty ? "Enter Plant bio" : null,
//                decoration: InputDecoration(
//                    hintText: "Veg Price"
//                ),
//                onChanged: (val){
//                  price = val;
//                },
//              ),
//              Spacer(),
//              GestureDetector(
//                onTap: () {
//                  createPriceList();
//                },
//                child: Container(
//                  alignment: Alignment.center,
//                  width: MediaQuery.of(context).size.width,
//                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//                  decoration: BoxDecoration(
//                      color: Color(0xff007084),
//                      borderRadius: BorderRadius.circular(10)
//                  ),
//                  child: Text(
//                    "Create Plant Data",
//                    style: TextStyle(
//                        fontSize: 16, color: Colors.white),
//                  ),
//                ),
//              ),
//              SizedBox(
//                height: 60,
//              ),
//            ],)
//          ,),
//      ),
//    );
//  }
//}