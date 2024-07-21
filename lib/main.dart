import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:up_skill_1/Globs.dart';
import 'package:up_skill_1/Screens/Explore/Explore.dart';
import 'package:up_skill_1/Screens/Explore/Explore_components/Topic_list.dart';
import 'package:up_skill_1/Screens/MyMain.dart';
import 'package:up_skill_1/Screens/onboding/onboding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:up_skill_1/Screens/onboding/onboding_without_logIn.dart';
import 'package:up_skill_1/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Globs()),],
     child: MyApp()
    )
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth=FirebaseAuth.instance;

    return SafeArea(
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: StreamBuilder(
        //     stream: auth.authStateChanges(),
        //     builder:(context,snapshot){
        //       if(snapshot.hasData){
        //         print(snapshot.data!.email);
        //         return onboding_without_logIn();
        //       }
        //       else{
        //         return onboding();
        //       }
        //     }
        // ),
       // home: onboding(),
        home: onboding(),
      ),
    );
  }
}















//
// class MyHome extends StatefulWidget {
//   const MyHome({super.key});
//
//   @override
//   State<MyHome> createState() => _MyHomeState();
// }
//
// class _MyHomeState extends State<MyHome> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purple.shade300,
//         title: const Text("FireBase Testing App"),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('MCQ').doc('Arithmatic').collection('percentage').snapshots(),
//         builder: (context,snapshot){
//           if(!snapshot.hasData){
//             return Center(child: CircularProgressIndicator());
//           }
//
//           return ListView(
//               children: snapshot.data!.docs.map((documents) {
//                 return Center(
//                   child: Container(
//                     child: Text(documents['ques']),
//                   ),
//                 );
//               }).toList()
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           FirebaseFirestore.instance.collection('MCQ').doc('Arithmatic').collection('percentage')
//               .add(
//               {
//                 'ques':'what is your name',
//                 'op1':'rina',
//                 'op2':'sonali',
//                 'op3':'Sanskruti',
//                 'op4':'kaushal',
//               }
//           );//add
//         },
//       ),
//     );
//   }
// }
//
//
