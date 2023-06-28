import 'package:get/get.dart';
import 'package:project_2/data/model/search_response_model.dart';
import 'package:project_2/domain/use_case/get_search_use_case.dart';
import 'package:project_2/presentation/state/viev_state.dart';

class SearchsController extends GetxController {
  final GetSearchUseCase getSearchUseCase;

  SearchsController({required this.getSearchUseCase});

  Rx<SearchResponse> listBooks = Rx(SearchResponse());
  Rx<ViewState> searchState = Rx(ViewState.initial);

  void getSearchBook(String search, int page) async {
    searchState(ViewState.loading);
    update();

    final listBooksx = await getSearchUseCase.call(search, page);
    listBooks(listBooksx);
    searchState(ViewState.success);
    update();
  }
}
