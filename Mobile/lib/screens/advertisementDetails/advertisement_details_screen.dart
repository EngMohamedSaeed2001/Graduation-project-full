import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:semsark/components/loading_screen.dart';
import 'package:semsark/models/chat/chat_user_model.dart';
import 'package:semsark/provider/advertisement_detailes_provider.dart';
import 'package:semsark/screens/chat/chat_detial.dart';
import 'package:semsark/screens/home/chat_screen.dart';
import 'package:semsark/screens/home/home_screen.dart';
import 'package:semsark/utils/end_points.dart';
import 'package:semsark/utils/helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

import '../../components/my_ad_item.dart';
import '../../provider/chat_provider.dart';

class AdvertisementDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _ui(context) ;

  _ui(context){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<AdvertisementDetailsProvider>(context);
    var chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Details',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: height * 0.25,
                    enlargeCenterPage: true,
                    autoPlay: true,
                  ),
                  items: provider.model!.photosList.isNotEmpty ? provider.model?.photosList.map((image) {
                    return Container(
                      margin: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        child:image == "" || image == "string"
                            ? Image.asset("assets/images/haha.jpeg",
                          fit: BoxFit.cover,
                          width: width,
                        ):
                        Image.network(
                          image,
                          fit: BoxFit.cover,
                          width: width,
                        ),
                      ),
                    );
                  }).toList() : [
                    Image.asset("assets/images/haha.jpeg",
                      fit: BoxFit.cover,
                      width: width,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    provider.model!.title.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                createRowWithItems(Icons.format_size, true, "Area", width,
                    additionalText: "${provider.model?.area}"),
                createRowWithItems(Icons.bed, false, "Num Of Rooms", width,
                    additionalText: "${provider.model?.numOfRoom}"),
                createRowWithItems(
                    Icons.apartment_outlined, true, "Num Of Halls", width,
                    additionalText: "${provider.model?.numOfHalls}"),
                createRowWithItems(
                    Icons.bathtub_outlined, false, "Num Of Bathrooms", width,
                    additionalText: "${provider.model?.numOfBathroom}"),
                createRowWithItems(
                    Icons.signal_cellular_alt, true, "Signal Type", width,
                    additionalText: "${provider.model?.signalPower}"),
                if (provider.model!.single && provider.model!.category=="RENT")
                  createRowWithItems(Icons.person, false, "Accept Singles? ", width),
                if (provider.model!.elevator)
                  createRowWithItems(
                      Icons.elevator, true, "Found Elevator? ", width),
                if (provider.model!.acceptBusiness && provider.model!.category=="RENT")
                  createRowWithItems(
                      Icons.business_outlined, false, "Accept Business ?", width),
                if (provider.model!.finished)
                  createRowWithItems(
                      Icons.business_outlined, true, "Finished ?", width),
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  padding: const EdgeInsets.only(
                      left: 10
                  ),
                  child: const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: width*0.99,
                  margin: const EdgeInsetsDirectional.all(10),
                  padding: const EdgeInsetsDirectional.all(10),// Set the desired width for the square container
                  color: Colors.grey[200],
                  child: Text(
                    provider.model!.apartmentDetails,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  padding: const EdgeInsets.only(
                      left: 10
                  ),
                  child: const Text(
                    'User Details',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: width*0.98,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 50.0,
                                backgroundImage: provider.model!.user.img == null ||
                                    provider.model!.user.img == "" ||
                                    provider.model!.user.img == "string"
                                    ? const AssetImage("assets/images/Mask.png")
                                    : null,
                                foregroundImage: provider.model!.user.img == null ||
                                    provider.model!.user.img == "" ||
                                    provider.model!.user.img == "string"
                                    ? null
                                    : NetworkImage("${provider.model!.user.img}"),
                              ),
                              Icon(
                                provider.model!.user.verifyId == null || !provider.model!.user.verifyId ? Icons.warning : Icons.check_circle,
                                color: provider.model!.user.verifyId == null || !provider.model!.user.verifyId ? Colors.orange : Helper.blue,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            provider.model!.user.username??"User Name",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            provider.model!.user.email,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          // AbsorbPointer(
                          //   absorbing: true,
                          //   child: RatingBar(
                          //     initialRating: provider.model!.user.rate,
                          //     minRating: 0,
                          //     direction: Axis.horizontal,
                          //     allowHalfRating: true,
                          //     itemCount: 5,
                          //     itemSize: 20.0,
                          //     onRatingUpdate: (rating) {
                          //       // Handle rating update if needed
                          //     },
                          //     ratingWidget: RatingWidget(
                          //       full: const Icon(
                          //         Icons.star,
                          //         color: Colors.amber,
                          //       ),
                          //       half: const Icon(
                          //         Icons.star_half,
                          //         color: Colors.amber,
                          //       ),
                          //       empty: const Icon(
                          //         Icons.star_border,
                          //         color: Colors.amber,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                if(provider.recomended.isNotEmpty)
                  Container(
                  alignment: AlignmentDirectional.centerStart,
                  padding: const EdgeInsets.only(
                      left: 10
                  ),
                  child: const Text(
                    'Recommended ADs',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: (height*0.22)* min(provider.recomended.length, 3),
                  padding: EdgeInsetsDirectional.all(10),
                  child:provider.recomended.isNotEmpty?

                  ListView.builder(
                      itemCount: min(provider.recomended.length, 3),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Provider.of<AdvertisementDetailsProvider>(context, listen: false).setModel(provider.recomended[index]) ;
                            Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                AdvertisementDetailsScreen()
                            )) ;
                          },
                          child: MyAdvertisementItem(
                            model: provider.recomended[index],
                            canEdit: false,
                          ))) : LoadingScreen(),
                ),
              ],
            ),
          ),
            if(provider.isLoading) const LoadingScreen(),

    ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.share , color: Helper.blue,),
              onPressed: () {
                String textToShare = "${GET_AD_BY_ID}/${provider.model!.id}";
                Share.share(textToShare);
              },
            ),
            IconButton(
              icon: const Icon(Icons.call),
              color: Helper.blue ,
              onPressed: () {
                _makePhoneCall(provider.model!.user.phone!);
              },
            ),
            IconButton(
              icon: const Icon(Icons.chat_outlined),
              color: Helper.blue,
              onPressed: () async{
                provider.setLoading(true);
                await chatProvider.setReciver(
                  ChatUsers(id: provider.model!.user.userId,
                      email: provider.model!.user.email,
                      username: provider.model!.user.username??"",
                      image: provider.model!.user.img??""
                  )
                );
                provider.setLoading(false);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChatDetailPage();
                }));
                chatProvider.openChat("${GET_AD_BY_ID}/${provider.model!.id}");

              },
            ),
            IconButton(
              icon: Icon(
                provider.isFav ? Icons.favorite : Icons.favorite_border ,
                color:provider.isFav ? Colors.red : Colors.red,
              ),
              onPressed: () {
                provider.changeFav() ;
              },
            ),
          ],
        ),
      ),
    );
  }
  void _makePhoneCall(String phoneNumber) async {
    final url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Widget createRowWithItems(
      IconData icon, bool isBlue, String text, double width,
      {String? additionalText, IconData? additionalIcon}) {
    return Container(
      color: isBlue ? Helper.light_blue : Colors.white,
      padding: const EdgeInsetsDirectional.all(10),
      child: Row(
        children: [
          SizedBox(
              width: width * 0.1,
              child: Icon(
                icon,
                color: Colors.black,
              )),
          SizedBox(
            width: width * 0.05,
          ),
          SizedBox(
              width: width * 0.4,
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 18, color: Colors.black),
              )),
          SizedBox(
            width: width * 0.05,
          ),
          additionalText != null
              ? Text(
                  additionalText,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black),
                )
              : Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: Helper.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16.0,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
