
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:up_skill_1/Screens/Explore/Explore_components/Modules_tab.dart';

import '../../Globs.dart';
import 'Explore_components/Youtube_explo.dart';

class Explore_screen extends StatefulWidget {
  const Explore_screen({super.key});

  @override
  State<Explore_screen> createState() => _Explore_screenState();
}

class _Explore_screenState extends State<Explore_screen> {

  String user_name="!!";
  FirebaseAuth auth=FirebaseAuth.instance;

  void getData() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        user_name="${documentSnapshot.get('user_name')} !!";
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
  void initState() {
    // TODO: implement initState
    getData();
  }


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 300.0,
              leading: SizedBox(),
              backgroundColor: Colors.white,
              bottom: TabBar(
                padding: EdgeInsets.symmetric(horizontal: 20),
                indicatorColor: Colors.grey,
                labelColor: Colors.red,
                indicator: BoxDecoration(
                ),
                tabs: [
                  Tab(text: 'Modules',),
                  Tab(text: 'Explore',),
                  Tab(text: 'Tournament',)
                ],
              ),
              flexibleSpace:   FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.search,size: 35,),padding: EdgeInsets.zero,),
                          IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.person_alt_circle,size: 35,),padding: EdgeInsets.zero,),
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 10,top: 10),
                        child: Text('Hello,',style: TextStyle(fontSize: 35,fontWeight: FontWeight.w300,),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 15,bottom: 25),
                        child: Text(user_name,style: TextStyle(fontSize: 45,fontWeight: FontWeight.w500),),
                      ),
                    ],
                  ),
                ),

              ),

            ),
            SliverFillRemaining(
              child:TabBarView(
                  children: [
                    Modules_tab(),
                    Expo_youtube(),
                    Center(child: Text("Tab3"),),
                  ]
              )
            )
          ],
        ),
      ),







    );
  }
}

