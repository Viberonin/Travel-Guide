import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travelguide/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:travelguide/controllers/search/search_controller.dart';
import 'package:travelguide/screens/list_all/search_screen.dart';

class SearchAndFilter extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchAndFilter> {
  TextEditingController _controller = TextEditingController();
  final searchController = Get.put(TSearchController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onTap: () {
              Get.to(SearchScreen());
            },
            controller: _controller,
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.search_normal_1),
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        // SizedBox(width: 8),
        // ElevatedButton(
        //   onPressed: () {},
        //   child: Icon(Iconsax.setting_4, color: Colors.white),
        //   style: ElevatedButton.styleFrom(
        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), backgroundColor: Colors.teal,
        //     padding: EdgeInsets.all(16),
        //   ),
        // ),
      ],
    );
  }
}
