import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:up_skill_1/Screens/Explore/Explore_components/Topic_list.dart';

class Modules_tab extends StatefulWidget {
  const Modules_tab({super.key});

  @override
  State<Modules_tab> createState() => _Modules_tabState();
}

class _Modules_tabState extends State<Modules_tab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Modules').snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          final Module_list=snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: MasonryGridView.builder(
                gridDelegate:  SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2
                ),
                itemCount: Module_list.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(right: 15.0,top: 15),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Topic_list(Module_Name: Module_list[index].id)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey, //color of shadow
                            //     spreadRadius: 0.02, //spread radius
                            //     blurRadius: 5,
                            //     offset: Offset(2,2),
                            //   )
                            // ]
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(child: Image.asset('assets/Backgrounds/img_${index%8+1}.png',fit: BoxFit.cover, color: Colors.white.withOpacity(0.9),colorBlendMode: BlendMode.modulate),borderRadius: BorderRadius.circular(12),),
                            Positioned.fill(child: Center(child: Text(Module_list[index].id,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900,color: Colors.white,fontStyle: FontStyle.italic),)),)
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          );

        },
      )
    );
  }
}
