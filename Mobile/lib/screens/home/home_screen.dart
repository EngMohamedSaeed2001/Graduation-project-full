import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semsark/components/loading_screen.dart';
import 'package:semsark/provider/chat_provider.dart';
import 'package:semsark/provider/home_provider.dart';
import 'package:semsark/provider/profile_provider.dart';
import 'package:semsark/screens/home/advertisements_screen.dart';
import 'package:semsark/screens/home/chat_screen.dart';
import 'package:semsark/screens/home/create_advertisement_screen.dart';
import 'package:semsark/screens/home/filter_screen.dart';
import 'package:semsark/screens/home/map_screen.dart';
import 'package:semsark/screens/home/profile_screen.dart';
import 'package:semsark/screens/home/verify_user_screen.dart';
import 'package:semsark/utils/constants.dart';
import 'package:semsark/utils/helper.dart';

import '../auth/sign_in_screen.dart';
import 'notification_screen.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);
    double height = MediaQuery.of(context).size.height ;
    return Scaffold(
      //extendBody: true,
      resizeToAvoidBottomInset: false,
      body: _ui(context, provider),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.transparent,
        height: 75,
        items: const [
          Icon(
            Icons.home_outlined,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.chat_outlined,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.notifications,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.account_box_outlined,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (_index) async {
          if(_index==PROFILE_PAGE){
            await Provider.of<ProfileProvider>(context,listen: false).init();
          }else if(_index==CHAT_PAGE){
            await Provider.of<ChatProvider>(context,listen: false).init();
          }
          provider.changePosition(_index);
        },
        color: Helper.blue,
      ),
    );
  }

  _ui(context , HomeProvider provider){
    var widgets = [
      const AdvertisementsScreen(),
      ChatScreen(),
      CreateAdvertisementScreen(),
      NotificationScreen(),
       ProfileScreen(),
      FilterScreen(),
    ];

    return Stack(
      children: [
        Visibility(
          visible: !provider.isVerified,
          child: widgets[provider.index],
        ),
        if(provider.isLoading) const LoadingScreen(),
      ],
    );
  }
}
