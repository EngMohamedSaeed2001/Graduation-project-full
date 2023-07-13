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
import '../../provider/create_ad_provider.dart';
import '../../provider/home_provider.dart';
import '../../provider/sign_up_provider.dart';
import '../home/home_screen.dart';

class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({
    Key? key,
  }) : super(key: key);

  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  var confirmPassword;

  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameContoller = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController drop = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();
  String initialCountry = 'EG';
  final TextEditingController controller = TextEditingController();
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media, context) async {
    var img = await picker.pickImage(source: media);
    return img;
  }

  //show popup dialog
  void myAlert(context, SignUpProvider provider) {
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
                      provider.setImage(
                          await getImage(ImageSource.gallery, context));
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
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () async {
                      Navigator.pop(context);
                      provider.setImage(
                          await getImage(ImageSource.camera, context));
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
    var signupProvider = Provider.of<SignUpProvider>(context);
    PhoneNumber initialValue = PhoneNumber(isoCode: 'EG', phoneNumber: "");


    return SafeArea(
      child: Scaffold(
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
                            bottom: 0,
                            left: 20,
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(80))),
                                child: signupProvider.image == null
                                    ? Image.asset(
                                        'assets/images/Mask.png',
                                        height: 120,
                                      )
                                    : SizedBox(
                                        height: 120,
                                        width: 120,
                                        child: CircleAvatar(
                                            backgroundImage: FileImage(File(
                                                signupProvider
                                                    .image!.path!))))),
                          ),
                          Positioned(
                            bottom: 5,
                            left: 105,
                            child: GestureDetector(
                              onTap: () {
                                myAlert(context, signupProvider);
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
                                    onChanged: (data) {
                                      signupProvider.setName(usernameContoller.text);
                                    },
                                    controller: usernameContoller,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFf1f6fb),
                                      label: Text("Full Name"),
                                      icon: Icon(Icons.person_outlined),
                                    ),
                                    validator: (value) {
                                      if ((value == null || value.isEmpty) ) {
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
                                    onInputChanged: (PhoneNumber number) {
                                      signupProvider.setPhoneNumber(
                                          number.phoneNumber);
                                    },
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
                                    textFieldController: controller,
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
                                  DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xFFF1F6FB),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            'assets/images/gender.png',
                                            height: 5,
                                            width: 5,
                                          ),
                                        ),
                                        hintStyle: const TextStyle(
                                            color: Color(0xFF8189B0)),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Colors.white,
                                        )),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Colors.white,
                                        ))),
                                    //isExpanded: true,
                                    hint: const Text(
                                         'Gender',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 30,
                                    items: genderItems
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Field is required';
                                      }
                                    },
                                    onChanged: (value) {
                                       signupProvider
                                          .setGender(value.toString());

                                      //Do something when changing the item if you want.
                                    },
                                    onSaved: (value) {
                                       signupProvider
                                              .setGender(value.toString());
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              EmailInputField(
                                  hintText: signupProvider.email,
                                  enabled: false),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: pass,
                                onChanged: (data) {
                                   signupProvider
                                          .setPassword(data.toString());
                                  // signUp_provider.setPassword(data.toString());
                                },
                                validator: (data) {
                                  if (data!.isEmpty ) {
                                    return "Field is required";
                                  }
                                  if (data.length < 7 && data.length > 0) {
                                    return "Password must be longer that seven numbers";
                                  }
                                },
                                //onTap: ,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: signupProvider.showPassword,
                                //focusNode: ,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFF1F6FB),
                                  prefixIcon: const Icon(Icons.lock_outlined),
                                  hintText: "Password",
                                  hintStyle:
                                      const TextStyle(color: Color(0xFF8189B0)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                                  suffixIcon: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                    child: GestureDetector(
                                      //onTap:signupProvider.edit ?userProvider.setShowPassword() :signupProvider.setShowPassword(),
                                      child: Icon(
                                        ( signupProvider.showPassword)
                                            ? Icons.visibility_off_rounded
                                            : Icons.visibility_rounded,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: confirmPass,
                                onChanged: (val) {
                                  confirmPassword = val;
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Field is required';
                                  }
                                  if (val != pass.text) {
                                    return 'Password must match';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.visiblePassword,
                                obscureText:  signupProvider.showPassword,
                                //focusNode: textFieldFocusNode2,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFF1F6FB),
                                  prefixIcon: const Icon(Icons.lock_outlined),
                                  hintText: "Confirm password",
                                  hintStyle:
                                      const TextStyle(color: Color(0xFF8189B0)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                                  suffixIcon: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                    child: GestureDetector(
                                      // onTap:signupProvider.edit?userProvider.setShowPassword() :signupProvider.setShowPassword(),
                                      child: Icon(
                                        ( signupProvider.showPassword)
                                            ? Icons.visibility_off_rounded
                                            : Icons.visibility_rounded,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButon(
                                text: "Sign Up",
                                onTap: () async {
                                  if (await signupProvider.createUser()) {
                                    await Provider.of<HomeProvider>(
                                        context, listen: false).init();
                                    await Provider.of<ProfileProvider>(
                                        context, listen: false).init();
                                    //await Provider.of<ChatProvider>(context, listen: false).init();
                                    await Provider.of<
                                        CreateAdvertisementProvider>(
                                        context, listen: false).init();
                                    //Position position = await _locationServices.getCurrentPosition(context);
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
                               Column(
                                      children: [
                                        const Text("or",
                                            style: TextStyle(
                                                color: Color(0xFF45A6DD),
                                                fontSize: 20)),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // const FaIcon(FontAwesomeIcons.google),
                                            Container(
                                              width: 39,
                                              height: 39,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFF707070),
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: const Icon(
                                                Icons.facebook,
                                                size: 37,
                                                color: Color(0xFF3B5998),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 0,
                                              width: 5,
                                            ),
                                            Container(
                                              width: 39,
                                              height: 39,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFF707070),
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Center(
                                                    child: Image.asset(
                                                        'assets/images/googleIcon.png')),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              if(signupProvider.loading)const LoadingScreen() ,
            ],
          ),
        ),

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
