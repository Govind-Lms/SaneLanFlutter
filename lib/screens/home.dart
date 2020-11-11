import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sane_lan_flutter/Pages/agri.dart';
import 'package:sane_lan_flutter/Pages/ferti.dart';
import 'package:sane_lan_flutter/Pages/health.dart';
import 'package:sane_lan_flutter/modelsRelatedScreens/agriModel.dart';
import 'package:sane_lan_flutter/modelsRelatedScreens/fertiModel.dart';
import 'package:sane_lan_flutter/modelsRelatedScreens/healthModel.dart';
import 'package:sane_lan_flutter/Pages/husbandry.dart';
import 'package:sane_lan_flutter/Widgets/categories.dart';
import 'package:sane_lan_flutter/Widgets/dailyPriceCard.dart';
import 'package:sane_lan_flutter/Widgets/slider.dart';
import 'package:sane_lan_flutter/modelsRelatedScreens/husbandryModel.dart';
import 'package:sane_lan_flutter/modelsRelatedScreens/priceListModel.dart';
import 'package:sane_lan_flutter/screens/priceList.dart';
import 'package:sane_lan_flutter/views/addHealth.dart';
import 'package:sane_lan_flutter/views/addHusbandry.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff007084),
        title: Text('စိမ်းလန်း',),
      ),
      body: ListView(
        children: [


          ///slider
          SizedBox(height: 10.0,),
          CSlider(),


          ///categories
          SizedBox(height: 5.0,),
          Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text('Categories',textAlign: TextAlign.left,style: TextStyle(fontSize: 18.0,color: Colors.black),)),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AgriModel(),));
                  },
                  child: Aggri(context, "စိုက်ပျိုုးရေး", "assets/images/aggri.svg")),
              SizedBox(width: 15.0,),
              GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HusbandryModel()));
                  },
                  child: Husbandry(context, "မွေးမြူရေး", "assets/images/husbandry.svg")),
            ],
          ),
          SizedBox(height: 15.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FertiModel(),));
                  },
                  child: Aggri(context, "မြေဩဇာ", "assets/images/fertilizer.svg")),
              SizedBox(width: 15.0,),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HealthModel(),));
                },
                child: Husbandry(context, "ကျမ်းမာရေး", "assets/images/health.svg")),
            ],
          ),


          ///drag_down_container
          Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              alignment: Alignment.bottomLeft,
              child: Text('နေ့စဥ်စျေးနှုန်း',textAlign: TextAlign.left,style: TextStyle(fontSize: 18.0,color: Colors.black),)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 5.0),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  height: 60,
                  width: MediaQuery.of(context).size.width/2-40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xFFE5E5E5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 100,
                        color: Colors.white,
                      ),
                    ],
                  ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      isDense: false,
                      icon: SvgPicture.asset("assets/images/dropdown.svg"),
                      value: 1,


                      items: [
                        DropdownMenuItem(
                          child: Text("မန္တလေး"),
                          value: 1,
                          onTap: (){

                          },
                        ),
                        DropdownMenuItem(
                          child: Text("စစ်ကိုင်း"),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text("ရန်ကုန်"),
                          value: 3,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          value = value;
                        });
                      }),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 60,
                width: MediaQuery.of(context).size.width/2-40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xFFE5E5E5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 100,
                      color: Colors.white,
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        underline: SizedBox(),
                        icon: SvgPicture.asset("assets/images/dropdown.svg"),
                        value: '${DateFormat("d,MMMM").format(DateTime.now())}',
                        items: [
                          '${DateFormat("d,MMMM").format(DateTime.now())}',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style: TextStyle(fontSize: 14.0),),
                          );
                        }).toList(),
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
          //
          PriceListModel(),
          ///daily updates
          // Column(
          //   children: <Widget>[
          //     SizedBox(height: 10.0,),
          //     VegCard("နှမ်း", "   ၁တင်း", "၂၈၀၀၀ ကျပ်"),
          //     VegDivider(),
          //     VegCard("ပဲ    ", "   ၁တင်း", "၁၄၀၀၀ ကျပ်"),
          //     VegDivider(),
          //     VegCard("စပါး", "  ၁တင်း", "၁၃၀၀၀ ကျပ်"),
          //     VegDivider(),
          //     VegCard("နှမ်း", "   ၁တင်း", "၂၈၀၀၀ ကျပ်"),
          //     VegDivider(),
          //     VegCard("ပဲ    ", "   ၁တင်း", "၁၁၀၀၀ ကျပ်"),
          //     VegDivider(),
          //     VegCard("စပါး", "  ၁တင်း", "၁၅၀၀၀ ကျပ်"),
          //     VegDivider(),
          //     VegCard("နှမ်း ", "  ၁တင်း", "၂၁၀၀၀ ကျပ်"),
          //     VegDivider(),
          //   ],
          // )
        ],
      ),
    );
  }

}
