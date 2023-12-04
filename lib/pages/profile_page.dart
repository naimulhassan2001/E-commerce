


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  File? image ;
  final _picker = ImagePicker() ;
  bool showSpinner = false ;



  Future<void> getImage() async {

    print("hss");

    final pickdFile = await _picker.pickImage(source: ImageSource.camera);
    if(pickdFile != null) {
      image = File(pickdFile.path) ;

      setState(() {

      });


    } else{
      print("no image") ;
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true ;
    });


    try{
      var strem = http.ByteStream(image!.openRead());

      var length = await image!.length() ;


      var uri = Uri.parse("https://demo.alorferi.com/api/my-products/3b7c8189-c5e5-4789-aa47-38426e9f73cd?_method=PUT") ;

      var request = http.MultipartRequest("Post", uri) ;



      request.fields['name'] = " static name" ;
      request.fields['price'] = "1000" ;
      request.fields['stock_quantity'] = "10" ;


      var multipor = http.MultipartFile(
        'image',
        strem,
        length
      );

      request.files.add(multipor) ;
      var response = await request.send() ;

      setState(() {
        showSpinner = false ;
      });


      if(response.statusCode == 200) {
        print("image Uploaded") ;
      } else{
        print("error") ;

      }




    }catch(e) {

    }





  }







  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(title: Text("Upload Image"),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: image == null ? Center(
                child:  GestureDetector(
                  onTap: getImage,
                    child: Text("Pick Image")),
              ):
              Container(
                child: Image.file(
                    File(image!.path).absolute,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                )
              ),
            ),
            SizedBox(height: 50,),
            ElevatedButton(onPressed: uploadImage, child: Text("Upload"))
          ],
        ),
      ),
    );
  }
}
