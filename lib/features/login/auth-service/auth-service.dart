
import 'dart:convert';


import 'package:codemetech/features/login/screens/login-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:codemetech/end-points/api-base-endpoits.dart';
import 'package:codemetech/end-points/auth-endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Home/screens/home.dart';


final tokenProvider=StateProvider((ref) => "");

class AuthService{

  ///login
  Login(String username,String password,BuildContext context,ref)  async {
    var Url=Uri.parse(ApiBaseEndPoints.baseUrl+AuthBaseEndPoints.authBaseUrl);
    var res=await http.post(Url,body: {
      "username":username,
      "password":password
    });
    if(res.statusCode==200){
      SharedPreferences pref=await SharedPreferences.getInstance();
      Map<String, dynamic> jsonResponseMap = json.decode(res.body);
      String token = jsonResponseMap['data']['token'];
      pref.setString("token", token);
      ref.read(tokenProvider.notifier).state=token;
      var snackBar = SnackBar(
        content: Text(jsonResponseMap["message"]??''),
        duration: Duration(seconds: 2),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
    }else{
      const snackBar = SnackBar(
        content: Text('Username or Password Incorrect'),
        duration: Duration(seconds: 2),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }

  }

  Future<void> keepLogin(BuildContext context) async {

    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("token") && (prefs.getString("token")??'').isNotEmpty) {
      Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage(),));
    }
    else {
    }
  }

  logOut(context)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false);
  }
}