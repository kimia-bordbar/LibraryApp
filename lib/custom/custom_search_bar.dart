import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_app/screens/search_screen.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10.0, left: 15.0),
                child: Icon(Icons.search),
              ),
              Text(
                'جستجو',
                style: GoogleFonts.sourceSansPro(fontSize: 20.0),
              ),
            ],
          ),
        ),
        onTap: () {
          Get.to(() => const SearchScreen());
        });
  }
}
