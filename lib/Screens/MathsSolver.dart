
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class Math_solver extends StatefulWidget {
  const Math_solver({super.key});

  @override
  State<Math_solver> createState() => _Math_solverState();
}

class _Math_solverState extends State<Math_solver> {


  //File? _image;
  File? imageFile;
  String Genrated_Solution="";
  TextEditingController Add_discription_TF=TextEditingController();


  final gemini = GoogleGemini(
    apiKey: "AIzaSyCjwWn4bV3IHfIHW6TsEQp2a7K10n7rAN8",
  );

  void clear_screen(){
    setState(() {
      imageFile=null;
      Genrated_Solution="";
    });
  }

  // Text only input
  Future<void> get_Solution({required String query, required File image}) async {

    setState(() {
      Genrated_Solution="Generating Solution....";
    });
    var value = await gemini.generateFromTextAndImages(
        query: query,
        image: image
    );

    setState(() {
      Genrated_Solution = value.text;
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() async {
      if (pickedFile != null) {

        final croppedImage=await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
            WebUiSettings(
              context: context,
            ),
          ],
        );

        imageFile=croppedImage !=null?File(croppedImage.path):null;
        setState(() {
          print("build");
        });
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() async {
      if (pickedFile != null) {

        final croppedImage=await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
            WebUiSettings(
              context: context,
            ),
          ],
        );

        imageFile=croppedImage !=null?File(croppedImage.path):null;
        setState(() {
          print("build");
        });
      } else {
        print('No image selected.');
      }
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("SolApt",style: TextStyle(color: Colors.red),),
            Text(".Get Solution",style: TextStyle(color: Colors.grey.shade700),),
          ],
        ),
        centerTitle: true,
        toolbarHeight: 70,
        elevation:5,
        automaticallyImplyLeading: false,
      ),
      body:Expanded(
        flex: 2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                // height: 250,
                child: imageFile == null
                    ? Center(child: Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Text('No image selected.'),
                    ))
                    : Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.file(imageFile!,fit: BoxFit.fitWidth,),
                          SizedBox(height: 10,),
                          CupertinoSearchTextField(
                            controller: Add_discription_TF,
                            placeholder: "Add discription here",
                            prefixIcon: Icon(Icons.edit_note_outlined),

                          )
                        ],
                      ),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              child: Divider(),
            ),
            Expanded(
              flex: 2,
                child: SingleChildScrollView(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(Genrated_Solution),
            )))
          ],
        ),
      ),

      floatingActionButton: floating_btn(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: ()async{
      //     if(imageFile==null){
      //       getImageFromCamera();
      //     }else{
      //       File temp_image=imageFile!;
      //      await get_Solution(query: "Solve this maths problem and give step-by-step solution and reason behind that steps", image: temp_image);
      //     }
      //   },
      //   tooltip: "Pick Image",
      //   child: floating_btn_icon,
      // ),
    );
  }

  Widget floating_btn(){
    if(imageFile==null){
      return SpeedDial(
          icon: Icons.document_scanner_outlined,
          backgroundColor: Colors.purple.shade200,
          children: [
            SpeedDialChild(
              child: const Icon(CupertinoIcons.camera),
              label: 'Get image from camera',
              backgroundColor: Colors.purple.shade100,
              onTap: ()   {
                getImageFromCamera();
              },
            ),
            SpeedDialChild(
              child: const Icon(CupertinoIcons.photo),
              label: 'Get image from gallery',
              backgroundColor: Colors.purple.shade100,
              onTap: () {getImageFromGallery();},
            ),

          ]);
    }else{
      return SpeedDial(
          icon: Icons.play_arrow,
          backgroundColor: Colors.purple.shade200,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.repeat),
              label: 'Generate Solution',
              backgroundColor: Colors.purple.shade100,
              onTap: () async {
                File temp_image=imageFile!;
                String temp_query="${Add_discription_TF.text} \nSolve this and give step-by-step solution and reason behind that steps}";
                await get_Solution(query:temp_query, image: temp_image);
                print(temp_query);
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.generating_tokens),
              label: 'New problem',
              backgroundColor: Colors.purple.shade100,
              onTap: () {
                clear_screen();
              },
            ),

          ]);
    }
  }

}
