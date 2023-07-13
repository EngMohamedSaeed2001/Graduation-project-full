import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semsark/screens/home/list_screen.dart';
import 'package:semsark/screens/home/map_screen.dart';

import '../../provider/home_provider.dart';
import '../../utils/helper.dart';

class AdvertisementsScreen extends StatelessWidget {
  const AdvertisementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context) ;
    return Scaffold(
      body :
      provider.isMap ? AdvertisementMapScreen() : AdvertisementListScreen() ,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 20),
        child: Container(
          margin: const EdgeInsets.only(
              bottom: 15
          ),
          child: FloatingActionButton(
            backgroundColor: Helper.blue,
            onPressed: () {
              provider.changeMap();
            },
            child: Icon(
              provider.isMap ? Icons.list : Icons.map_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
