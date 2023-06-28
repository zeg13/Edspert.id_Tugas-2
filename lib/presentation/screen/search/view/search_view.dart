import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/data/data_source/remote_data_source/book_remote_data_source.dart';
import 'package:project_2/data/repository/book_repository_impl.dart';
import 'package:project_2/domain/use_case/get_search_use_case.dart';
import 'package:project_2/presentation/screen/detail/view/detail_view.dart';
import 'package:project_2/presentation/screen/search/controller/search_controller.dart';

// ignore: must_be_immutable
class SearchView extends StatelessWidget {
  final String search;
  final int page;

  SearchView({super.key, required this.search, required this.page});

  final searchController = SearchsController(
    getSearchUseCase: GetSearchUseCase(
      repository: BookRepositoryImpl(
        remoteDataSource: BookRemoteDataSource(client: Dio()),
      ),
    ),
  );
  int x = 1;
  String y = '1';
  int max = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 221, 237),
      appBar: AppBar(
          title: const Text('Search Books'),
          backgroundColor: const Color.fromARGB(255, 28, 39, 74),
          actions: [
            IconButton(
                onPressed: () {
                  if (x <= 1) {
                  } else {
                    searchController.getSearchBook(search, (x - 1));
                    x = x - 1;
                  }
                },
                icon: const Icon(Icons.arrow_back_ios)),
            IconButton(
                onPressed: () {
                  if (x >= max) {
                  } else {
                    searchController.getSearchBook(search, (x + 1));
                    x = x + 1;
                  }
                },
                icon: const Icon(Icons.arrow_forward_ios)),
          ]),
      body: GetBuilder<SearchsController>(
          init: searchController,
          initState: (state) => searchController.getSearchBook(search, page),
          builder: (state) {
            max = (int.parse(state.listBooks.value.total ?? '0') / 10).ceil();
            y = x.toString();
            if (max == 0) {
              y = 'Not Found';
            }
            if (state.searchState.value.isloading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text('$y / $max'),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 570,
                      width: 400,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: (state.listBooks.value.books ?? []).length,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        itemBuilder: (context, index) {
                          final book =
                              (state.listBooks.value.books ?? [])[index];

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailView(isbn13: book.isbn13 ?? ''),
                                ),
                              );
                            },
                            child: Card(
                              child: ListTile(
                                //padding: const EdgeInsets.all(8.0),
                                title: SingleChildScrollView(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 90,
                                        width: 100,
                                        child: Image.network(
                                            (state.listBooks.value.books ??
                                                        [])[index]
                                                    .image ??
                                                '-'),
                                      ),
                                      SizedBox(
                                        height: 90,
                                        width: 220,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  (state.listBooks.value
                                                                  .books ??
                                                              [])[index]
                                                          .title ??
                                                      'No Title',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  'ISBN13 : ${(state.listBooks.value.books ?? [])[index].isbn13 ?? 'No isbn13'}'),
                                              Text(
                                                  'Price : ${(state.listBooks.value.books ?? [])[index].price ?? '-'}'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
