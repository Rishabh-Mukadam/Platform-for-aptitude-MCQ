
import 'dart:ui';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:provider/provider.dart';
import 'package:up_skill_1/Screens/Explore/Explore.dart';
import 'package:up_skill_1/Screens/MCQ_screen/components/mcq_card.dart';
import 'package:up_skill_1/Screens/MyMain.dart';

import '../../Globs.dart';


class mcq_screen extends StatefulWidget {

   String module_name;
   String topic_name;
   mcq_screen({required this.module_name,required this.topic_name,super.key});

  PageController _pageController=PageController();
  CountDownController _countDownController=CountDownController();

  @override
  State<mcq_screen> createState() => _mcq_screenState();
}

class _mcq_screenState extends State<mcq_screen> {

  int _point=4;



  @override
  Widget build(BuildContext context) {
    print("MCQ_Screen Build");
    return  WillPopScope(
      onWillPop:() async {
        // Show an alert dialog when back button is pressed
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm Exit'),
              content: Text('Are you sure you want to Stop?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Close the dialog and allow back navigation
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyMain())); // Close the dialog and block back navigation
                  },
                  child: Text('Yes'),
                ),
              ],
            );
          },
        );
        return false; // Block back navigation until the dialog is dismissed
      },

      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("MCQ").where("mod", isEqualTo: this.widget.module_name).where("topic", isEqualTo: this.widget.topic_name).snapshots(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }
      
            final documents=snapshot.data!.docs;
      
            return Stack(
              children: [
                //Working Widget
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //AppBar
                        SizedBox(height: 30,),
                        _appBar(),
                        Expanded(
                          child: PageView.builder(
                            controller: this.widget._pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: documents.length,
                            itemBuilder: (BuildContext context, int index) {
                              final data=documents[index].data();
                              print('Rishabh');
                              print(data['ques']);
                              print(data['ans']);
                              print(data['op2']);
                              return  mcq_card(
                                question: data['ques'],
                                op_list: [data['op1'],data['op2'],data['op3'],data['op4']],
                                ans: int.parse(data['ans'])-1,
                                 pageController: this.widget._pageController,
                                 //question: mcq_data['ques'],
                                // op_list: [mcq_data['op1'],mcq_data['op2'],mcq_data['op3'],mcq_data['op4']],
                                 //ans: mcq_data['ans']
                              );
                            },
      
                          ),
                        ),
                        _bottomBtns()
      
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
  /////////////////////////////////////////////////////////////////////////////



  Widget _countD(){
    return CircularCountDownTimer(
      width: 30, height: 30, duration: 30,isReverse: true, fillColor: Colors.deepPurple, ringColor: Colors.white,strokeWidth: 3,strokeCap: StrokeCap.round,controller: this.widget._countDownController,
      onComplete: (){
        setState(() {
          _point-=2;
        });
      },
    );
  }

  Widget _appBar(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: (){}, icon:const Icon(Icons.arrow_back_ios_rounded) ),
         Row(
          children: [
            _countD(),
             SizedBox(width: 10,),
             Text(_point.toString()+" Points",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                // fontFamily: "Poppins"
              ),
            ),
          ],
        ),
        IconButton(onPressed: (){}, icon:const Icon(Icons.menu_rounded) ),
      ],
    );
  }

  Widget _bottomBtns(){
    return Padding(
      padding: const EdgeInsets.only(right: 30,left: 30,top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Expanded(
          //   child: ElevatedButton(
          //     onPressed: (){
          //       this.widget._pageController.previousPage(
          //           duration: const Duration(milliseconds: 300),
          //           curve: Curves.easeOut
          //       );
          //       this.widget._countDownController.restart();
          //       _point=4;
          //     },
          //     style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.deepPurple[300]
          //     ),
          //     child: const SizedBox(
          //         height: 50,
          //         child: Icon(Icons.arrow_back,color: Colors.white,)
          //     ),
          //   ),
          // ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: (){
                  showModalBottomSheet(

                    useSafeArea: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10))
                    ),
                      context: context,
                      builder: (context){
                        return const Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: SimpleCalculator(
                            hideSurroundingBorder: true,
                            theme: CalculatorThemeData(
                              operatorColor: Colors.deepPurple
                            ),
                          ),
                        );
                      }
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple[300]
                ),
                child: const SizedBox(
                    height: 50,
                    child: Icon(Icons.calculate,color: Colors.white,)
                ),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: (){
               setState(() {
                 this.widget._pageController.nextPage(
                     duration: const Duration(milliseconds: 300),
                     curve: Curves.easeInOut
                 );
                 this.widget._countDownController.restart();
                 _point=4;

               });

              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[300]
              ),
              child: const SizedBox(
                  height: 50,
                  child: Icon(Icons.arrow_forward,color: Colors.white,)
              ),
            ),
          )
        ],
      ),
    );
  }
}
