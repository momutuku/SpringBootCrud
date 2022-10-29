
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:transparent_image/transparent_image.dart';

import 'AddImage.dart';

class ImagesUrl {
  final String url;

  ImagesUrl({
    required this.url,
  });
}
class produceScreen extends StatefulWidget {
  var userinfo;

  produceScreen( {this.userinfo});
  @override
  State<produceScreen> createState() => _produceScreenState();
}




Future<List<ImagesUrl>> fetchImages() async {

  Uri url = Uri.parse("http://9fb3-105-160-92-81.ngrok.io/get?url=9fxvs47IdkNY7xK5aZGU");
  final response = await http.get(url);

  var responseData = json.decode(response.body);

  //Creating a list to store input data;
  List<ImagesUrl> users = [];
  print(responseData);
  for (var singleImg in responseData) {
    ImagesUrl img = ImagesUrl(
        url: singleImg["url"]);
    print(singleImg["url"]);

    //Adding user to the list.
    users.add(img);
  }
  return users;
}
class _produceScreenState extends State<produceScreen> {


  @override
  Widget build(BuildContext context) {
    String user_name = widget.userinfo!.user_name;
    String user_email = widget.userinfo!.user_email;
    String user_created = widget.userinfo!.user_created;
    String user_password = widget.userinfo!.user_password;
    // UserInfo  user= widget.userinfo!;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Back Button
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(11),
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back_ios_new_outlined, size: 15),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(11),
                          width: 49,
                          decoration: BoxDecoration(
                            // color: Colors.black12,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.notifications, size: 25),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Notification Buutton

                  //Body
                ],
              ),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Image Info',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'MuseoSans',
                        fontSize: 32,
                      ),
                    ),

                    SizedBox(height: 20),
                    // Container(
                    //   width: 300,
                    //   height:300,
                    //   child: GridView.builder(
                    //       itemCount: 7,
                    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //           crossAxisCount: 3),
                    //       itemBuilder: (context, index) {
                    //         return Container(
                    //           margin: EdgeInsets.all(3),
                    //           child: FadeInImage.memoryNetwork(
                    //               fit: BoxFit.cover,
                    //               placeholder: kTransparentImage,
                    //               image: 'https://picsum.photos/250?image=9',
                    //         ));
                    //       }),
                    // ),
                    Container(
                      width: 300,
                      height:300,
                      child:FutureBuilder(
                        future: fetchImages(),
                        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            return GridView.builder(
                                itemCount: snapshot.data.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: EdgeInsets.all(3),
                                      child: FadeInImage.memoryNetwork(
                                        fit: BoxFit.cover,
                                        placeholder: kTransparentImage,
                                        image: snapshot.data[index].url,
                                      ));
                                });
                          }
                        },
                      ),
                    )







                  ],
                ),
              ),

            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child:Icon(Icons.add),
          onPressed: (){
            Firebase.initializeApp();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddImage()),
            );
          },
        ),

      ),
    );
  }
}
