import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:semsark/models/response/advertisement_response_model.dart';

import '../utils/helper.dart';

class AdItem extends StatelessWidget {

  AdItem({Key? key , required this.model}) : super(key: key);
  AdvertisementModel? model;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height ;
    double width = MediaQuery.of(context).size.width ;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadiusDirectional.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: model!.photosList==null ||
                      model!.photosList.isEmpty||
                  model!.photosList[0]=="" ||
                      model!.photosList[0] == "string"?
                  Image.asset(
                    "assets/images/haha.jpeg",
                    fit: BoxFit.fill,
                    width: width,
                    height: height*0.25,
                  ) :
                  Image.network(
                    model!.photosList[0],
                    fit: BoxFit.fill,
                    width: width,
                    height: height*0.25,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topEnd,
                    child: Container(
                      width: width*0.18,
                      height: height*0.05,
                      margin: const EdgeInsetsDirectional.only(top: 10 ,end: 10),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
    model!.category.toUpperCase() == "SELL" ? "For Sell" : "For Rent",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: model!.category=="SELL" ?Color(0xff9b3333) :Helper.blue,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15)
                        ),
                      ),
                    ),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  "${model?.title.toUpperCase()}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    //color : Color(0xff000000)
                    color: Colors.white.withRed(93).withGreen(109).withBlue(129),
                  ),
                ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${model!.city}, ${model!.gov}",
                    style: Helper.stlye,
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  Row(
                    children: [
                      Icon(
                        Icons.bed,
                        color: Helper.blue,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${model?.numOfRoom}",
                        style: Helper.stlye,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.format_size, color: Helper.blue),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${model?.area}",
                        style: Helper.stlye,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.bathtub_outlined, color: Helper.blue),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${model?.numOfBathroom}",
                        style: Helper.stlye,
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        "${model?.price.toInt()} EGP",
                        style: Helper.textStyle,
                      ),
                      if(model!.category=="RENT")
                        SizedBox(
                          child: Text(
                            "/${model!.dailyPrice.toUpperCase()}",
                            //"MONTHLY",

                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
