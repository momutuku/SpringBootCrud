
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class produceScreen extends StatefulWidget {
  final  userinfo;
  produceScreen(this.userinfo);
  @override
  State<produceScreen> createState() => _produceScreenState(userinfo);
}

class UserInfo {
  String user_name;
  String user_email;
  String user_created;
  String user_password;

  UserInfo({
    required this.user_name,
    required this.user_email,
    required this.user_created,
    required this.user_password,
  });


  Map<String, dynamic> toJson() {
    return {
      'username': user_name,
      'email': user_email,
      'created': user_created,
      'password': user_password
    };
  }

  Map<String, dynamic> authJson(email,pass) {
    return {
      'email': email,
      'password': pass
    };
  }

  Map<String, dynamic> delJson(email,pass) {
    return {
      'email': email,
      'password': pass
    };
  }


  UserInfo getString(json) {
    return UserInfo(
      user_name: json['username'],
      user_email: json['email'],
      user_created: json['created'],
      user_password: json['password'],
    );
  }
}

Future<UserInfo> registerUser(UserInfo user, BuildContext ctx)async{
  var baseurl = "http://5e2b-105-21-41-70.ngrok.io";
  var url = Uri.https(baseurl,"/create");
  var authurl = Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCZga73Ed3tZ_F4XtbocUQ87VDxkTv-mMM");
  var response = await http.post(url,
      headers:<String,String>{
        "Content-Type":"application/json"
      },
      body:json.encode(user.toJson()));

  String resString = response.body;
  if(response.statusCode ==200){
    print(resString);
    var userr =  user.authJson(user.user_email,user.user_password);

    var response2 = await http.post(authurl,
        headers:<String,String>{
          "Content-Type":"application/json"
        },
        body:json.encode(userr));
    if(response2.statusCode ==200){
      Navigator.push(
        ctx,
        MaterialPageRoute(
            builder: (ctx) => produceScreen(userr)),
      );
    }else{
      print("Error with auth: "+response2.body);
    }



  }else{
    print("Error: "+response.body);
  }

  return user;
}


Future<UserInfo> deleteUser(UserInfo user, BuildContext ctx)async{
var baseurl = "http://5e2b-105-21-41-70.ngrok.io";
  var url = Uri.parse(baseurl+"/delete?user="+user.user_name);
  var userr =  user.authJson(user.user_email,user.user_password);
  var response = await http.put(url,
      headers:<String,String>{
        "Content-Type":"application/json"
      },
      body:json.encode(user.toJson()));

  if(response.statusCode ==200){
    print(response.body);
  }else{
    print("Error with auth: "+response.body);
  }



  return user;
}


class ProductsList {
  //  project TEXT,option TEXT,name TEXT,price INTEGER
  // ProductsList({required this.project,required this.option,required this.name, required this.price, this.id = 0});
  String name,project,option;
  double price;
  int id;

  ProductsList({required this.project,required this.option,required this.name, required this.price, this.id = 0});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'project': project,
      'option': option,
      'price': price
    };
  }


  ProductsList getString(json) {
    return ProductsList(
      name: json['name'],
      price: json['price'],
      project: json['project'],
      option: json['option'],
    );
  }
}

class _produceScreenState extends State<produceScreen> {



  _produceScreenState(userinfo);


  static UserInfo get userinfo => userinfo;
  UserInfo  user= userinfo;



  @override
  Widget build(BuildContext context) {
    String user_name = user.user_name;
    String user_email = user.user_email;
    String user_created = user.user_created;
    String user_password = user.user_password;

    return Scaffold(
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
                      onTap: () {
                        Navigator.pop(context);
                      },
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
                    'User info',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'MuseoSans',
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(height: 20),
                  //Full name box
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          // user_name,user_email,user_created,user_password;
                          onChanged: (String? newValue) {
                            setState(() {
                              user_name = newValue!;
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: user.user_name,
                            icon: Icon(Icons.people),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //  email field
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          // ,user_created,user_password;
                          onChanged: (String? newValue) {
                            setState(() {
                              user_email = newValue!;
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.email),
                            hintText: user.user_email,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //  Password
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          onChanged: (String? newValue) {
                            setState(() {
                              user_password = newValue!;
                            });
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.password),
                            hintText: 'Password',
                          ),
                        ),
                      ),
                    ),
                  ),
                  //  Confirm Passowrd
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          onChanged: (String? newValue) {
                            setState(() {
                              user_created = newValue!;
                            });
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.password),
                            hintText: 'Confirm Password',
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xff39B54A),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ProfileScreen()),
                            // );
                            var user =  UserInfo(
                              user_name: user_name!,
                              user_email: user_email!,
                              user_created: user_created!,
                              user_password: user_password!,
                            );
                            registerUser(user,context);

                          },
                          child: Text('Update',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'MuseoSans',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ProfileScreen()),
                            // );
                            var user =  UserInfo(
                              user_name: user_name!,
                              user_email: user_email!,
                              user_created: user_created!,
                              user_password: user_password!,
                            );
                            deleteUser(user,context);

                          },
                          child: Text('Delete',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'MuseoSans',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                  ),





                ],
              ),
            ),

          ]),
        ),
      ),

    );
  }
}
