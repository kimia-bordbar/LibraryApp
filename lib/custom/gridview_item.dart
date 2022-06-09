import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:library_app/models/book.dart';
import 'package:library_app/screens/detail_screen.dart';

class GridviewItem extends StatelessWidget {
  final Book book;
  const GridviewItem({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  book.image,
                  fit: BoxFit.fill,
                  errorBuilder: (context, object, stack) {
                    return const Center(child: Text(':/'));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                book.store_name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.sourceSansPro(fontSize: 10.0),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Get.to(() => DetailScreen(book: book));
      },
    );
  }
}
