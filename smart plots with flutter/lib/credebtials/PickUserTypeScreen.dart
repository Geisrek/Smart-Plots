import 'package:flutter/material.dart';
import '../comon/MyTitle.dart';
import './UserType.dart';
import '../comon/Button.dart';
class PickUserType extends StatefulWidget {
   PickUserType({super.key});
    State<PickUserType> createState() => _PickUserType();
}
class _PickUserType extends State<PickUserType> {
  double width_1=0;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(toolbarHeight: 80,
    title: Center(child: MyTitle(text: "Pick your user type",color: Colors.black,)
    ,)
    ,)
    ,
    body: Center(child: 
    Column(children: [SizedBox(height: 30,),UserType(color: Color(0x9900651F),text: "Farmer",path: "./images/farmer-avatar.png",toggle:  userToggler1,width: width_1,rout: "/vendor",)
    ,SizedBox(height: 20,),UserType(color: Color(0x995508D1),text: "Vendor",path: "./images/vendor-avatar.png",toggle:  userToggler2,width: width_2,),SizedBox(height: 20,),UserType(color: Color(0x99FFAA00),text: "Client",path: "./images/client-avatar.png",toggle:  userToggler3,width: width_3,),SizedBox(height: 10,),Button(onPress: (){}, text: "Signup")],),),);
  }
}

