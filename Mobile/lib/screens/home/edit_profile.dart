import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
//import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:semsark/components/InputField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:semsark/components/button.dart';

import 'package:semsark/Repo/location_services.dart';
import 'package:semsark/provider/profile_provider.dart';
import 'package:semsark/screens/home/profile_screen.dart';
import '../../components/email_input.dart';
import '../../components/loading_screen.dart';
import '../../provider/sign_up_provider.dart';
import '../home/home_screen.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({
    Key? key,
  }) : super(key: key);

  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  var confirmPassword;

  final formKey = GlobalKey<FormState>();
  String initialCountry = 'EG';
  pickImage(ImageSource source, ProfileProvider provider) async {
    var image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      provider.setImage(image);
    }
  }

  //show popup dialog
  void myAlert(context, ProfileProvider provider) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 7,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () async {
                      Navigator.pop(context);
                      await pickImage(ImageSource.gallery, provider);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.image),
                        SizedBox(
                          width: 2,
                        ),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () async {
                      Navigator.pop(context);
                      await pickImage(ImageSource.camera, provider);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.camera),
                        SizedBox(
                          width: 2,
                        ),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
          ;
        });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProfileProvider>(context);
    PhoneNumber initialValue = PhoneNumber(isoCode: 'EG', phoneNumber: "");


    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            body: Form(
              // key: formKey,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          children: [
                            Stack(alignment: Alignment.center, children: <Widget>[
                              Column(
                                children: [
                                  ClipRRect(
                                      child: ImageFiltered(
                                    imageFilter:
                                        ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                                    child: SizedBox(
                                        height: 190,
                                        width: double.infinity,
                                        child: Image.asset(
                                          'assets/images/back.png',
                                          fit: BoxFit.fill,
                                        )),
                                  )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                              Positioned(
                                  top: 30,
                                  left: 0,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                      size: 33,
                                    ),
                                  )),
                              Positioned(
                                bottom: 0,
                                left: 20,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 5),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(80))
                                    ),

                                    child:provider.image!=null
                                  ?SizedBox(
                                      height: 120,
                                      width: 120,
                                    child: CircleAvatar(
                                      backgroundImage: FileImage(
                                                File(provider.image!.path),
                                              ),
                                    ),
                                  )
                                        : SizedBox(
                                            height: 120,
                                            width: 120,
                                            child: CircleAvatar(
                                                backgroundImage: provider.user.img==null ||
                                            provider.user.img=="string" ||
                                            provider.user.img==""?
                                                 null:NetworkImage(
                                                    provider.user.img!),
                                              foregroundImage: provider.user.img==null ||
                                                  provider.user.img=="string" ||
                                                  provider.user.img==""? AssetImage("assets/images/Mask.png"):null,

                                            ))

                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                left: 105,
                                child: GestureDetector(
                                  onTap: () {
                                    myAlert(context, provider);
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(80))),
                                      height: 30,
                                      child: Image.asset(
                                        'assets/images/CAM.png',
                                      )),
                                ),
                              ),
                            ]),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextFormField(
                                        controller: provider.usernameContoller,
                                        decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: Color(0xFFf1f6fb),
                                          label: Text("Full Name"),
                                          icon: Icon(Icons.person_outlined),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Field is required';
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InternationalPhoneNumberInput(
                                        maxLength: 12,
                                        hintText: "Mobile number",
                                        onInputChanged: (PhoneNumber number) {},
                                        onInputValidated: (bool value) {},
                                        inputDecoration: const InputDecoration(
                                            hintText: 'Mobile Number',
                                            filled: true,
                                            fillColor: Color(0xFFf1f6fb)),
                                        validator: _phoneValidator,
                                        selectorConfig: const SelectorConfig(
                                          selectorType:
                                              PhoneInputSelectorType.BOTTOM_SHEET,
                                        ),
                                        ignoreBlank: false,
                                        autoValidateMode: AutovalidateMode.disabled,
                                        selectorTextStyle:
                                            const TextStyle(color: Colors.black),
                                        initialValue: initialValue,
                                        textFieldController: provider.controller,
                                        formatInput: true,
                                        keyboardType:
                                            const TextInputType.numberWithOptions(
                                                signed: true, decimal: true),
                                        inputBorder: const OutlineInputBorder(),
                                        onSaved: (PhoneNumber number) {
                                          print('On Saved: $number');
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: const Color(0xFFF1F6FB),
                                              prefixIcon: provider.user.gender == "Female" ?
                                                  Icon(Icons.female_outlined):
                                              Icon(Icons.male),
                                              hintText: provider.user.gender??"Male",
                                              hintStyle: const TextStyle(color: Color(0xFF8189B0)),
                                              enabledBorder: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  )),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  ))),
                                          enabled: false
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  EmailInputField(
                                      hintText: provider.user.email,
                                      enabled: false),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomButon(
                                    text: "Edit",
                                    onTap: () async {
                                        //Position position = await _locationServices.getCurrentPosition(context);
                                      await provider.editProfile();
                                      if (provider.success){
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()));
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (provider.loading)  const LoadingScreen(),
    ],
      ),
    );
  }

  String? _phoneValidator(String? p1) {
    if (p1!.startsWith("1") || p1!.startsWith("0")) {
      return null;
    } else {
      return "invalid phone number";
    }
  }
}
