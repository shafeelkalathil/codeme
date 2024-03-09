import 'package:codemetech/features/Home/home-controller/home-controller.dart';
import 'package:codemetech/features/Home/home-repository/home-repository.dart';
import 'package:codemetech/features/login/screens/login-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../model/leads-model.dart';
import '../../login/auth-service/auth-service.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  HomeController? homeController;

  List<LeadModel> leadData=[];

  @override
  void initState()   {
    Future.delayed(Duration(milliseconds: 0), () {
      homeController = ref.read(homeControllerProvider.notifier);
      fetchData();
    });
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      leadData=(await homeController?.getAllLeads(ref.watch(tokenProvider)))!;
      setState(() {

      });
    } catch (e) {
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: screenWidth!*1,
                height: screenHeight!*0.1,
                child: Card(
                  child: Row(
                    children: [
                      Icon(Icons.menu_outlined,size: screenWidth!*0.08,),
                      SizedBox(width: screenWidth!*0.02,),
                      Text("Lead List",style: TextStyle(
                        fontSize: screenWidth!*0.05,
                      ),),
                      SizedBox(width: screenWidth!*0.5,),
                      IconButton(onPressed: () {
                        AuthService().logOut(context);
                      }, icon: Icon(Icons.logout,color: Colors.black,size: screenWidth!*0.1,))
                    ],
                  ),
                ),
              ),
              Container(
                width: screenWidth!*1,
                height: screenHeight!*0.8,
                child: ListView.builder(
                  itemCount: leadData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                   return  leadData.isEmpty
                       ? CircularProgressIndicator()
                       :EmployeeData(index: index,data: leadData,);
                },),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmployeeData extends ConsumerStatefulWidget {
  final int index;
  final List<LeadModel> data;
  const EmployeeData({super.key, required this.index, required this.data});

  @override
  ConsumerState<EmployeeData> createState() => _EmployeeDataState();
}

class _EmployeeDataState extends ConsumerState<EmployeeData> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      width: screenWidth!*0.9,
      height: screenHeight!*0.2,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: screenWidth!*0.12,
              height: screenHeight!*0.13,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xffDCE6FF)
              ),
              child: Center(
                child: Text('0${widget.index+1}'),
              ),
            ),
            Container(
              width: screenWidth!*0.45,
              height: screenHeight!*0.135,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.data[widget.index].name,style: TextStyle(
                      color: Color(0xff4263CE),
                      fontSize: screenWidth!*0.04,
                      fontWeight: FontWeight.w500
                  ),),
                  Text(widget.data[widget.index].email),
                  Text("Created: ${formatDate(widget.data[widget.index].createdAt)}"),
                  Text("Mob: ${widget.data[widget.index].mobile}"),
                ],
              ),
            ),
            Container(
              width: screenWidth!*0.4,
              height: screenHeight!*0.13,
              child: Row(
                children: [
                  Container(
                    width: screenWidth!*0.18,
                    height: screenHeight!*0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xffDCE6FF),
                    ),
                    child: Center(
                      child: Text("Flutter",style: TextStyle(
                        fontWeight: FontWeight.w400
                      ),),
                    ),
                  ),
                  Container(
                    width: screenWidth!*0.2,
                    height: screenHeight!*0.15,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on),
                            Text("${widget.data[widget.index].location}")
                          ],
                        ),
                        SizedBox(height: screenHeight!*0.025),
                        Icon(Icons.call,size: screenWidth!*0.1,)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }
}

