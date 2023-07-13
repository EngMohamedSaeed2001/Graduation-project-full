import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semsark/models/response/advertisement_response_model.dart';
import 'package:semsark/screens/home/home_screen.dart';
import 'package:semsark/utils/constants.dart';

import '../../provider/home_provider.dart';
import '../../utils/helper.dart';

class FilterScreen extends StatefulWidget {
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final Map<int, String> selection = {
    0: '1',
    1: '2',
    2: '3+',
  };

  int selectedBedrooms = 0;
  int selectedBathrooms = 0;
  int selectedHalls = 0;

  int maxSelectedBedrooms = 1000;
  int maxSelectedBathrooms = 1000;
  int maxSelectedHalls = 1000;

  RangeValues priceRangeValue = const RangeValues(0.0, 200000000);
  RangeValues areaRangeValue = const RangeValues(0.0, 50000);

  List<String> selectedPropertyTypes = [];
  bool finished = false;
  bool single = false;
  bool elevator = false;
  bool acceptBusiness = false;
  List<bool> isSelected = [true, false];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed:(){
              setState(() {
                resetFilters();
              });
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text("Reset"),
          ),
        ],
        title: const Text("Filter"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      const Text(
                        "Category",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: ToggleButtons(
                          borderRadius: BorderRadius.circular(8),
                          selectedColor: Colors.white,
                          fillColor: Helper.blue,
                          onPressed: (int index) {
                            setState(() {
                              for (int i = 0;
                              i < isSelected.length;
                              i++) {
                                isSelected[i] = i == index;
                              }
                            });

                          },
                          isSelected: isSelected,
                          children: [
                            SizedBox(
                              width: width / 4,
                              child: const Center(child: Text("Renting" ,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                ),

                              )),
                            ),
                            SizedBox(
                              width: width / 4,
                              child: const Center(child: Text("Selling",

                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Bedrooms",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: selection.entries.map((entry) {
                          return OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedBedrooms = entry.key;
                                maxSelectedBedrooms = entry.key==2? 1000 : entry.key;
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  selectedBedrooms == entry.key
                                      ? Colors.white
                                      : Colors.black,
                              backgroundColor:
                                  selectedBedrooms == entry.key
                                      ? Helper.blue
                                      : Colors.white,
                            ),
                            child: Text(entry.value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Bathrooms",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:
                            selection.entries.map((entry) {
                          return OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedBathrooms = entry.key;
                                maxSelectedBathrooms = entry.key==2? 1000 : entry.key;

                              });

                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  selectedBathrooms == entry.key
                                      ? Colors.white
                                      : Colors.black,
                              backgroundColor:
                                  selectedBathrooms == entry.key
                                      ? Helper.blue
                                      : Colors.white,
                            ),
                            child: Text(entry.value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Halls",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: selection.entries.map((entry) {
                          return OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedHalls = entry.key;
                                maxSelectedHalls = entry.key==2? 1000 : entry.key;
                              });

                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  selectedHalls == entry.key
                                      ? Colors.white
                                      : Colors.black,
                              backgroundColor:
                                  selectedHalls == entry.key
                                      ? Helper.blue
                                      : Colors.white,
                            ),
                            child: Text(entry.value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Property Types",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      CheckboxListTile(
                        title: const Text("Apartment"),
                        value: selectedPropertyTypes
                            .contains('APARTMENT'),
                        onChanged: (bool? value) {
                          setState(() {
                            if(value!){
                              selectedPropertyTypes.add("APARTMENT") ;
                            }else {
                              selectedPropertyTypes.remove("APARTMENT") ;

                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Duplex"),
                        value:
                            selectedPropertyTypes.contains('DUPLEX'),
                        onChanged: (value) {
                          setState(() {
                            if(value!){
                              selectedPropertyTypes.add("DUPLEX") ;
                            }else {
                              selectedPropertyTypes.remove("DUPLEX") ;
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Studio"),
                        value:
                            selectedPropertyTypes.contains('STUDIO'),
                        onChanged: (value) {
                          setState(() {
                            if(value!){
                              selectedPropertyTypes.add("STUDIO") ;
                            }else {
                              selectedPropertyTypes.remove("STUDIO") ;
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Price Range",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      RangeSlider(
                        values: priceRangeValue,
                        min: 0,
                        max: 200000000,
                        divisions: 200000000,
                        activeColor: Helper.blue,
                        onChanged: (values) {
                          setState(() {
                            priceRangeValue = values ;
                          });
                        },
                        labels: RangeLabels(
                          priceRangeValue.start.round().toString(),
                          priceRangeValue.end.round().toString(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Area Range",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      RangeSlider(
                        values: areaRangeValue,
                        min: 0,
                        max: 50000,
                        divisions: 5000,
                        activeColor: Helper.blue,
                        onChanged: (values) {
                          setState(() {
                            areaRangeValue = values ;
                          });                        },
                        labels: RangeLabels(
                          areaRangeValue.start.round().toString(),
                          areaRangeValue.end.round().toString(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Additional Filters",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      CheckboxListTile(
                        title: const Text("Finished"),
                        value: finished,
                        onChanged: (value) {
                          setState(() {
                            finished = value! ;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Elevator"),
                        value: elevator,
                        onChanged: (value) {
                          setState(() {
                            elevator = value! ;
                          });
                        },
                      ),
                      if(isSelected[0])
                        CheckboxListTile(
                        title: const Text("Accept Single?"),
                        value: single,
                        onChanged: (value) {
                          setState(() {
                            single = value! ;
                          });                        },
                      ),
                      if(isSelected[0])
                        CheckboxListTile(
                        title: const Text("Accept Business?"),
                        value: acceptBusiness,
                        onChanged: (value) {
                          setState(() {
                            acceptBusiness = value! ;
                          });
                        },
                      ),
                      // CheckboxListTile(
                      //   title: const Text("Elevator"),
                      //   value: elevator,
                      //   onChanged: (value) {
                      //     setElevator(value);
                      //   },
                      // ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async{
                            // Perform filtering logic here
                            var data= {
                              "category": isSelected[0] ? "RENT":"SELL",
                              "city": "",
                              "types": selectedPropertyTypes,
                              "minPrice": priceRangeValue.start,
                              "maxPrice": priceRangeValue.end,
                              "minArea": areaRangeValue.start,
                              "maxArea": areaRangeValue.end,
                              "minNumOfRoom": selectedBedrooms+1,
                              "maxNumOfRoom": maxSelectedBedrooms+1,
                              "minNumOfBathroom": selectedBathrooms+1,
                              "maxNumOfBathroom": maxSelectedBathrooms+1,
                              "minNumOfHalls": selectedHalls+1,
                              "maxNumOfHalls": maxSelectedHalls+1,
                              "finished": finished,
                              "single": single,
                              "acceptBusiness": acceptBusiness
                            };
                            await Provider.of<HomeProvider>(context , listen: false)
                            .filter(data);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            backgroundColor: Helper.blue,
                            disabledBackgroundColor: Colors.white,
                          ),
                          child: const Text(
                            "Apply",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  void resetFilters() {

    // elevator = false ;
    selectedBedrooms = 0;
    selectedBathrooms = 0;
    selectedHalls = 0;
    priceRangeValue = const RangeValues(0.0, 200000000);
    areaRangeValue = const RangeValues(0.0, 50000);
    selectedPropertyTypes.clear();
    finished = false;
    single = false;
    acceptBusiness = false;
    isSelected = [true , false] ;
  }
}
