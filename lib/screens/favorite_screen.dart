import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_app/api/rest_client.dart';
import 'package:library_app/custom/gridview_item.dart';
import 'package:library_app/models/book.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final dio = Dio();
  Future<List<Book>>? getFavData;


  @override
  Widget build(BuildContext context) {
    final client = RestClient(dio);
    getFavData = client.getFavBooks();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF6ED),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    const Padding(padding: EdgeInsets.only(right: 10)),
                    Text(
                      'علاقه مندی ها : ',
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.red[800]),
                    ),
                  ],
                ),
                const Divider(
                  height: 50,
                  endIndent: 50,
                  indent: 50,
                  color: Colors.black,
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<List<Book>>(
                  future: getFavData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          await Future.delayed(
                              const Duration(milliseconds: 1500));
                          setState(() {
                            getFavData;
                          });
                        },
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 1,
                              childAspectRatio: 0.67,
                            ),
                            itemCount: snapshot.data == null
                                ? 0
                                : snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return GridviewItem(book: snapshot.data![index]);
                            }),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('از اتصال به انترنت اطمینان حاصل شوید!'),
                      );
                    } else {
                      return const Center(
                        child: Text(
                            'هنوز کتابی به لیست علاقه مندی ها اضافه نکرده اید.'),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    log('favorite screen disposed!');
    super.dispose();
  }
}
