import 'package:flutter/material.dart';
import 'package:semsark/utils/helper.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height ;
    double width = MediaQuery.of(context).size.width ;
    return Stack(
      children: [
        SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/load.gif' ,
                height: height*0.25,
              ),
            ],
          ),
        ),
      ],
    ) ;
  }
}
