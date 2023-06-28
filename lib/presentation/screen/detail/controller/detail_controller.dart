import 'package:get/get.dart';
import 'package:project_2/data/model/book_detail_response.dart';
import 'package:project_2/domain/use_case/get_detail_book_use_case.dart';
import 'package:project_2/presentation/state/viev_state.dart';

class DetailController extends GetxController {
  final GetDetailBookUseCase getDetailBookUseCase;

  DetailController({required this.getDetailBookUseCase});

  Rx<ViewState> detailState = Rx(ViewState.initial);
  Rx<BookDetailResponse> detailBook = Rx(BookDetailResponse());

  void getDetailBook(String isbn13) async {
    detailState.value = ViewState.loading;
    update();

    final result = await getDetailBookUseCase.call(isbn13);
    detailBook.value = result;
    detailState.value = ViewState.success;
    update();
  }
}
