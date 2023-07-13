import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

// import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:semsark/components/button.dart';
import 'package:semsark/screens/auth/personal_info_screen.dart';

import '../../provider/sign_up_provider.dart';


class PinCodeVerificationScreen extends StatelessWidget {
  String? email;

  PinCodeVerificationScreen({
    Key? key,
    this.email,
  }) : super(key: key);


  TextEditingController textEditingController = TextEditingController();

  // ..text = "123456";
  String? OTP;

  bool hasError = false;

  String currentText = "";

  final formKey = GlobalKey<FormState>();

  double width=0;

  // snackBar Widget
  // snackBar(String? message) {
  //   return ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message!),
  //       duration: const Duration(seconds: 2),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SignUpProvider>(context) ;

    width= MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: GestureDetector(
          onTap: () {},
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[
                Stack(alignment: Alignment.center, children: <Widget>[
                  Column(
                    children: [
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(150),
                              bottomRight: Radius.circular(150)),
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                            child: SizedBox(
                                height: 200,
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
                      height: 120,
                      child: Image.asset(
                        'assets/images/emailIcon.png',
                        height: 120,
                      )),
                ]),
                Column(children: const [
                  Text("Verification",
                      style: TextStyle(color: Color(0xFF7f88b3), fontSize: 30)),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Enter the six digit code we sent to your",
                    style: TextStyle(color: Color(0xFF7f88b3), fontSize: 17),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "email address to verify your new account:",
                    style: TextStyle(color: Color(0xFF7f88b3), fontSize: 17),
                  ),
                ]),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 30),
                          child:
                          PinCodeTextField(
                            autoDismissKeyboard: true,
                            backgroundColor: Colors.white,
                            appContext: context,
                            pastedTextStyle: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 6,
                            obscureText: true,
                            obscuringCharacter: '*',
                            obscuringWidget: Image.asset('assets/images/logo.png'),
                            blinkWhenObscuring: true,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Field is required";
                              }
                              if (v.length < 6) {
                                return "Enter full code";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 0.1*width,
                              activeFillColor: Colors.white,
                              inactiveColor: Colors.blueGrey,
                              inactiveFillColor: Colors.white
                            ),

                            cursorColor: Colors.black,
                            animationDuration: const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            //errorAnimationController: errorController,
                            controller: textEditingController,
                            keyboardType: TextInputType.number,
                            boxShadows: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],

                            onChanged: (value) {
                              provider.setOtp( value.toString());
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          )
                      ),
                    ),
                  ],
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Flexible(
                //       child: Text("Didn't receive the code? ",
                //           style: TextStyle(
                //             color: Color(0xFF7f88b3),
                //             fontSize: 17,
                //           )),
                //     ),
                //     Flexible(
                //       child: TextButton(
                //         onPressed:()=> provider.sendOtp(),
                //         child: const Text(
                //           "RESEND",
                //           style: TextStyle(
                //               color: Color(0xFFe87476),
                //               fontSize: 17,
                //               decoration: TextDecoration.underline),
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                      child: Text(
                        "Didn't receive the code? ",
                        style: TextStyle(
                          color: Color(0xFF7f88b3),
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Flexible(
                      child: provider.showTimer?Text(
                        '${provider.timerDuration} seconds',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                        ),
                      ): TextButton(
                        onPressed: () {
                          provider.sendOtp();
                          provider.startTimer();
                        },
                        child:
                            const Text(
                          "RESEND",
                          style: TextStyle(
                            color: Color(0xFFe87476),
                            fontSize: 17,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: TextButton(
                    child: const Text("Clear"),
                    onPressed: () {
                      textEditingController.clear();
                    },
                  )),
                ],
              ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomButon(
                    text: 'Verify',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await provider.verifyOtp();
                        if (provider.success) {
                          provider.setEdit();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PersonalInfoScreen();
                              },
                            ),
                          );
                        }
                        else{
                          ()=> print("Wrong OTP");
                        }
                      } else {}
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
