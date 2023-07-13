import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semsark/provider/advertisement_detailes_provider.dart';
import 'package:semsark/provider/home_provider.dart';
import 'package:semsark/screens/advertisementDetails/advertisement_details_screen.dart';
import 'package:semsark/screens/home/filter_screen.dart';
import 'package:semsark/utils/constants.dart';

import '../../components/show_ads_item.dart';
import '../../utils/helper.dart';
import '../advertisementDetails/edit_ad_details.dart';

class AdvertisementListScreen extends StatelessWidget {
  AdvertisementListScreen({Key? key}) : super(key: key);

  final _textEditingController = TextEditingController();
  final List<String> _sortOptions = [
    'Price (High to Low)',
    'Price (Low to High)',
  ];
  String _selectedSortOption = '';

  void _showSortOptionsDialog(context ,HomeProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SizedBox(
            height: _sortOptions.length*80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    'Sort By',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _sortOptions.length,
                      itemBuilder: (context, index) {
                        final sortOption = _sortOptions[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            provider.sort(index) ;
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 10.0,
                            ),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: _selectedSortOption == sortOption
                                  ? Colors.grey.shade300
                                  : null,
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  sortOption,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: _selectedSortOption ==
                                        sortOption
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                if (_selectedSortOption == sortOption)
                                  const Icon(Icons.check),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<HomeProvider>(context);


    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(

              onChanged: (txt) {
                provider.setSearch(txt);

              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Search..',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[300],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    //provider.changePosition(FILTER_PAGE);
                    Navigator.push(context, MaterialPageRoute(builder:(_) =>
                    FilterScreen()
                    )) ;
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Helper.blue,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    child: Row(
                      children: const [
                        Icon(Icons.filter_list_alt, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Filter', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _showSortOptionsDialog(context,provider);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Helper.blue,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    child: Row(
                      children: const [
                        Icon(Icons.sort, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Sort', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child:provider.searchList != null || provider.searchList!.length!=0? ListView.builder(
                itemBuilder: (context, index) =>
                    InkWell(
                      onTap: () async {
                        await Provider.of<AdvertisementDetailsProvider>(context , listen: false).setModel(
                            provider.searchList![index]
                        );

                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => AdvertisementDetailsScreen()));
                      },
                        child: AdItem(model: provider.searchList![index],)),
                itemCount: provider.searchList!.length) :
            const Text("No Ads Yet")
            ,
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}
