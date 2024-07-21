import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:up_skill_1/Screens/Explore/Explore.dart';
import 'package:up_skill_1/Screens/MyMain.dart';
import 'package:up_skill_1/Screens/onboding/components/LogIn_form.dart';


class onboding_without_logIn extends StatefulWidget {
  const onboding_without_logIn({super.key});

  @override
  State<onboding_without_logIn> createState() => _onboding_without_logInState();
}

class _onboding_without_logInState extends State<onboding_without_logIn> {
  @override
  Widget build(BuildContext context) {
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
                        "Learn solve & code",
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

  Widget logIn_btn(){
    return  Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMain()));
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
