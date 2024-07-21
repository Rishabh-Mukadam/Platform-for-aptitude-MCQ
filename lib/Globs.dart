import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Globs extends ChangeNotifier{
    int overAll=0;
    int noQues=0 ;
    int monthly=0;
    int daily=0;

    FirebaseAuth auth=FirebaseAuth.instance;

    void updateFirestoreData() {
      // Perform Firestore update here
      FirebaseFirestore.instance
          .collection('Users')
          .doc(auth.currentUser!.email)
          .update({
        'ques_solved': noQues,
        'monthly_score': monthly,
        'overall_score': overAll,
      }).catchError((error) {
        print("Error updating Firestore data: $error");
      });
    }

    void inc_no_questions(){
       noQues++;
       overAll=overAll+4;
       monthly=monthly+4;
       daily++;
       updateFirestoreData();
       notifyListeners();
    }

}

