import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:up_skill_1/Screens/MCQ_screen/mcq_screen.dart';

class Topic_list extends StatefulWidget {
  String Module_Name;
    Topic_list({required this.Module_Name,super.key});

  @override
  State<Topic_list> createState() => _Topic_listState();
}

class _Topic_listState extends State<Topic_list> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Modules').doc(this.widget.Module_Name).collection('Topic_list').snapshots(),
        builder: (context,snapsnot){
          if(!snapsnot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }

          final Topic_list=snapsnot.data!.docs;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                toolbarHeight: 5,
                expandedHeight: 260.0,
                backgroundColor: Colors.blue.shade200,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50))),
                centerTitle: true,
                flexibleSpace:   FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Positioned.fill(child: ClipRRect(child: Image.asset('assets/Backgrounds/img_2.png',fit: BoxFit.fill,colorBlendMode: BlendMode.modulate),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft:Radius.circular(50) ),)),

                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(icon: Icon(CupertinoIcons.back,color: Colors.white,size: 30,), onPressed: () {},),
                                  IconButton(icon: Icon(CupertinoIcons.line_horizontal_3_decrease,color: Colors.white,size: 30,), onPressed: () {},),
                                ],
                              ),
                              Expanded(child: SizedBox(),),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('Find your ', style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.white),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('topic here...!', style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.white),),
                              ),
                              SizedBox(height: 10,),
                              CupertinoSearchTextField(
                                backgroundColor: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                itemSize: 30,
                                prefixInsets: EdgeInsets.all(15),

                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Card(
                      margin: const EdgeInsets.only(left: 12,right: 12,top: 10),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>mcq_screen(module_name: this.widget.Module_Name,topic_name:Topic_list[index].id,)));
                        },
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(top: 12.0,left: 12),
                            child: Text(Topic_list[index].id,style: TextStyle(fontSize: 25),),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 15.0,right: 50),
                            child: Text('Number Series is a widely asked topic in the Logical Reasoning section of competitive examinations held in India. In these types of questions, there will be a series of numbers given, along with a blank to be filled out. You are given the task of finding out the answer to the blank by figuring out the pattern between the numbers, their predecessor and their successor',style: TextStyle(color: Colors.grey),),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: Topic_list.length, // 1000 list items
                ),
              ),

              SliverFillRemaining()

            ],
          );
        },
      ),
    );
  }


  Widget _userInfo(String _name,String _institude,String _email ){
    return Container(
      child :Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width:80,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),

          ),
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 10,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        height: 10,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );

  }
}
