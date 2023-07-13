import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:semsark/components/loading_screen.dart';
import 'package:semsark/provider/create_ad_provider.dart';
import 'package:semsark/provider/profile_provider.dart';

import '../../utils/helper.dart';

class VerifyUserScreen extends StatelessWidget {
  VerifyUserScreen({super.key});

  @override
  Widget build(BuildContext context) => _ui(context);

  _ui(context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var provider = Provider.of<ProfileProvider>(context);

    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Helper.blue,
                    leading: IconButton(
                      icon :Icon(Icons.arrow_back) , color: Colors.white,
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    title: Text("Verification Screen" ,
                    style: TextStyle(
                      color: Colors.white,

                    ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        height: height * 0.3,
                        width: width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: provider.userImage == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Pick a photo for yourself',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  IconButton(
                                    icon: const Icon(Icons.camera_alt),
                                    color: Colors.black,
                                    iconSize: 80.0,
                                    onPressed: provider.takeUserPhoto,
                                  ),
                                ],
                              )
                            : Image.file(
                                File(provider.userImage!.path),
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        height: height * 0.3,
                        width: width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: provider.NidImage == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Pick a photo for your National ID',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  IconButton(
                                    icon: const Icon(Icons.camera_alt),
                                    color: Colors.black,
                                    iconSize: 80.0,
                                    onPressed: provider.takeNIdPhoto,
                                  ),
                                ],
                              )
                            : Image.file(
                                File(provider.NidImage!.path),
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: width * 0.89,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(100),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          await provider.verify();
                          if(provider.success){
                            Navigator.pop(context);
                            await provider.init();
                          }else if(provider.errorMsg !=""){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Row(
                                    children: [
                                      Icon(Icons.error, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('Error'),
                                    ],
                                  ),
                                  content: Text('${provider.errorMsg}'),
                                  actions: [
                                    TextButton(
                                      child: Text('Ok'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );

                          }
                        },
                        color: Helper.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Verify".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                ],
              ),
            ),
          ),
          if (provider.loading) const LoadingScreen(),
        ],
      ),
    );
  }
}
