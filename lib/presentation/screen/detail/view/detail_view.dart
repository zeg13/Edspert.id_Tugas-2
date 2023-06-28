import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/data/data_source/remote_data_source/book_remote_data_source.dart';
import 'package:project_2/data/repository/book_repository_impl.dart';
import 'package:project_2/domain/use_case/get_detail_book_use_case.dart';
import 'package:project_2/presentation/screen/detail/controller/detail_controller.dart';

class DetailView extends StatelessWidget {
  final String isbn13;
  DetailView({super.key, required this.isbn13});

  final detailController = DetailController(
    getDetailBookUseCase: GetDetailBookUseCase(
      repository: BookRepositoryImpl(
        remoteDataSource: BookRemoteDataSource(client: Dio()),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 221, 237),
      appBar: AppBar(
        title: const Text('Detail Book'),
        backgroundColor: const Color.fromARGB(255, 28, 39, 74),
        elevation: 0.0,
      ),
      body: GetBuilder<DetailController>(
          init: detailController,
          initState: (state) => detailController.getDetailBook(isbn13),
          builder: (state) {
            if (state.detailState.value.isloading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: Image.network(state.detailBook.value.image ?? "-"),
                    ),
                    Text(
                      state.detailBook.value.title ?? 'No Title',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(state.detailBook.value.subtitle ?? 'No Subtitle',
                        textAlign: TextAlign.center),
                    Text(
                      'Author : ${state.detailBook.value.authors ?? 'No Author'}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Publisher : ${state.detailBook.value.publisher ?? 'No Publisher'}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Language : ${state.detailBook.value.language ?? 'No Language'}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'ISBN10 : ${state.detailBook.value.isbn10 ?? 'No isbn10'}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'ISBN13 : ${state.detailBook.value.isbn13 ?? 'No isbn13'}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Page : ${state.detailBook.value.pages ?? 'No Pages'}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Year : ${state.detailBook.value.year ?? 'No Year'}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Rating : ${state.detailBook.value.rating ?? 'No Rating'}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(state.detailBook.value.desc ?? 'No Desc',
                        textAlign: TextAlign.center),
                    Text(
                      state.detailBook.value.price ?? 'No Price',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
