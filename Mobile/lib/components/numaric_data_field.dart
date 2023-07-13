import 'package:flutter/material.dart';

import '../utils/helper.dart';

class CustomNumaricDataField extends StatelessWidget {
  CustomNumaricDataField({
    Key? key,
    required this.data,
    required this.txt_value,
    required this.onMinPressed,
    required this.onPlusPressed,
  }) : super(key: key);
  var data , txt_value , onMinPressed , onPlusPressed ;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            txt_value,
            style: Helper.textStyle,
          ),
          const SizedBox(height: 10,),
          Container(
            decoration:BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadiusDirectional.circular(10),
            ) ,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0,bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      padding: const EdgeInsets.all(0),
                      minWidth: 50,
                      onPressed: onMinPressed,
                      color: Colors.white.withRed(230).withGreen(236).withBlue(242),
                      shape: const CircleBorder(),
                      textColor: Colors.white.withRed(151).withGreen(162).withBlue(175),
                      child: const Text(
                        "-",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Text("$data",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: MaterialButton(
                      onPressed: onPlusPressed,
                      padding: const EdgeInsets.all(0),
                      minWidth: 50,
                      color: Colors.white.withRed(227).withGreen(244).withBlue(255),
                      shape: const CircleBorder(),
                      textColor: Colors.white.withRed(76).withGreen(172).withBlue(232),
                      child: const Text(
                        "+",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
