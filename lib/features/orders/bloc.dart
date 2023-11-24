import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/dio_helper.dart';
import 'package:thimar_driver/features/orders/events.dart';
import 'package:thimar_driver/features/orders/model.dart';
import 'package:thimar_driver/features/orders/search_model.dart';
import 'package:thimar_driver/features/orders/states.dart';

class OrdersBloc extends Bloc<OrdersEvents, OrdersStates> {
  OrdersBloc() : super(OrdersStates()) {
    on<GetOrdersDataEvent>(getData);
    on<GetSearchData>(getSearch);
  }

  final searchController = TextEditingController();

  Future<void> getData(
      GetOrdersDataEvent event, Emitter<OrdersStates> emit) async {
    emit(
      GetOrdersDataLoadingState(),
    );

    final response = await DioHelper().getFromServer(
      url: "driver/${event.type}",
    );

    if (response.success) {
      final data = DriverOrdersData.fromJson(response.response!.data).data;
      emit(
        GetOrdersDataSuccessState(
          data: data,
        ),
      );
    } else {
      emit(
        GetOrdersDataFailedState(),
      );
    }
  }

  Future<void> getSearch(
      GetSearchData event, Emitter<OrdersStates> emit) async {
    final response = await DioHelper().getFromServer(
      url: "driver/search_current",
      params: {
        "keyword": searchController.text,
      },
    );

    if (response.success) {
      final data = OrdersSearchData.fromJson(response.response!.data).data;
      emit(
        GetSearchDataSuccessState(
          data: data,
        ),
      );
    } else {
      emit(
        GetSearchDataFailedState(),
      );
    }
  }
}
