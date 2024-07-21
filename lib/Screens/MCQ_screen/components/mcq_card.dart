import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Globs.dart';

class mcq_card extends StatefulWidget {
  String question;
  List op_list;
  int ans;
  PageController pageController=PageController();

   mcq_card(
      {
        required this.pageController,
        required this.question,
        required this.op_list,
        required this.ans,
        super.key
      }
      );

  @override
  State<mcq_card> createState() => _mcq_cardState();
}

class _mcq_cardState extends State<mcq_card> {

  @override

  String Genrated_Solution="";

  final gemini = GoogleGemini(
    apiKey: "AIzaSyCjwWn4bV3IHfIHW6TsEQp2a7K10n7rAN8",
  );

  Future<void> get_Solution({required String query}) async {
    
    setState(() {
      Genrated_Solution="Generating Solution....";
    });
    var value = await gemini.generateFromText(query);

    setState(() {
      Genrated_Solution = value.text;
    });
  }
  
  GlobalKey<FlipCardState> _cardKey=GlobalKey<FlipCardState>();

  bool isLiked=false;
  
  List<Color> _op_btn_colors = [Colors.deepPurple.shade100, Colors.deepPurple.shade100, Colors.deepPurple.shade100 , Colors.deepPurple.shade100,Colors.deepPurple.shade100];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FlipCard(
        key: _cardKey,
        flipOnTouch: false,
        front: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey, //color of shadow
                  spreadRadius: 2, //spread radius
                  blurRadius: 8, // blur radius
                  offset: Offset(4, 8),
                ),

              ]
          ),

          child: Column(
            children: [

              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(30)),
                      color: Colors.deepPurple[300],
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(10, 0),
                          color: Colors.deepPurple.shade300,
                        ),
                      ]
                  ),
                  child: Center(child:  Text(this.widget.question,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
              ),

              Expanded(
                  flex:2,
                  child: ListView.builder(
                      itemCount: this.widget.op_list.length,
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: (){
                            setState(() {
                              if(index==this.widget.ans){
                                _op_btn_colors[index]=Colors.green.shade300;
                                Provider.of<Globs>(context, listen: false).inc_no_questions();
                                this.widget.pageController.nextPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut
                                );

                              }else{
                                _op_btn_colors[index]=Colors.red.shade300;
                                _op_btn_colors[this.widget.ans]=Colors.green.shade100;
                                this.widget.pageController.nextPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut
                                );
                              }
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                            height: 60,
                            decoration: BoxDecoration(
                                color: _op_btn_colors[index],
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  this.widget.op_list[index],
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                  )
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 15.0,left: 30,right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: (){_cardKey.currentState?.toggleCard();}, icon: Icon(Icons.lightbulb_circle_outlined,color: Colors.yellow[600],size: 30,)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.comment_outlined,color: Colors.blue[300],size: 30,)),
                    IconButton(
                        onPressed: (){},
                        icon: isLiked?(Icon(Icons.favorite_border,color: Colors.red[300],size: 30,)):(Icon(Icons.favorite,color: Colors.red[300],size: 30,)),
                    ),
                  ],
                ),
              )


            ],
          ),
        ),

        back: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 0),
                  color: Colors.grey,
                  blurRadius: 1,
                ),
              ]
          ),
          child:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _appBar(),
                Flexible(
                    // child: Shimmer.fromColors(
                    //   baseColor: Colors.grey.shade200,
                    //   highlightColor: Colors.white,
                    //   child: ListView(
                    //     physics: NeverScrollableScrollPhysics(),
                    //     children: [
                    //       Expanded(child: SizedBox(height: 30,)),
                    //       Container(
                    //         height: 10,
                    //         decoration: BoxDecoration(
                    //             color: Colors.grey.shade100,
                    //             borderRadius: BorderRadius.circular(20)
                    //         ),
                    //       ),
                    //       SizedBox(height: 10,),
                    //       Row(
                    //         children: [
                    //           Container(
                    //             height: 10,
                    //             width: 40,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.grey.shade100,
                    //                 borderRadius: BorderRadius.circular(20)
                    //             ),
                    //           ),
                    //           SizedBox(width: 5,),
                    //           Container(
                    //             height: 10,
                    //             width: 100,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.grey.shade100,
                    //                 borderRadius: BorderRadius.circular(20)
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       SizedBox(height: 10,),
                    //       Container(
                    //         height: 10,
                    //         decoration: BoxDecoration(
                    //             color: Colors.grey.shade100,
                    //             borderRadius: BorderRadius.circular(20)
                    //         ),
                    //       ),
                    //       SizedBox(height: 10,),
                    //       Row(
                    //         children: [
                    //           Container(
                    //             height: 10,
                    //             width: 40,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.grey.shade100,
                    //                 borderRadius: BorderRadius.circular(20)
                    //             ),
                    //           ),
                    //           SizedBox(width: 5,),
                    //           Container(
                    //             height: 10,
                    //             width: 100,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.grey.shade100,
                    //                 borderRadius: BorderRadius.circular(20)
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       SizedBox(height: 10,),
                    //       Container(
                    //         height: 10,
                    //         decoration: BoxDecoration(
                    //             color: Colors.grey.shade100,
                    //             borderRadius: BorderRadius.circular(20)
                    //         ),
                    //       ),
                    //       SizedBox(height: 10,),
                    //       Row(
                    //         children: [
                    //           Container(
                    //             height: 10,
                    //             width: 150,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.grey.shade100,
                    //                 borderRadius: BorderRadius.circular(20)
                    //             ),
                    //           ),
                    //           SizedBox(width: 5,),
                    //           Container(
                    //             height: 10,
                    //             width: 100,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.grey.shade100,
                    //                 borderRadius: BorderRadius.circular(20)
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       SizedBox(height: 10,),
                    //       Container(
                    //         height: 10,
                    //         decoration: BoxDecoration(
                    //             color: Colors.grey.shade100,
                    //             borderRadius: BorderRadius.circular(20)
                    //         ),
                    //       ),
                    //       SizedBox(height: 10,),
                    //       Row(
                    //         children: [
                    //           Container(
                    //             height: 10,
                    //             width: 40,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.grey.shade100,
                    //                 borderRadius: BorderRadius.circular(20)
                    //             ),
                    //           ),
                    //           SizedBox(width: 5,),
                    //           Container(
                    //             height: 10,
                    //             width: 100,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.grey.shade100,
                    //                 borderRadius: BorderRadius.circular(20)
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       SizedBox(height: 10,),
                    //       Container(
                    //         height: 10,
                    //         decoration: BoxDecoration(
                    //             color: Colors.grey.shade100,
                    //             borderRadius: BorderRadius.circular(20)
                    //         ),
                    //       ),
                    //       SizedBox(height: 10,),
                    //       Row(
                    //         children: [
                    //           Container(
                    //             height: 10,
                    //             width: 40,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.grey.shade100,
                    //                 borderRadius: BorderRadius.circular(20)
                    //             ),
                    //           ),
                    //           SizedBox(width: 5,),
                    //           Container(
                    //             height: 10,
                    //             width: 100,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.grey.shade100,
                    //                 borderRadius: BorderRadius.circular(20)
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       SizedBox(height: 10,),
                    //       Container(
                    //         height: 10,
                    //         decoration: BoxDecoration(
                    //             color: Colors.grey.shade100,
                    //             borderRadius: BorderRadius.circular(20)
                    //         ),
                    //       ),
                    //       SizedBox(height: 10,),
                    //       Row(
                    //         children: [
                    //           Container(
                    //             height: 10,
                    //             width: 150,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.grey.shade100,
                    //                 borderRadius: BorderRadius.circular(20)
                    //             ),
                    //           ),
                    //           SizedBox(width: 5,),
                    //           Container(
                    //             height: 10,
                    //             width: 100,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.grey.shade100,
                    //                 borderRadius: BorderRadius.circular(20)
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       Expanded(child: SizedBox())
                    //
                    //     ],
                    //
                    //   )
                    // )
                  child: SingleChildScrollView(child: Center(child: Text(Genrated_Solution))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  
  Widget _Timepass(double _width){
    return Container(
      height: 10,
      width: _width,
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20)
      ),
    );
  }

  Widget _appBar(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: (){
          _cardKey.currentState?.toggleCard();
        }, icon:const Icon(Icons.repeat_rounded) ),
        const Text("Hint",
          style: TextStyle(
            fontSize: 20,
            // fontFamily: "Poppins"
          ),
        ),
        IconButton(
            onPressed: () async {
              String temp_query="${this.widget.question} \nSolve this and give step-by-step solution and reason behind that steps}";
              await get_Solution(
                  query: temp_query
              );
            },
            icon:const Icon(Icons.autorenew) ),
      ],
    );
  }
}
