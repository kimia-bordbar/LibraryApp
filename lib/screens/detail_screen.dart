import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_app/api/rest_client.dart';

import 'package:library_app/models/book.dart';
import 'package:library_app/models/temp_book.dart';

class DetailScreen extends StatefulWidget {
  final Book book;
  const DetailScreen({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final dio = Dio();
  Future<Book>? putFavData;

  @override
  Widget build(BuildContext context) {
    final client = RestClient(dio);
     TempBook tempBook = TempBook(
      author: widget.book.author,
      store_name: widget.book.store_name,
      description: widget.book.description,
      fav: widget.book.fav,
    );
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, index) {
            return [
              SliverAppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.grey,
                  ),
                  splashColor: Colors.black,
                  onPressed: () {
                    Get.back();
                  },
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      icon: tempBook.fav
                          ? const Icon(Icons.favorite, size: 25.0)
                          : const Icon(Icons.favorite_border, size: 25.0),
                      onPressed: () {
                         log(tempBook.fav.toString());
                        setState(() {
                          tempBook.fav = !tempBook.fav;
                          widget.book.fav = tempBook.fav;
                          log(tempBook.fav.toString());
                          putFavData = client.updateFav(
                            widget.book.id,
                            tempBook,
                          );
                        });
                      },
                      splashColor: Colors.red,
                      color: Colors.red,
                    ),
                  )
                ],
                shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                ),
                expandedHeight: 500.0,
                floating: false,
                pinned: true,
                centerTitle: false,
                backgroundColor: Colors.white,
                elevation: 20,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    widget.book.image,
                    fit: BoxFit.cover,
                  ),
                  title: Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      widget.book.author,
                      style: GoogleFonts.tinos(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            padding: const EdgeInsets.only(top: 10.0, right: 8.0, left: 8.0),
            children: [
              Text(
                widget.book.store_name,
                style: GoogleFonts.sourceSansPro(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                child: Text(widget.book.description),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    log('detail screen disposed');
    super.dispose();
  }
}
