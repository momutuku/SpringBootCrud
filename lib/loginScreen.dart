import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'produceScreen.dart';
import 'registerScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

addLoginState() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("logged", true);
}

getLoginState() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return bool
  bool? boolValue = prefs.getBool('logged');
  return boolValue;
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

  UserInfo getString(json) {
    return UserInfo(
      user_name: json['username'],
      user_email: json['email'],
      user_created: json['created'],
      user_password: json['password'],
    );
  }
}

Future<UserInfo> loginUser(UserInfo user, BuildContext ctx)async{

  var authurl = Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCZga73Ed3tZ_F4XtbocUQ87VDxkTv-mMM");
  var userr =  user.authJson(user.user_email,user.user_password);

  var response2 = await http.post(authurl,
      headers:<String,String>{
        "Content-Type":"application/json"
      },
      body:json.encode(userr));
  if(response2.statusCode ==200){
    addLoginState();
    Navigator.push(
      ctx,
      MaterialPageRoute(
          builder: (ctx) => produceScreen(userinfo:user)),
    );
  }else{
    print("Error with auth: "+response2.body);
  }

  return user;
}


// mokikata@gmail.coM
enum AuthStatus {
  successful,
  wrongPassword,
  emailAlreadyExists,
  invalidEmail,
  weakPassword,
  unknown,
}

class AuthExceptionHandler {
  static handleAuthException(FirebaseAuthException e) {
    AuthStatus status;
    switch (e.code) {
      case "invalid-email":
        status = AuthStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthStatus.wrongPassword;
        break;
      case "weak-password":
        status = AuthStatus.weakPassword;
        break;
      case "email-already-in-use":
        status = AuthStatus.emailAlreadyExists;
        break;
      default:
        status = AuthStatus.unknown;
    }
    return status;
  }
  static String generateErrorMessage(error) {
    String errorMessage;
    switch (error) {
      case AuthStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthStatus.weakPassword:
        errorMessage = "Your password should be at least 6 characters.";
        break;
      case AuthStatus.wrongPassword:
        errorMessage = "Your email or password is wrong.";
        break;
      case AuthStatus.emailAlreadyExists:
        errorMessage =
        "The email address is already in use by another account.";
        break;
      default:
        errorMessage = "An error occured. Please try again later.";
    }
    return errorMessage;
  }
}

Future<AuthStatus> resetPassword( {required String email}) async {
  Firebase.initializeApp();
  final _auth = FirebaseAuth.instance;
  AuthStatus _status;
  _status = AuthStatus.successful;
  await _auth
      .sendPasswordResetEmail(email: email)
      .then((value) => _status = AuthStatus.successful)
      .catchError((e) => _status = AuthExceptionHandler.handleAuthException(e));
  return _status;
}
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? user_name,user_email,user_created,user_password;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }



  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Login.',
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
                  "Fill form to login.",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 20),
              //Full name box

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
              //  Phone Number

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

              //  Signup Button
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xff39B54A),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        var user = UserInfo(user_name: "",
                            user_email: "user_email!",
                            user_created: "",
                            user_password: "user_password!");
                        loginUser(user,context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => produceScreen(userinfo:user)),
                        );
                      },
                      child: Text('Login',
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
                          const EdgeInsets.fromLTRB(30.00, 0.00, 0.00, 0.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                        child: Text(
                          'Create Account',

                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xff39B54A),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(111.00, 0.00, 0.00, 0.0),
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => RegisterScreen()),
                          // );
                          Firebase.initializeApp();
                          resetPassword(email:user_email!);
                        },
                        child: Text(
                          'Forgot PIN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xff39B54A),
                          ),
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
    );
  }
}
