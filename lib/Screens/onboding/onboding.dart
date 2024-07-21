import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:up_skill_1/Screens/MyMain.dart';
// import 'package:rive/rive.dart';
import 'package:up_skill_1/Screens/onboding/components/LogIn_form.dart';


class onboding extends StatefulWidget {
  const onboding({super.key});

  @override
  State<onboding> createState() => _onbodingState();
}

class _onbodingState extends State<onboding> {

  // RiveAnimationController _btnAnimation=OneShotAnimation("active",autoplay: false);

  @override
  Widget build(BuildContext context) {
    print("buils");
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ///Blur Effext
            Positioned(
              bottom: 150,
              right: -100,
              child: SizedBox(
                height: 300,
                child: Image.asset(
                  "assets/Backgrounds/Spline.png"
                ),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30,sigmaY: 30),
                child: SizedBox(),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20,sigmaY: 20),
                child: SizedBox(),
              ),
            ),
             //Blur Effect complete

            //main sturcture starting
             Positioned.fill(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 25.0,vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: 30,),
                    SizedBox(
                      width:260,
                      child: Text(
                        "Learn solve & explore",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w700,
                          height: 1,
                          fontFamily: "Poppins"
                        ),
                      ),
                    ),
                     Text(
                       "Don’t skip design. Learn design and code, by building real apps with Flutter and Swift. Complete courses about the best tools.",
                     ),
                     Expanded(child: SizedBox()),
                     logIn_btn(),

                     SizedBox(height: 30,),
                     Text(
                         "Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates.")
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }



  Future<Object?> _Login_dailog(){
    return showGeneralDialog(

      transitionDuration:Duration(milliseconds: 500) ,
        transitionBuilder: (_, anim, __, child) {
          Tween<Offset> tween=Tween(begin: const Offset(0, -1), end: Offset.zero);

          return SlideTransition(
            position: tween.animate(
              CurvedAnimation(parent: anim, curve: Curves.easeInOut),
            ),
            child: child,
          );
        },

        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder:(context,_,__){
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 70),
              child: Container(
                padding: const EdgeInsets.all(20),
                 child:  LogIn_form(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
              ),
            ),
          );
        }
    );
  }


  // Widget signUp_form(){
  //
  //
  //   return  Scaffold(
  //
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: (){
  //         setState(() {
  //           signIn=!signIn;
  //         });
  //       },
  //     ),
  //
  //     body:  Center(
  //       child: Column(
  //         children: [
  //           const Text(
  //             "Sign Up",
  //             style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),
  //           ),
  //
  //         ],
  //       ),
  //     ),
  //   );
  // }


  Widget logIn_btn(){
    return  Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: (){
              // _btnAnimation.isActive=true;
                  Future.delayed(
                      Duration(milliseconds: 100),
                          (){
                        // StreamBuilder(
                        //   stream: FirebaseAuth.instance.authStateChanges(),
                        //   builder: (context,snapshot){
                        //     if(snapshot.connectionState==ConnectionState.waiting){
                        //       return Center(child: CircularProgressIndicator(),);
                        //     }
                        //     if(snapshot.hasData){
                        //       Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMain()));
                        //     }
                        //     _Login_dailog();
                        //     return Container();
                        //
                        //   },
                        // );
                            _Login_dailog();
                          }
                  );
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("Tap here"),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}




