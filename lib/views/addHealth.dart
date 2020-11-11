import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:sane_lan_flutter/Pages/health.dart';
import 'package:sane_lan_flutter/services/database.dart';
class AddHealth extends StatefulWidget {
  @override
  _AddHealthState createState() => _AddHealthState();
}

class _AddHealthState extends State<AddHealth> {
  final _formKey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  String image_url, cure, name, symtom, healthId;
  bool isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  createHealthData(){
    healthId = randomAlphaNumeric(16);
    if(_formKey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      Map<String, String> healthInfo = {
        "image_url" : image_url,
        "name" : name,
        "cure" : cure,
        "symtom" : symtom,
        "healthId" : healthId
      };

      ///after adding data to name,bio, step, image_url
      databaseService.addHealthData(healthInfo, healthId).then((value){
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) =>  Health()
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
        title: Text('Add Health Data',),
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
                    hintText: "Plant Image Url"
                ),
                onChanged: (val){
                  image_url = val;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Plant Name" : null,
                decoration: InputDecoration(
                    hintText: "Health Name"
                ),
                onChanged: (val){
                  name = val;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Plant bio" : null,
                decoration: InputDecoration(
                    hintText: "Health Cure"
                ),
                onChanged: (val){
                  cure = val;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Plant Step" : null,
                decoration: InputDecoration(
                    hintText: "Health symtoms"
                ),
                onChanged: (val){
                  symtom = val;
                },
              ),

              Spacer(),
              GestureDetector(
                onTap: () {
                  createHealthData();
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
                    "Create Health Data",
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