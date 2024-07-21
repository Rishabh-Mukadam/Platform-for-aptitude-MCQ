import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:up_skill_1/Screens/Explore/Explore.dart';
import 'package:up_skill_1/Screens/MyMain.dart';
import 'package:up_skill_1/Screens/Profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:up_skill_1/main.dart';

import '../../../Globs.dart';


class LogIn_form extends StatefulWidget {
  const LogIn_form({super.key});
  @override
  State<LogIn_form> createState() => _LogIn_formState();
}

class _LogIn_formState extends State<LogIn_form> {

  TextEditingController reg_userName_controller=TextEditingController();
  TextEditingController reg_email_controller=TextEditingController();
  TextEditingController reg_password_controller=TextEditingController();
  TextEditingController reg_re_password_controller=TextEditingController();


  TextEditingController _email_controller=TextEditingController();
  TextEditingController _password_controller=TextEditingController();

  bool _isLoading=false;
  GlobalKey<FormState> _key=GlobalKey<FormState>();
  bool signIn=true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth auth=FirebaseAuth.instance;

  void setGlobals() {

    Globs _Globs=Provider.of<Globs>(context,listen: false);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        _Globs.noQues=documentSnapshot.get('ques_solved');
        _Globs.overAll=documentSnapshot.get('overall_score');
        _Globs.monthly=documentSnapshot.get('monthly_score');
        _Globs.daily=documentSnapshot.get('daily_score');

      } else {
        print('Document does not exist on the database');
      }
    }).catchError((error) {
      print('Error getting document: $error');
    });
  }



  Future<void> _registerWithEmailAndPassword() async {

    if (_key.currentState!.validate()) {
      try {
        final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: reg_email_controller.text.trim(),
          password: reg_re_password_controller.text.trim(),
        );
        FirebaseFirestore.instance.collection('Users').doc(reg_email_controller.text).set(
          {
            'user_name':reg_userName_controller.text,
            'email':reg_email_controller.text,
            'overall_score':0,
            'ques_solved':0,
            'daily_score':0,
            'monthly_score':0,
            'img':"https://firebasestorage.googleapis.com/v0/b/major-project-45dd9.appspot.com/o/img.png?alt=media&token=b58da7e0-794d-474f-ae72-eec709206fd1"
          }
        ).then((value){
          print('${reg_userName_controller.text} registered successfully');
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content: Text('${reg_userName_controller.text} registered successfully'),
          ));
          setGlobals();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMain()));
        });
        // Navigate to another screen upon successful registration
      } catch (e) {
        // Handle errors such as weak password, email already in use, etc.
        print("Failed to register with Email & Password: $e");
      }

    }

  }


  void _signInWithEmailAndPassword() async {
    if (_key.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: _email_controller.text.trim(),
          password: _password_controller.text.trim(),
        );
        setGlobals();
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMain()));
        // Navigate to another screen upon successful login
      } catch (e) {
        print("Failed to sign in with Email & Password: $e");
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text("Failed to sign in with Email & Password: $e"),
        ));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    print("Build");
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Center(
        child: signIn?_SignIn_widget():_SignUp_widget(),
      ),
    );
  }

  Widget _SignIn_widget(){
    return   Column(
      children: [
        const Flexible(fit: FlexFit.tight,child: const SizedBox()),
        Image.asset(
            "assets/Backgrounds/App_logo.JPG",
          height: 150,
          fit: BoxFit.cover
        ),
        const Flexible(fit: FlexFit.tight,child: const SizedBox()),
        const Text(
          "SignIn",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
            color: Color.fromRGBO(58, 58, 58, 100)
          ),
        ),
        const SizedBox(height: 10,),

        Form(
          key: _key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  controller: _email_controller,
                  decoration: InputDecoration(
                    label:const Text("Email"),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                  validator: MultiValidator(
                      [
                        RequiredValidator(errorText: "Required"),
                        EmailValidator(errorText: "Invalid"),
                      ]

                  ),
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  controller: _password_controller,
                  decoration: InputDecoration(
                      label:const Text("Password"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                  ),
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: "Required"),
                      MinLengthValidator(6, errorText: "Atleast 6 char required")
                    ]
                  ),

                ),
                const SizedBox(height: 15,),
                ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                  ),
                    onPressed: (){
                      _signInWithEmailAndPassword();
                    },
                    child: _isLoading?const Center(child: CircularProgressIndicator(color: Colors.white,),):const Text("LogIn"),
                ),
                const SizedBox(height: 7,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member?"),
                    TextButton(
                        onPressed: (){
                          setState(() {
                            signIn=false;
                          });
                        },
                        child: const Text("Register now")
                    )
                  ],
                ),
              ],
            )
        ),
        const Flexible(fit: FlexFit.tight,child: SizedBox()),
        const Row(
          children:  [
            Expanded(
              child: Divider(color: Colors.black45,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "OR",
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.black45,)),
          ],
        ),
        const Flexible(fit: FlexFit.tight,child: SizedBox()),
        const Center(child: Text("Sign up with Google, Apple or Email",style: TextStyle(color: Colors.black45),)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/Google.png",height: 25,fit: BoxFit.contain,),
            SizedBox(width: 10,),
            Icon(Icons.apple,size: 40,),
            SizedBox(width: 10,),
            Icon(Icons.sms,color: Colors.blue,size: 30,)

          ],
        ),
        const Flexible(fit: FlexFit.tight,child: SizedBox()),

      ],
    );
  }

  Widget _SignUp_widget(){
    return Column(
      children: [
        const Flexible(fit: FlexFit.tight,child: const SizedBox()),
        Image.asset(
            "assets/Backgrounds/App_logo.JPG",
            height: 100,
            fit: BoxFit.cover
        ),
        const Flexible(fit: FlexFit.tight,child: const SizedBox()),
        const Text(
          "Sign Up",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              fontFamily: "Poppins",
              color: Color.fromRGBO(58, 58, 58, 100)
          ),
        ),
        const SizedBox(height: 10,),

        Form(
            key: _key,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  controller: reg_userName_controller,
                  decoration: InputDecoration(
                    label:const Text("User's full Name"),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                  validator: MultiValidator(
                      [
                        RequiredValidator(errorText: "Required"),
                      ]

                  ),
                ),

                const SizedBox(height: 15,),

                TextFormField(
                  controller: reg_email_controller,
                  decoration: InputDecoration(
                    label:const Text("Email"),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                  validator: MultiValidator(
                      [
                        RequiredValidator(errorText: "Required"),
                        EmailValidator(errorText: "Invalid"),
                      ]

                  ),
                ),

                const SizedBox(height: 15,),
                TextFormField(
                  controller: reg_password_controller,
                  decoration: InputDecoration(
                    label:const Text("Password"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                  validator: MultiValidator(
                      [
                        RequiredValidator(errorText: "Required"),
                        MinLengthValidator(6, errorText: "Atleast 6 char required")
                      ]
                  ),

                ),

                const SizedBox(height: 15,),
                TextFormField(
                  controller: reg_re_password_controller,
                  decoration: InputDecoration(
                    label:const Text("Retype_Password"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                  validator: MultiValidator(
                      [
                        RequiredValidator(errorText: "Required"),
                        MinLengthValidator(6, errorText: "Atleast 6 char required")
                      ]
                  ),

                ),

                const SizedBox(height: 15,),
                ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                  ),
                  onPressed: (){
                    _registerWithEmailAndPassword();
                  },
                  child: _isLoading?const Center(child: CircularProgressIndicator(color: Colors.white,),):const Text("LogIn"),
                ),
                const SizedBox(height: 7,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Have you Registered?"),
                    TextButton(
                        onPressed: (){
                          setState(() {
                            signIn=true;
                          });
                        },
                        child: const Text("Register")
                    )
                  ],
                ),
              ],
            )
        ),
        const Flexible(fit: FlexFit.tight,child: SizedBox()),
        const Row(
          children:  [
            Expanded(
              child: Divider(color: Colors.black45,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "OR",
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.black45,)),
          ],
        ),
        const Flexible(fit: FlexFit.tight,child: SizedBox()),
        const Center(child: Text("Sign up with Google, Apple or Email",style: TextStyle(color: Colors.black45),)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/Google.png",height: 25,fit: BoxFit.contain,),
            SizedBox(width: 10,),
            Icon(Icons.apple,size: 40,),
            SizedBox(width: 10,),
            Icon(Icons.sms,color: Colors.blue,size: 30,)

          ],
        ),
        const Flexible(fit: FlexFit.tight,child: SizedBox()),

      ],
    );
  }

}
