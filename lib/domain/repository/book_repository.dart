import 'package:project_2/data/model/book_detail_response.dart';
import 'package:project_2/data/model/search_response_model.dart';

abstract class BookRepository {
  Future<BookDetailResponse> getDetailBook(String isbn130);
  Future<SearchResponse> getSearchBook(String search, int page);
}
