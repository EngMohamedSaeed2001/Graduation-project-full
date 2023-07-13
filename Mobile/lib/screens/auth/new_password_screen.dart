import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semsark/components/button.dart';
import 'package:semsark/components/loading_screen.dart';
import 'package:semsark/provider/forget_password_provider.dart';
import 'package:semsark/screens/auth/password_verfication_code.dart';
import 'package:semsark/screens/home/home_screen.dart';
import 'package:semsark/utils/helper.dart';

import '../../provider/chat_provider.dart';
import '../../provider/create_ad_provider.dart';
import '../../provider/home_provider.dart';
import '../../provider/profile_provider.dart';


class NewPasswordScreen extends StatefulWidget {
  NewPasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final textFieldFocusNode = FocusNode();
  final textFieldFocusNode2 = FocusNode();
  final TextEditingController pass = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return;
      } // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;
      // Prevents focus if tap on eye
    });
  }

  GlobalKey<FormState> formKey = GlobalKey();
  String password = '';
  String confirmPassword = '';
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ForgetPasswordProvider>(context) ;
    return provider.loading ? LoadingScreen() : Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
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
                          ClipRRect(
                              child: ImageFiltered(
                            imageFilter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                            child: SizedBox(
                                height: 350,
                                width: double.infinity,
                                child: Image.asset(
                                  'assets/images/back.png',
                                  fit: BoxFit.fill,
                                )),
                          )),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "WELCOME",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 240, 242, 243),
                                    fontSize: 30),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "TO SEMSARK",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 240, 242, 243),
                                    fontSize: 30),
                              ),
                            ],
                          ),
                        ]),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Text("Reset your password",
                                  style: TextStyle(
                                      color: Helper.blue, fontSize: 23)),
                              const SizedBox(
                                height: 30,
                              ),
                              // PassordInputField(
                              //     onChanged: (data) {
                              //       password = data;
                              //     },
                              //     hintText: 'Password'),
                              TextFormField(
                                controller: pass,
                                onChanged: (data) {
                                  password = data;
                                },
                                validator: (data) {
                                  if (data!.isEmpty) {
                                    return "Field is required";
                                  }
                                  if (data.length < 7) {
                                    return "Password must be longer that seven numbers";
                                  }
                                },
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _obscured,
                                focusNode: textFieldFocusNode,
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
                                      onTap: _toggleObscured,
                                      child: Icon(
                                        _obscured
                                            ? Icons.visibility_off_rounded
                                            : Icons.visibility_rounded,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: confirmPass,
                                onChanged: (val) {
                                  confirmPassword = val;
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Empty';
                                  }
                                  if (val != pass.text) {
                                    return 'Password must match';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _obscured,
                                focusNode: textFieldFocusNode2,
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
                                      onTap: _toggleObscured,
                                      child: Icon(
                                        _obscured
                                            ? Icons.visibility_off_rounded
                                            : Icons.visibility_rounded,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButon(
                                text: 'Confirm',
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    try {
                                      // ForgetPassword().updatePassword(
                                      //     widget.email!, password, widget.OTP!);
                                      await provider.updatePassword(password);
                                      if(provider.success){
                                        await Provider.of<HomeProvider>(context , listen: false).init();
                                        await Provider.of<ProfileProvider>(context, listen: false).init();
                                        await Provider.of<ChatProvider>(context, listen: false).init();
                                        await Provider.of<CreateAdvertisementProvider>(context, listen: false).init();
                                        Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (builder) =>
                                        HomeScreen()
                                        )
                                        );
                                      }
                                    } catch (ex) {
                                      print(ex);
                                    }
                                  } else {}
                                },
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
    );
  }
}
