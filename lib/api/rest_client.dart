import 'package:dio/dio.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/models/temp_book.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'http://10.0.2.2:8000/api/v1/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("get-all-data")
  Future<List<Book>> getBooks();

  @GET("search/?text={id}")
  Future<List<Book>> getSearchs(@Path("id") String id);

  @PUT("update-fav-data/{id}/")
  Future<Book> updateFav(@Path() int id, @Body() TempBook tempBook);

  @GET("get-fav-data")
  Future<List<Book>> getFavBooks();
}
