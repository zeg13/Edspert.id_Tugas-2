import 'package:project_2/data/model/search_response_model.dart';
import 'package:project_2/domain/repository/book_repository.dart';

class GetSearchUseCase {
  final BookRepository repository;

  const GetSearchUseCase({required this.repository});

  Future<SearchResponse> call(String search, int page) async =>
      await repository.getSearchBook(search, page);
}
