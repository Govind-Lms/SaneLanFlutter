import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:sane_lan_flutter/Pages/husbandry.dart';
import 'package:sane_lan_flutter/services/database.dart';
class AddHusbandry extends StatefulWidget {
  @override
  _AddHusbandryState createState() => _AddHusbandryState();
}

class _AddHusbandryState extends State<AddHusbandry> {
  final _formKey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  String image_url, about, name,husbandryId;
  bool isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  createHusbandryData(){
    husbandryId = randomAlphaNumeric(16);
    if(_formKey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      Map<String, String> husbandryInfo = {
        "image_url" : image_url,
        "name" : name,
        "about" : about,
        "husbandryId" : husbandryId,
      };

      ///after adding data to name,bio, step, image_url
      databaseService.addHusbandryData(husbandryInfo, husbandryId).then((value){
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) =>  HusbandryPage()
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color(0xff007084),
        title: Text('Add Husbandry Data',),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              ///info
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Plant Image Url" : null,
                decoration: InputDecoration(
                    hintText: "Husbandry Image Url"
                ),
                onChanged: (val){
                  image_url = val;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Plant Step" : null,
                decoration: InputDecoration(
                    hintText: "Ferti About"
                ),
                onChanged: (val){
                  about = val;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Plant Name" : null,
                decoration: InputDecoration(
                    hintText: "Husbandry Name"
                ),
                onChanged: (val){
                  name = val;
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  createHusbandryData();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text(
                    "Create Husbandry Data",
                    style: TextStyle(
                        fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],)
          ,),
      ),
    );
  }
}