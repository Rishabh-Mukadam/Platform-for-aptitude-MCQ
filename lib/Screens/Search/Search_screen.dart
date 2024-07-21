import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:up_skill_1/Screens/Profile/others_profile.dart';

class Search_screen extends StatefulWidget {
  const Search_screen({super.key});

  @override
  State<Search_screen> createState() => _Search_screenState();
}

class _Search_screenState extends State<Search_screen> {

  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            CupertinoSearchTextField(
              onChanged: (value){
                _searchText = value.toLowerCase();
                setState(() {

                });
              },
            ),
            SizedBox(height: 10,),
            Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Users').snapshots(),
                  builder: (context,snapnot){
                    if(!snapnot.hasData){
                      return Center(child: CircularProgressIndicator(),);
                    }

                    // final documents=snapnot.data!.docs;
                    final documents = snapnot.data!.docs.where((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      final userName = data['user_name'].toString().toLowerCase();
                      // Add additional fields to search if needed

                      // Return true if any field contains the search text
                      return userName.contains(_searchText);

                    }).toList();

                    return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context,index){
                          final data=documents[index].data();
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>others_profile(email: data['email'])));
                              },
                                child: _userInfo(data['user_name'], "terna college of engineering", data['email'],data['img'])),
                          );
                        }
                    );
                  },
                )
            )
          ],
        ),
      ),
    );
  }



  // Widget _userInfo(String _name,String _institude,String _email ){
  //   return Container(
  //     child :Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Container(
  //           width:80,
  //           height: 80,
  //           decoration: BoxDecoration(
  //             color: Colors.grey.shade300,
  //             borderRadius: BorderRadius.all(Radius.circular(20))
  //           ),
  //
  //         ),
  //         SizedBox(
  //           height: 80,
  //           child: Padding(
  //             padding: const EdgeInsets.all(15.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 Container(
  //                   height: 10,
  //                   width: 200,
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey.shade100,
  //                     borderRadius: BorderRadius.circular(20)
  //                   ),
  //                 ),
  //                 SizedBox(height: 10,),
  //                 Container(
  //                   height: 10,
  //                   width: 100,
  //                   decoration: BoxDecoration(
  //                       color: Colors.grey.shade100,
  //                       borderRadius: BorderRadius.circular(20)
  //                   ),
  //                 ),
  //                 SizedBox(height: 10,),
  //                 Row(
  //                   children: [
  //                     Container(
  //                       height: 10,
  //                       width: 40,
  //                       decoration: BoxDecoration(
  //                           color: Colors.grey.shade100,
  //                           borderRadius: BorderRadius.circular(20)
  //                       ),
  //                     ),
  //                     SizedBox(width: 5,),
  //                     Container(
  //                       height: 10,
  //                       width: 100,
  //                       decoration: BoxDecoration(
  //                           color: Colors.grey.shade100,
  //                           borderRadius: BorderRadius.circular(20)
  //                       ),
  //                     ),
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  //
  //
  //
  // }



  Widget _userInfo(String _name,String _institude,String _email,String img){
    return _emptyBox(
      Row(
        children: [
          const Flexible(child:  SizedBox(width: 10,),fit: FlexFit.loose,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                img
              ),
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

}
