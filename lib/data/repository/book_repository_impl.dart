import 'package:project_2/data/data_source/remote_data_source/book_remote_data_source.dart';
import 'package:project_2/data/model/book_detail_response.dart';
import 'package:project_2/data/model/search_response_model.dart';
import 'package:project_2/domain/repository/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;

  const BookRepositoryImpl({required this.remoteDataSource});

  @override
  Future<BookDetailResponse> getDetailBook(String isbn13) async =>
      await remoteDataSource.getDetailBook(isbn13);

  @override
  Future<SearchResponse> getSearchBook(String search, int page) async =>
      await remoteDataSource.getSearchBook(search, page);
}
