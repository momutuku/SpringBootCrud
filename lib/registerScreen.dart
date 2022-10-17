import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interviewstoneage/produceScreen.dart';
import 'loginScreen.dart';

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
          builder: (ctx) => produceScreen(user)),
    );
  }else{
    print("Error with auth: "+response2.body);
  }



}else{
  print("Error: "+response.body);
}

return user;
}

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  String? user_name,user_email,user_created,user_password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset : false,
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff39B54A),
                      fontFamily: 'MuseoSans',
                      fontSize: 32,
                    ),
                  ),

                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Prenat prediktisk framatltad.',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                        fontSize: 14,
                      ),
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
                            hintText: 'Full Names',
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
                            hintText: 'Email Address',
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

                  //  Agreement
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'By signing you agree to our ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                              child: Text(
                                'Terms of use',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(0xff39B54A),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Text(
                          ' and privacy notice',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //  Signup Button
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
                          child: Text('Sign Up',
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
                  //Already Registered
                  SizedBox(height: 20),
                  Center(
                    child: Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(100.00, 0.00, 0.00, 0.0),
                          child: Text(
                            'Already Registered?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          child: Text(
                            ' Login.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xff39B54A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
