import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semsark/models/response/advertisement_response_model.dart';
import 'package:semsark/provider/profile_provider.dart';
import 'package:semsark/screens/advertisementDetails/edit_ad_details.dart';
import '../provider/edit_ad_provider.dart';
import '../utils/helper.dart';

class MyAdvertisementItem extends StatelessWidget {
  MyAdvertisementItem({Key? key , required this.model , required this.canEdit}) : super(key: key);

  AdvertisementModel model ;
  bool canEdit ;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height ;
    double width = MediaQuery.of(context).size.width ;
    height *= (canEdit ? 0.17 : 0.15);
    width *= 0.9 ;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            model.photosList.isEmpty||
            model.photosList[0]=="" ||
            model.photosList[0] == "string"?
              Image.asset(
                "assets/images/haha.jpeg",
                fit: BoxFit.cover,
                width: width*0.4,
                height: height,
              ) :
              Image.network(
                model.photosList[0],
                fit: BoxFit.cover,
                width: width*0.4,
                height: height,
              ),
            Container(
              //alignment: Alignment.centerRight,
              margin: const EdgeInsetsDirectional.only(start: 12, top: 10, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width*0.50,
                    child: Text(
                      "${model.price.toInt()} EGP",
                      style: Helper.textStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: width*0.55,
                    child: Row(
                      children: [
                        Icon(
                          Icons.bed,
                          color: Helper.blue,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "${model.numOfRoom}",
                          style: Helper.textStyle,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.format_size, color: Helper.blue),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "${model.area}",
                          style: Helper.textStyle,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.bathtub_outlined, color: Helper.blue),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "${model.numOfBathroom}",
                          style: Helper.textStyle,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${model.city}, ${model.gov}',
                    style: Helper.stlye,
                  ),
                  SizedBox(height: 3,),
                  if(canEdit)
                    SizedBox(
                      width: width*0.55,
                      height: height*0.25,
                      child: Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              child: Icon(Icons.edit_note_outlined),
                              onPressed: (){
                                Provider.of<EditAdProvider>(context,listen: false).setModel(model) ;
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                EditAdScreen()
                                )) ;
                              },
                            ),
                          ),
                          Expanded(
                            child: MaterialButton(
                              child: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Confirm Delete'),
                                      content: Text('Are you sure you want to delete?'),
                                      actions: [
                                        TextButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Delete'),
                                          onPressed: () async {
                                            await Provider.of<ProfileProvider>(context, listen: false).deleteAd(model.id);
                                            Navigator.of(context).pop(); // Close the dialog
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),

                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),

          ],

        ),
      ),
    );
  }
}
