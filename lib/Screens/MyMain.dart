import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:up_skill_1/Screens/Explore/Explore.dart';
import 'package:up_skill_1/Screens/MCQ_screen/mcq_screen.dart';
import 'package:up_skill_1/Screens/Profile/profile.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:up_skill_1/Screens/Search/Search_screen.dart';

import 'MathsSolver.dart';


class MyMain extends StatefulWidget {
  const MyMain({super.key});

  @override
  State<MyMain> createState() => _MyMainState();
}

class _MyMainState extends State<MyMain> {

  int _index=0;
  List<Widget> _screens=[
    Explore_screen(),
    Search_screen(),
    Math_solver(),
    profile_screen()
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: IndexedStack(
        index: _index,
        children: _screens,
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _index,
        onTap: (value){
          setState(() {
            _index=value;
            print(value);
          });
        },
        backgroundColor: Colors.white.withAlpha(250),
        items: [
          SalomonBottomBarItem(
              icon: const Icon(CupertinoIcons.home),
              title: const Text("Home"),
              selectedColor: Colors.red[500]

          ),


          // SalomonBottomBarItem(
          //     icon: const Icon(CupertinoIcons.square_list),
          //     title: const Text("MCQ"),
          //     selectedColor: Colors.deepPurple[300]
          // ),


          SalomonBottomBarItem(
              icon: const Icon(CupertinoIcons.search_circle),
              title: const Text("Search"),
              selectedColor: Colors.lightGreen[500]
          ),

          SalomonBottomBarItem(
              icon: const Icon(CupertinoIcons.camera_on_rectangle),
              title: const Text("Solution"),
              selectedColor: Colors.amber
          ),

          SalomonBottomBarItem(
              icon: const Icon(CupertinoIcons.profile_circled),
              title: const Text("Profile"),
              selectedColor: Colors.amber
          ),
        ],
      ),
    );
  }
}
