import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/orders/bloc.dart';
import 'package:thimar_driver/features/orders/events.dart';
import 'package:thimar_driver/features/orders/states.dart';

import '../../../core/design/app_input.dart';
import 'card.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final bloc = KiwiContainer().resolve<OrdersBloc>();
  String type = "current_orders";

  void _init() {
    bloc.add(
      GetOrdersDataEvent(
        type: type,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("طلباتي"),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 55.h,
              width: 343.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(10.r),
                border: Border.all(
                  color: const Color(
                    0xff000000,
                  ).withOpacity(
                    0.16,
                  ),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      type = 'current_orders';
                      setState(() {});
                      _init();
                    },
                    child: Container(
                      height: 42.h,
                      width: 165.w,
                      decoration: BoxDecoration(
                          color: type == 'current_orders'
                              ? getMaterialColor()
                              : null,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Center(
                        child: Text(
                          "الحالية",
                          style: TextStyle(
                            color: type == 'current_orders'
                                ? Colors.white
                                : const Color(
                                    0xffA2A1A4,
                                  ),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      type = 'finished_orders';
                      setState(() {});
                      _init();
                    },
                    child: Container(
                      height: 42.h,
                      width: 165.w,
                      decoration: BoxDecoration(
                          color: type == 'finished_orders'
                              ? getMaterialColor()
                              : null,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Center(
                        child: Text(
                          "المنتهية",
                          style: TextStyle(
                            color: type == 'finished_orders'
                                ? Colors.white
                                : const Color(
                                    0xffA2A1A4,
                                  ),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 17.h,
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
              child: AppInput(
                controller: bloc.searchController,
                isFilled: true,
                labelText: "ابحث عن ما تريد ؟",
                prefixIcon: "assets/icons/Search.svg",
                onChanged: (value) {
                  bloc.add(
                    GetSearchData(
                      keyWord: value.toString(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 17.h,
            ),
            Expanded(
              child: BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is GetOrdersDataLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetOrdersDataSuccessState) {
                    return state.data.isEmpty
                        ? const Center(
                            child: Text("لا يوجد بيانات"),
                          )
                        : ListView.separated(
                            scrollDirection: Axis.vertical,
                            itemCount: state.data.length,
                            padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 16.w,
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(),
                            itemBuilder: (context, index) {
                              final item = state.data[index];
                              return ItemCard(
                                item: item,
                              );
                            },
                          );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }
}
