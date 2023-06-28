import 'package:dio/dio.dart';
import 'package:project_2/data/model/book_detail_response.dart';
import 'package:project_2/data/model/search_response_model.dart';

class BookRemoteDataSource {
  final Dio client;
  const BookRemoteDataSource({required this.client});

  Future<SearchResponse> getSearchBook(String search, int page) async {
    try {
      final url = 'https://api.itbook.store/1.0/search/$search/$page';
      final response = await client.get(url);
      SearchResponse decodedResponse = SearchResponse.fromJson(response.data);

      return decodedResponse;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return SearchResponse();
    }
  }

  Future<BookDetailResponse> getDetailBook(String isbn13) async {
    try {
      final url = 'https://api.itbook.store/1.0/books/$isbn13';
      final response = await client.get(url);
      BookDetailResponse decodedResponse =
          BookDetailResponse.fromJson(response.data);

      return decodedResponse;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return BookDetailResponse();
    }
  }
}
