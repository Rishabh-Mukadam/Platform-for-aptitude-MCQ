
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Profile_edit extends StatefulWidget {
  const Profile_edit({super.key});

  @override
  State<Profile_edit> createState() => _Profile_editState();
}

class _Profile_editState extends State<Profile_edit> {

  File? imageFile;
  String _imageUrl="";

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

  // Future<void> _uploadImage() async {
  //   final imageBytes = await imageFile?.readAsBytes();
  //
  //   if (imageBytes != null) {
  //     final uploadTask = firebase_storage.FirebaseStorage.instance
  //         .ref('images/${DateTime.now()}.jpg')
  //         .putData(imageBytes);
  //
  //     final snapshot = await uploadTask.whenComplete(() {});
  //     final downloadUrl = await snapshot.ref.getDownloadURL();
  //     print(downloadUrl);
  //     setState(() {
  //       _imageUrl = downloadUrl;
  //     });
  //   } else {
  //     print('Error: Image file is null.');
  //   }
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Text('Upload profile photo here '),
          Container(
            height: 50,
            child: Row(
              children: [
                Expanded(child: TextButton(onPressed: (){getImageFromCamera();},child: Text('camera'),)),
                Expanded(child: TextButton(onPressed: (){getImageFromGallery();},child: Text('gallery'),))
              ],
            ),
          ),

          Center(
            child: imageFile == null
                ? Text('No image selected.')
                : Column(
              children: [
                Image.file(imageFile!,height: 400,fit: BoxFit.cover,),
                ElevatedButton(onPressed: () async {
                  var imageName = DateTime.now().millisecondsSinceEpoch.toString();
                  var storageRef = FirebaseStorage.instance.ref().child('driver_images/$imageName.jpg');
                  var uploadTask = await storageRef.putFile(imageFile!).then((p0) => print("uploaded"));
                  }, child: Text("Upload Image"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
