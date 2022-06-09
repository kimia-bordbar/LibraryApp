import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_app/api/rest_client.dart';
import 'package:library_app/custom/gridview_item.dart';
import 'package:library_app/models/book.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  Future<List<Book>>? getSearchs;
  final dio = Dio();
  
  @override
  Widget build(BuildContext context) {
    final client = RestClient(dio);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF6ED),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        getSearchs = client.getSearchs(controller.text);
                      });
                    },
                  ),
                  hintText: 'نام داستان',
                  hintStyle: GoogleFonts.sourceSansPro(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              child: FutureBuilder<List<Book>>(
                future: getSearchs,
                builder: (context, snapshot) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: 0.70,
                    ),
                    primary: false,
                    itemCount:
                        snapshot.data == null ? 0 : snapshot.data!.length,
                    itemBuilder: (context, index) {
                      if (snapshot.hasData) {
                        return GridviewItem(book: snapshot.data![index]);
                      } else {
                        return const Center(
                          child: Text('کتابی یافت نشد'),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    log('search screen disposed');

    super.dispose();
  }
}
