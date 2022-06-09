import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_app/api/rest_client.dart';
import 'package:library_app/custom/custom_search_bar.dart';
import 'package:library_app/custom/gridview_item.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/screens/favorite_screen.dart';
// import 'package:logger/logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// final logger = Logger();
  late Future<List<Book>> getBooksData;
  @override
  void initState() {
    super.initState();
    final dio = Dio();
    final client = RestClient(dio);
    getBooksData = client.getBooks();
    // client.getBooks().then((it) => logger.i(it));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: ListView(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    splashColor: Colors.red,
                    icon:const Icon(
                      Icons.favorite,
                      size: 30,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Get.to(()=>const FavoriteScreen());
                    },
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, bottom: 5.0, left: 15.0, right: 15.0),
              child: Row(
                children: [
                  Text(
                    'داستان های کوتاه',
                    style: GoogleFonts.tinos(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                children: [
                  Text(
                    'بهترین و بروزترین داستان های کوتاه',
                    style: GoogleFonts.tinos(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: CustomSearchBar(),
            ),
            const SizedBox(height: 10.0),
            const Divider(indent: 8.0, endIndent: 8.0, height: 10.0),
            SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                child: FutureBuilder<List<Book>>(
                    future: getBooksData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            childAspectRatio: 0.70,
                          ),
                          itemCount:
                              snapshot.data == null ? 0 : snapshot.data!.length,
                          primary: false,
                          itemBuilder: (context, index) {
                            return GridviewItem(
                              book: snapshot.data![index],
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            'از وصل بودن اینترنت اطمینان حاصل شوید!',
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })),
          ],
        ),
      ),
    );
  }
}
