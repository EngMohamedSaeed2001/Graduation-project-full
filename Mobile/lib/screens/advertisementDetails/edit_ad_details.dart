import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:semsark/components/custom_drop_down_field.dart';
import 'package:semsark/components/custom_input_field.dart';
import 'package:semsark/components/loading_screen.dart';
import 'package:semsark/components/numaric_data_field.dart';
import 'package:semsark/provider/create_ad_provider.dart';
import 'package:semsark/provider/edit_ad_provider.dart';
import 'package:semsark/provider/home_provider.dart';
import 'package:semsark/screens/home/home_screen.dart';
import 'package:semsark/utils/constants.dart';
import 'package:semsark/utils/helper.dart';
import 'package:provider/provider.dart';

class EditAdScreen extends StatefulWidget {
  @override
  State<EditAdScreen> createState() => _EditAdScreenState();
}

class _EditAdScreenState extends State<EditAdScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var provider = Provider.of<EditAdProvider>(context) ;
    return _ui(provider , width , context) ;
  }

  _ui(EditAdProvider provider , width , context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: width,
                  padding: const EdgeInsets.all(10),
                  color: Colors.white30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pop(context) ;
                      }, icon: Icon(Icons.arrow_back , color: Helper.blue,)),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Edit THE BUILDING DETAILS",
                            style: TextStyle(
                              color: Helper.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              CustomFieldInput(
                                txt: "Title",
                                controller: provider.titleController,

                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CustomFieldInput(
                                      txt: "Price",
                                      inputType: const TextInputType.numberWithOptions(
                                          decimal: true),
                                      maxLen: 10,
                                      controller: provider.priceController,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: CustomFieldInput(
                                      txt: "Area",
                                      inputType: TextInputType.number,
                                      maxLen: 10,
                                      controller: provider.areaController,
                                    ),
                                  ),
                                ],
                              ),
                              if(provider.model!.category=="RENT")
                                Row(
                                  children: [
                                    Radio(
                                      value: "DAILY",
                                      groupValue: provider.dailyPrice,
                                      onChanged: (value) {
                                        provider.setDailyPrice(value);
                                      },
                                    ),
                                    const Text("Daily Price"),
                                    Radio(
                                      value: "MONTHLY",
                                      groupValue: provider.dailyPrice,
                                      onChanged: (value) {
                                        provider.setDailyPrice(value);
                                      },
                                    ),
                                    const Text("Monthly Price"),
                                    Radio(
                                      value: "YEARLY",
                                      groupValue: provider.dailyPrice,
                                      onChanged: (value) {
                                        provider.setDailyPrice(value);
                                      },
                                    ),
                                    const Text("Yearly Price"),
                                  ],
                                ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomDropDownField(
                                labelText: "Type",
                                list: provider.types,
                                value: provider.type_val,
                                onChange: (newValue) {
                                  provider.setType(newValue);
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomDropDownField(
                                labelText: "Signal Type",
                                list: provider.signals,
                                value: provider.signal_val,
                                onChange: (newValue) {
                                  provider.setSignalPower(newValue);
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomFieldInput(
                                txt: "Details",
                                maxLen: 500,
                                maxLine: 10,
                                controller: provider.detailsController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      CustomNumaricDataField(
                                        txt_value: "ROOMS",
                                        data: provider.num_of_rooms,
                                        onMinPressed: () {
                                          provider.setNumOfRooms( max(provider.num_of_rooms - 1, 0));
                                        },
                                        onPlusPressed: () {
                                          provider.setNumOfRooms(min(provider.num_of_rooms + 1, 10));
                                        },
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      CustomNumaricDataField(
                                        txt_value: "BATHROOM",
                                        data: provider.num_of_bath_rooms,
                                        onMinPressed: () {
                                          provider.setNumOfBathRooms(
                                              max(provider.num_of_bath_rooms - 1, 1));
                                        },
                                        onPlusPressed: () {
                                          provider.setNumOfBathRooms(
                                              min(provider.num_of_bath_rooms + 1, 10));
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    children: [
                                      CustomNumaricDataField(
                                        txt_value: "HOUSE LEVEL",
                                        data: provider.num_of_level,
                                        onMinPressed: () {
                                          provider.setHouseLevel(max(provider.num_of_level - 1, 0));
                                        },
                                        onPlusPressed: () {
                                          provider.setHouseLevel(min(provider.num_of_level + 1, 100));
                                        },
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      CustomNumaricDataField(
                                        txt_value: "HALLS",
                                        data: provider.num_of_halls,
                                        onMinPressed: () {
                                          provider.setNumOfHalls(max(provider.num_of_halls - 1, 0));
                                        },
                                        onPlusPressed: () {
                                          provider.setNumOfHalls(min(provider.num_of_halls + 1, 10));
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            "ELEVATOR",
                                            style: Helper.textStyle,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                              value: "YES",
                                              groupValue: provider.elevator,
                                              onChanged: (value) {
                                                provider.setElevator(value);
                                              },
                                            ),
                                            const Text("YES"),
                                            Radio(
                                              value: "NO",
                                              groupValue: provider.elevator,
                                              onChanged: (value) {
                                                provider.setElevator(value);
                                              },
                                            ),
                                            const Text("NO"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            "FINISHED",
                                            style: Helper.textStyle,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                              value: "YES",
                                              groupValue: provider.fin_value,
                                              onChanged: (value) {
                                                provider.setFinished(value);
                                              },
                                            ),
                                            const Text("YES"),
                                            Radio(
                                              value: "NO",
                                              groupValue: provider.fin_value,
                                              onChanged: (value) {
                                                provider.setFinished(value);
                                              },
                                            ),
                                            const Text("NO"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              if(provider.model!.category=="RENT")
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15.0),
                                            child: Text(
                                              "ACCEPT SINGLES",
                                              style: Helper.textStyle,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                value: "YES",
                                                groupValue: provider.acceptSingle,
                                                onChanged: (value) {
                                                  provider.setAcceptSingle(value);
                                                },
                                              ),
                                              const Text("YES"),
                                              Radio(
                                                value: "NO",
                                                groupValue: provider.acceptSingle,
                                                onChanged: (value) {
                                                  provider.setAcceptSingle(value);
                                                },
                                              ),
                                              const Text("NO"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15.0),
                                            child: Text(
                                              "ACCEPT BUSINESS",
                                              style: Helper.textStyle,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                value: "YES",
                                                groupValue: provider.acceptBusiness,
                                                onChanged: (value) {
                                                  provider.setAcceptBusiness(value);
                                                },
                                              ),
                                              const Text("YES"),
                                              Radio(
                                                value: "NO",
                                                groupValue: provider.acceptBusiness,
                                                onChanged: (value) {
                                                  provider.setAcceptBusiness(value);
                                                },
                                              ),
                                              const Text("NO"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.circular(50),
                                ),
                                child: MaterialButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await provider.editAdvertisement() ;
                                      if(provider.success) {
                                        //Provider.of<HomeProvider>(context , listen: false).changePosition(PROFILE_PAGE);
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                                      }
                                      if(provider.errorMsg !=""){
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Error'),
                                              content: Text(provider.errorMsg),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop(); // Close the dialog
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    } else {

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text('Complete All Fields'),
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
                                  },
                                  //rgba(69, 166, 221, 1)
                                  color: Helper.blue,
                                  child: const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          if(provider.isLoading) const LoadingScreen(),
        ],
      ),
    ) ;
  }

  void pick_photo(CreateAdvertisementProvider provider) async {
    ImagePicker _picker = ImagePicker();
    final photo = await _picker.pickImage(source: ImageSource.camera);
    if(photo != null){
      provider.photos.add(photo) ;
      provider.notifyListeners();
    }
  }

  Widget list_of_photos(CreateAdvertisementProvider provider) {
    List<Widget> col = [], row = [];
    for (var element in provider.photos) {
      row.add(Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            height: 100,
            width: 110,
            child: Image.file(
              File(
                element.path,
              ),
              fit: BoxFit.fitWidth,
            )),
      ));
      if (row.length % 3 == 0) {
        col.add(Row(
          children: row,
        ));
        row = [];
      }
    }
    row.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          pick_photo(provider);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadiusDirectional.circular(10),
          ),
          width: 110,
          height: 100,
          child: const Icon(Icons.camera_enhance),
        ),
      ),
    ));
    col.add(Row(
      children: row,
    ));
    return Column(
      children: col,
    );
  }
}
