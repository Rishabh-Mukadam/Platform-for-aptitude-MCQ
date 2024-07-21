import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/main.dart';
import 'package:up_skill_1/Screens/Profile/profile_edit.dart';
import 'package:up_skill_1/Screens/onboding/onboding_without_logIn.dart';

import '../../Globs.dart';


class profile_screen extends StatefulWidget {
  const profile_screen({super.key});

  @override
  State<profile_screen> createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {


  FirebaseAuth auth=FirebaseAuth.instance;

  String user_name="";
  String user_img="";
  // int ques_solved=0;
  // int overall_score=0;
  // int monthly_score=0;
  // int daily_score=0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        user_name=documentSnapshot.get('user_name');
        user_img=documentSnapshot.get('img');
        // ques_solved=documentSnapshot.get('ques_solved');
        // overall_score=documentSnapshot.get('overall_score');
        // monthly_score=documentSnapshot.get('monthly_score');
        // daily_score=documentSnapshot.get('daily_score');
        setState(() {
        });
      } else {
        print('Document does not exist on the database');
      }
    }).catchError((error) {
      print('Error getting document: $error');
    });
  }



  @override
  Widget build(BuildContext context) {
    print("profile page build");
    return  Consumer<Globs>(
        builder:(context,value,child){
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.edit_note_outlined),
              onPressed: (){
               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profile_edit()));
              },
            ),
            body: Stack(
              children: [
                // Positioned.fill(
                //     child: Image.asset("assets/Backgrounds/img.png}",fit: BoxFit.cover,)
                // ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX:35,sigmaY: 35),
                    child: const SizedBox(),
                  ),
                ),
                Positioned.fill(
                    child:Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.grey.withOpacity(0.15),
                    )
                ),


                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //AppBar
                          SizedBox(height: 30,),
                          _appBar(),
                          SizedBox(height: 10,),
                          //User_info
                          _userInfo(user_name,"Terna College of Engineering","${auth.currentUser!.email}",user_img),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Divider(
                            ),
                          ),


                          //Activity

                          _functionName_text("Activity"),

                          _activity([value.overAll,value.noQues,value.monthly,value.daily]),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Divider(
                            ),
                          ),

                          //heat Map Calender
                          _functionName_text("Submissions"),
                          _heatMapCalender(),

                          ElevatedButton(onPressed: (){}, child: Text("Log Out"))



                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),

          );
        }
    );
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




  Widget _appBar(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: (){}, icon:Icon(Icons.search_outlined,size: 30,) ),
        const Text("Profile",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          // fontFamily: "Poppins"
        ),
        ),
        IconButton(onPressed: (){}, icon:Icon(Icons.menu_rounded) ),
      ],
    );
  }

  Widget _userInfo(String _name,String _institude,String _email,String img){
    return _emptyBox(
       Row(
        children: [
          const Flexible(child:  SizedBox(width: 10,),fit: FlexFit.loose,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(img),
            ),
          ),
          const SizedBox(width: 10,),
           Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_name,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
              const SizedBox(height: 5,),
              Text(_institude,style: TextStyle(fontSize: 12)),
              const SizedBox(height: 2,),
              Text(_email,style: TextStyle(fontSize: 12,fontStyle: FontStyle.italic,color: Colors.blue),),

            ],
          ),
        ],
      ),
    );
  }

  List<String> Activity_Name=['OverAll Score','no. ques solved','Monthly Score','daily score'];
  List<Icon> Activity_icon=[
    Icon(Icons.calendar_month_outlined,color: Colors.red,size: 30,),
    Icon(Icons.list,color: Colors.green,size: 30,),
    Icon(Icons.calendar_view_month_outlined,color: Colors.purple,size: 30,),
    Icon(Icons.ac_unit_outlined,color: Colors.blue,size: 30,),
  ];

  Widget _activity(List<int> Activity_score){
    return _emptyBox(
       GridView.builder(
         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
           crossAxisCount: 2,
           mainAxisSpacing: 8,
           crossAxisSpacing: 8,
           childAspectRatio: 1.7,
         ),
         shrinkWrap: true,
         itemCount: Activity_Name.length,
         itemBuilder: (BuildContext context, int index) {
           return _scroreCard(Activity_Name[index],Activity_score[index],Activity_icon[index]);

         },

       ),
    );
  }


  Widget _heatMapCalender(){
    return _emptyBox(
       HeatMapCalendar(
         defaultColor: Colors.white,
         flexible: true,
         colorMode: ColorMode.opacity,

        datasets:{
          DateTime(2023, 11, 6): 5,
          DateTime(2023, 11, 7): 7,
          DateTime(2023, 11, 8): 10,
          DateTime(2023, 11, 9): 13,
          DateTime(2023, 11, 13): 6,
          DateTime(2023, 11, 15): 10,
          DateTime(2023, 11, 14): 10,
          DateTime(2023, 11, 17): 7 ,
          DateTime(2023, 11, 20): 10,
          DateTime(2023, 11, 22): 13,
          DateTime(2023, 11, 23): 6,
          DateTime(2023, 1, 24): 2,

          DateTime(2023, 10, 1): 10,
          DateTime(2023, 10, 13): 7,
          DateTime(2023, 10, 3): 10,
          DateTime(2023, 10, 6): 13,
          DateTime(2023, 10, 7): 6,
          DateTime(2023, 10, 8): 2,
          DateTime(2023, 10, 24): 6,
          DateTime(2023, 10, 22): 2,
          DateTime(2023, 10, 19): 6,
          DateTime(2023, 10, 20): 2,


          DateTime(2024, 4, 8): 20,
          DateTime(2024, 4, 9): 2,
          DateTime(2024, 4, 7): 15,
          DateTime(2024, 4, 10): 10,
          DateTime(2024, 4, 11): 9,
          DateTime(2024, 4, 20): 20,
          DateTime(2024, 4, 21): 2,
          DateTime(2024, 4, 22): 15,
          DateTime(2024, 4, 19): 10,
          DateTime(2024, 4, 15): 9,

        },
        colorsets: const {
          1: Colors.red,
          3: Colors.orange,
          5: Colors.yellow,
          7: Colors.green,
          9: Colors.blue,
          11: Colors.indigo,
          13: Colors.purple,
        },
        onClick: (value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );;
  }


  Widget _emptyBox(Widget _child){
    return Container(
      padding: EdgeInsets.all(8),
      child: _child,
      decoration:  BoxDecoration(
          color: Colors.white.withAlpha(180),
          borderRadius: BorderRadius.circular(15),
         border: Border.all(color: Colors.white,width: 1)
      ),
    );
  }


  Widget _functionName_text(String name){
    return Padding(
      padding:  EdgeInsets.only(bottom: 8.0,left: 8,right: 8),
      child: Text(name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
    );
  }

  Widget _scroreCard(String _scroreName,int _score,Icon _icon){
    return  Container(
      decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white,width: 1)
      ),
      child:  Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_scroreName,style:TextStyle(fontSize: 15,color: Colors.grey[600]),),
                 Text(_score.toString(),style:TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600))
              ],
            ),
          ),
          _icon
        ],
      ),
    );
  }











  ////////////////////////////////////////////////////////////////////////////////////////////
}
