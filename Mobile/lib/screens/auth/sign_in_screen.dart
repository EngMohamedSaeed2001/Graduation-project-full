import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'package:semsark/components/button.dart';
import 'package:semsark/components/email_input.dart';

import 'package:semsark/Repo/location_services.dart';
import 'package:semsark/components/loading_screen.dart';

import 'package:semsark/screens/auth/forget_password_screen.dart';
import 'package:semsark/screens/auth/sign_up_screen.dart';

import '../../provider/chat_provider.dart';
import '../../provider/create_ad_provider.dart';
import '../../provider/home_provider.dart';
import '../../provider/login_provider.dart';
import '../../provider/profile_provider.dart';
import '../home/home_screen.dart';
import '../home/profile_screen.dart';




class LoginScreen extends StatelessWidget {

  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController pass = TextEditingController();

  final textFieldFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    var provider = Provider.of<LoginProvider>(context) ;
    return Scaffold(
      body: _ui(context , provider),
    );
  }

  _ui(context , LoginProvider provider){
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                        height: 350, child: Image.asset('assets/images/c.png')),
                    const Text(
                      'PLEASE ENTER YOUR ACCOUNT HERE',
                      style: TextStyle(
                        color: Color(0xFF8189B0),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    EmailInputField(
                        onChanged: (data) {
                          provider.email = data;
                        },
                        hintText: 'Email'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: pass,
                      onChanged: (data) {
                        provider.password = data;
                      },
                      validator: (data) {
                        if (data!.isEmpty) {
                          return "Field is required";
                        }

                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: provider.showPassword,
                      focusNode: textFieldFocusNode,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF1F6FB),
                        prefixIcon: const Icon(Icons.lock_outlined),
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Color(0xFF8189B0)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            )),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            )),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                          child: GestureDetector(
                            onTap: provider.setShowPassword(),
                            child: Icon(
                              provider.showPassword
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ForgetPasswordScreen();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Forget password?',
                        style: TextStyle(
                          color: Color(0xFFFF6A6A),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButon(
                      text: 'Login',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            await provider.login();
                            if (provider.success){
                              await Provider.of<HomeProvider>(context , listen: false).init();
                              await Provider.of<ProfileProvider>(context, listen: false).init();
                              await Provider.of<ChatProvider>(context, listen: false).init();
                              await Provider.of<CreateAdvertisementProvider>(context, listen: false).init();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${provider.errorMessage}'),
                                  duration: const Duration(seconds: 2), // Duration for which the SnackBar is displayed
                                  action: SnackBarAction(
                                    label: 'Close',
                                    onPressed: () {
                                      // Code to execute when the SnackBar action is pressed
                                    },
                                  ),
                                ),
                              );
                            }
                          } catch (ex) {
                            print(ex);
                          }
                        } else {}
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(child: Text("Don't have an account?",)),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SignUpScreen();
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              overflow: TextOverflow.ellipsis,
                              '    Sign Up',
                              style: TextStyle(color: Color(0xFF45A6DD)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if(provider.loading) const LoadingScreen(),

    ],
      ),
    );
  }

}
