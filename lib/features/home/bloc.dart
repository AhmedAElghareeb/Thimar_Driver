import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/features/home/events.dart';
import 'package:thimar_driver/features/home/states.dart';

import '../../core/logic/dio_helper.dart';
import 'search_model.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  HomeBloc(this.dioHelper) : super(HomeStates()) {
    on<GetSearchDataEvent>(getSearch);
  }
  final DioHelper dioHelper;
  final searchController = TextEditingController();

  Future<void> getSearch(
      GetSearchDataEvent event, Emitter<HomeStates> emit) async {
    final response =
        await dioHelper.getFromServer(url: "driver/search", params: {
      "keyword": searchController.text,
    });

    if (response.success) {
      final data = HomeSearchData.fromJson(response.response!.data).data;
      emit(
        GetSearchDataSuccessState(
          data: data,
        ),
      );
    }
  }
}
