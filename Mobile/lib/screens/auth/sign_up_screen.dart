import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semsark/components/button.dart';
import 'package:semsark/components/email_input.dart';
import 'package:semsark/screens/auth/pin_code_verification_screen.dart';
import 'package:semsark/screens/auth/sign_in_screen.dart';

import '../../provider/sign_up_provider.dart';


class SignUpScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  double width = 0;
  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SignUpProvider>(context) ;

    return Scaffold(
      body: Form(
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
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(150),
                                bottomRight: Radius.circular(150)),
                            child: ImageFiltered(
                              imageFilter:
                                  ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                              child: SizedBox(
                                  height: 320,
                                  width: double.infinity,
                                  child: Image.asset(
                                    'assets/images/back.png',
                                    fit: BoxFit.fill,
                                  )),
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                            const Text("Enter Your Email",
                                style: TextStyle(
                                    color: Color(0xFF45A6DD), fontSize: 23)),
                            const SizedBox(
                              height: 30,
                            ),
                            EmailInputField(
                                onChanged: (data) {
                                  provider.setEmail(data.toString());
                                },
                                hintText: 'Email ',
                                enabled: true),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomButon(
                              text: 'NEXT',
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  try {
                                    await provider.verifyEmail();
                                    if (provider.success) {
                                      confirmationDialog(context);
                                    }
                                  } catch (ex) {
                                    print(ex);
                                  }
                                } else {}
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("or",
                                style: TextStyle(
                                    color: Color(0xFF45A6DD), fontSize: 20)),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const FaIcon(FontAwesomeIcons.google),
                                Container(
                                  width: 39,
                                  height: 39,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFF707070),
                                      ),
                                      borderRadius: const BorderRadius.all(
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
                                        color: const Color(0xFF707070),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                        child: Image.asset(
                                            'assets/images/googleIcon.png')),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Future<String?> confirmationDialog(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                Stack(alignment: Alignment.center, children: <Widget>[
                  Column(
                    children: [
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(150),
                              bottomRight: Radius.circular(150)),
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: SizedBox(
                                height: 100,
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
                      height: 70,
                      child: Image.asset(
                        'assets/images/emailIcon.png',
                      )),
                ]),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "Verification code has been sent to",
                    style: TextStyle(color: Color(0xFF45A6DD), fontSize: 17),
                  ),
                ),
                const Center(
                  child: Text(
                    "your email address, Please check ",
                    style: TextStyle(color: Color(0xFF45A6DD), fontSize: 17),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SizedBox(
                        width: 0.3 * width,
                        height: 50,
                        child: CustomButon(
                          text: "BACK",
                          onTap: () => Navigator.pop(context, 'BACK'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 0,
                      width: 10,
                    ),
                    Flexible(
                      child: SizedBox(
                        width: 0.3 * width,
                        height: 50,
                        child: CustomButon(
                          text: "DONE",
                          onTap: () async {
                            //await SignUpServices().sendOTP(email!);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return PinCodeVerificationScreen(
                                      email: email);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            ));
  }
}
