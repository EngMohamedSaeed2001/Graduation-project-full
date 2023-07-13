import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semsark/models/response/advertisement_response_model.dart';
import 'package:semsark/provider/advertisement_detailes_provider.dart';
import 'package:semsark/screens/advertisementDetails/advertisement_details_screen.dart';

import '../utils/helper.dart';

class MapAdvertisementItem extends StatelessWidget {
  MapAdvertisementItem({Key? key, required this.model}) : super(key: key);
  AdvertisementModel model;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    height *= 0.15 ;
    width = width*0.84 ;
    return InkWell(
      onTap: () async {
        Provider.of<AdvertisementDetailsProvider>(context, listen: false).setID(model.id) ;
        await Provider.of<AdvertisementDetailsProvider>(context, listen: false).setModel(model) ;
        Navigator.push(context, MaterialPageRoute(builder: (_) =>
        AdvertisementDetailsScreen()
        )) ;
      },
      child: Container(
        padding: const EdgeInsetsDirectional.all(2),
        decoration: BoxDecoration(
          color: const Color(0xe6ffffff),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            model.photosList.isEmpty ||
            model.photosList[0] == null ||
                model.photosList[0]=="" ||
                model.photosList[0] == "string"?
                Image.asset("assets/images/haha.jpeg",
                  fit: BoxFit.fill,
                  width: width*0.35,
                  height: height,
                ) :
                Image.network(model.photosList[0],
                  fit: BoxFit.fill,
                  width: width*0.35,
                  height: height,
                ),
            SizedBox(width: width*0.05,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(

                  width: width*0.5,
                  height: height*0.25,
                  child: Text(model.title,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,

                  ),
                  ),
                ),
                SizedBox(
                  width: width*0.5,
                  height: height*0.2,
                  child: Text("${model.price.toInt()} LE",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
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
                      "${model.numOfRoom}",
                      style: Helper.textStyle,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.format_size, color: Helper.blue),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${model.area}",
                      style: Helper.textStyle,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.bathtub_outlined, color: Helper.blue),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${model.numOfBathroom}",
                      style: Helper.textStyle,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                SizedBox(
                  width: width*0.5,
                  height: height*0.2,
                  child: Text("${model.city}, ${model.gov}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Helper.grey
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
