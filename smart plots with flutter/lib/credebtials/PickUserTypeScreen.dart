import 'package:flutter/material.dart';
import '../comon/MyTitle.dart';
import './UserType.dart';
import '../comon/Button.dart';
class PickUserType extends StatefulWidget {
   PickUserType({super.key});
    State<PickUserType> createState() => _PickUserType();
}
class _PickUserType extends State<PickUserType> {
  List<List> userTypes=[
      ["Farmer",Color(0xFF00651F),"/dashboard","images/farmer-avatar.png"],
      ["Vendor",Color(0xFF8400FF),'/vendor',"images/vendor-avatar.png"],
      ["Client",Color(0xFFFFAA00),'/client',"images/client-avatar.png"]
    ];
  Map<String,bool>selectedType={
    "Farmer":false,
    "Vendor":false,
    "Client":false
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(toolbarHeight: 80,
    title: Center(child: MyTitle(text: "Pick your user type",color: Colors.black,)
    ,)
    ,)
    ,
    body:ListView.builder(
      itemCount: userTypes.length,
      itemBuilder:
      (context,index){
        final userType=userTypes[index][0];
        final userColor=userTypes[index][1];
        final userRoot=userTypes[index][2];
        final userPath=userTypes[index][3];
        final isSelected=selectedType[userType];
        
        return Container(
          margin: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 0),
          child: UserType(
            color:userColor ,
             text: userType, 
             rout: userRoot,
             path: userPath,
             isSlected: isSelected,
             onCardTap:(value){
              setState(() {
                selectedType[userType]=value;
                for(String user in selectedType.keys){
                  if (user != userType){
                    print(user);
                    selectedType[user]=false;
                  }
                }
              });
             } ,),
        );
      }
       ),);
  }
}
/**
 * double width_1=0;
  double width_2=0;
  double width_3=0;
  void userToggler1(){
  setState(){
    width_1==0?3:0;
    width_2=0;
    width_3=0;
    }
  }
  void userToggler2(){
  setState(){
    width_2==0?3:0;
    width_1=0;
    width_3=0;
    
    }
    
  }
  void userToggler3(){
  setState(){
    width_3==0?3:0;
    width_2=0;
    width_1=0;
    }
  }
 * 
 * Center(child: 
    Column(children: [SizedBox(height: 30,),UserType(color: Color(0x9900651F),text: "Farmer",path: "./images/farmer-avatar.png",toggle:  userToggler1,width: width_1,rout: "/dashboard",)
    ,SizedBox(height: 20,),
    UserType(color: Color(0x995508D1),text: "Vendor",path: "./images/vendor-avatar.png",toggle:  userToggler2,width: width_2,rout: "/vendor",)
    ,SizedBox(height: 20,),
    UserType(color: Color(0x99FFAA00),text: "Client",path: "./images/client-avatar.png",toggle:  userToggler3,width: width_3,rout: "/client",),SizedBox(height: 10,),Button(onPress: (){}, text: "Signup")],),) */
