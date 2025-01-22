import 'dart:convert';
import 'dart:io';

import 'package:Smart_pluts/comon/MyText.dart';
import 'package:Smart_pluts/constants/constants.dart';
import 'package:Smart_pluts/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:path/path.dart'; 

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
Dio dio=new Dio();
Uint8List? _image;
  void selectPhoto() async{
  XFile? img=await pickImage(ImageSource.gallery);
  _image= await img!.readAsBytes();
setState(() {
 
});

   try { 
    FormData data= FormData.fromMap({
      "id":17,
      "image":MultipartFile.fromBytes(_image!,filename: 'upload.jpg')
    });
    dynamic response= await dio.post("http://$IP:8000/api/uploadProfileImage",
    data: data,
    options: Options(
      headers: { "Content-Type": "multipart/form-data"
      }
    ));
    if (response.statusCode == 200) { 
      print('Upload successful: ${response.data['url']}');
       } 
    else { print('Upload failed: ${response.statusCode}'); 
    }
   }
    catch (e) {
          print('Error: $e'); 
          }
  }
Future<Map> getProfile()async{
  try{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    dynamic user=jsonDecode(preferences.getString("user")!);
    dynamic response= await http.post(
      Uri.parse("http://$IP:8000/api/profile"),
       headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "id":user["id"]
    })
    );
    if(response.statusCode==200){
      return jsonDecode(response.body);
    }
    else{
      print("Profile not found");
    }

  }catch(err){
    print(err);
  }
  return {};
}
Future<Uint8List> getUserPhoto()async{
  try{
   dynamic response=await http.post(
    Uri.parse("http://$IP:8000/api/image"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      {
        "path":"images/images/gMo787AZowDY97WmvycXfx1hBbgWNcTTqXrbfyxb.jpg"
      }
    )
   );
   
   if(response.statusCode==200){
    print(200);
    return response.bodyBytes;
   }
  throw Exception('Failed to load image');
  }
  catch(err){
   throw Exception('Failed to load image : $err');
  }
}
Future<Uint8List> getUserProfilePhoto(path)async{
  try{
   dynamic response=await http.post(
    Uri.parse("http://$IP:8000/api/image"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      {
        "path":path
      }
    )
   );
   if(response.statusCode==200){
    print(200);
    return response.bodyBytes;
   }
  throw Exception('Failed to load image');
  }
  catch(err){
   throw Exception('Failed to load image : $err');
  }
}
  @override
  Widget build(BuildContext context) {
    getUserPhoto();
    return Scaffold(
      body: Container(
        child: Center(child: 
        Column(children: [
          Container(
            child: FutureBuilder(future: getProfile() , builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return Column(
                  children: [
                    MyText(text: "Pending..."),
                    SizedBox(height: 5,)
                    ,MyText(text: "Pending..."),
                    SizedBox(height: 5,),
                    MyText(text: "Pending..."),
                    SizedBox(height: 5,),
                    MyText(text: "Pending..."),
                    SizedBox(height: 5,)
                  ],
                );
              }
              else if(snapshot.hasError){
                return MyText(text: "${snapshot.error}");
              }
              else{
                dynamic data= snapshot.data;
                return Column(
                  children: [
                           data["user_image"]!=null?  FutureBuilder(future: getUserProfilePhoto(data["user_image"]), builder:   (context,snapshot){
                          if(snapshot.connectionState==ConnectionState.waiting){
                          return MyText(text: "Pending...");
                        }
                        else if(snapshot.hasError){
                          return MyText(text: "${snapshot.error}");
                        }
                        else{
                          Uint8List image = snapshot.data as Uint8List;
                          return  Stack(
                        children: [
                          CircleAvatar(
                            radius: 65,
                            backgroundImage:MemoryImage(image),
                          ) ,
                          Positioned(child: 
                          IconButton(onPressed: selectPhoto, icon: Icon(
                            Icons.add_a_photo
                          ))
                          ,
                          left: 80,
                          bottom: -7,
                          )
                        ],
                      );
                        }
                      }):Stack(
            children: [
              _image!=null? CircleAvatar(
                radius: 65,
                backgroundImage:MemoryImage(_image!),
              ) :CircleAvatar(
                radius: 65,
                backgroundImage: NetworkImage("https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"),
              ),
              Positioned(child: 
              IconButton(onPressed: selectPhoto, icon: Icon(
                Icons.add_a_photo
              ))
              ,
              left: 80,
              bottom: -7,
              )
            ],
          ),
                    SizedBox(height: 5,)
                    ,MyText(text: "Name: ${data["name"]}"),
                    SizedBox(height: 5,),
                    MyText(text: "Email: ${data["email"]}"),
                    SizedBox(height: 5,),
                    MyText(text: "From: ${data["user_address"]}"),
                    SizedBox(height: 5,)
                  ],);
              }
            }),
          )
          
        ],)
        ,),
      ),
    );
  }
}

/*
 CircleAvatar(
                radius: 65,
                backgroundImage: NetworkImage("./images/client-avatar.png"),
              )
*/