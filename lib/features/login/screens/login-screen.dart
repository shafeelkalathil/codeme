import 'package:codemetech/features/login/auth-service/auth-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Home/screens/home.dart';

double? screenWidth;
double? screenHeight;

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();


  @override
  void initState() {
    checkPermission();
    super.initState();
  }

  void checkPermission() {
    Future.delayed(const Duration(seconds: 0)).then((value) {
      AuthService().keepLogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth=MediaQuery.of(context).size.width;
    screenHeight=MediaQuery.of(context).size.height;


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// image
              Container(
                width: screenWidth!*1,
                height: screenHeight!*0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(screenWidth!*0.4),
                  ),
                  image: DecorationImage(image: NetworkImage("https://educationgateway.org/wp-content/uploads/2023/08/Get-Connected1.png"),fit: BoxFit.cover)
                ),
              ),
              SizedBox(height: screenHeight!*0.04,),

              ///signIn Head
              Padding(
                padding:  EdgeInsets.only(left: screenWidth!*0.095),
                child: Text("Sign In",style: TextStyle(
                  color: Color(0xff4263CE),
                  fontSize: screenWidth!*0.05,
                  fontWeight: FontWeight.w500
                ),),
              ),
              SizedBox(height: screenHeight!*0.01,),

              ///welcome text
              Padding(
                padding:  EdgeInsets.only(left: screenWidth!*0.095),
                child: Text("Welcome back ! Please enter your credentials to login",style: TextStyle(
                  fontSize: screenWidth!*0.03,
                ),),
              ),
              SizedBox(height: screenHeight!*0.02,),

              ///form
              Form(
                key: formKey,
                  child: Padding(
                    padding:  EdgeInsets.only(left: screenWidth!*0.08,right: screenWidth!*0.08),
                    child: Column(
                children: [
                    ///username textformfield
                    Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none
                      ),
                      elevation: 4,
                      child: TextFormField(
                        // focusNode: _focusNode,
                        autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        validator: (value) {
                          if (value!.trim() == null || value.trim().isEmpty) {
                            return 'Please enter an userName';
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                        decoration: InputDecoration(
                          labelText: "User Name",
                          hintText: "User Name",
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.grey),
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                            borderSide:BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight!*0.01,),
                    ///password textformfield
                    Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none
                      ),
                      elevation: 4,
                      child: TextFormField(
                        autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                        controller: passwordController,
                        validator: (value) {
                          if (value!.trim() == null || value.trim().isEmpty) {
                            return 'Please enter an password';
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Password",
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.grey),
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                            borderSide:BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight!*0.02,),
                    ///forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Forgot your",style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenWidth!*0.025
                        ),),
                        Text(" Password ?",style: TextStyle(
                          fontSize: screenWidth!*0.03
                        ),),
                        SizedBox(width: screenWidth!*0.013,)
                      ],
                    )
                ],
              ),
                  )),
              SizedBox(height: screenHeight!*0.03,),

              ///SignIn button
              Padding(
                padding:  EdgeInsets.only(left: screenWidth!*0.083,right: screenWidth!*0.083),
                child: InkWell(
                  onTap: () {
                    Login(emailController.text,passwordController.text);
                  },
                  child: Container(
                    width: screenWidth!*1,
                    height: screenHeight!*0.07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      color: Color(0xff130A49),
                    ),
                    child: Center(
                      child: Text("Sign In",style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth!*0.045,
                        fontWeight: FontWeight.w500
                      ),),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight!*0.03,),

              ///signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont't have any account?"),
                  Text("Sign Up",style: TextStyle(
                      color: Color(0xff4263CE),
                    fontWeight: FontWeight.w500
                  ),),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  Login(username,password)async{

    AuthService().Login(username, password,context,ref);
  }
}
