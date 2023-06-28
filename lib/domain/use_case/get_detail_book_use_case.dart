import 'package:project_2/data/model/book_detail_response.dart';
import 'package:project_2/domain/repository/book_repository.dart';

class GetDetailBookUseCase {
  final BookRepository repository;

  const GetDetailBookUseCase({required this.repository});

  Future<BookDetailResponse> call(String isbn13) async =>
      await repository.getDetailBook(isbn13);
}
