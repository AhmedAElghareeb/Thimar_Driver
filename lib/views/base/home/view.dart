import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/design/app_input.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/home/events.dart';
import 'package:thimar_driver/features/home/states.dart';
import 'package:thimar_driver/views/base/orders/order_details.dart';

import '../../../features/home/bloc.dart';
import '../../../features/home/home_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final searchBloc = KiwiContainer().resolve<HomeBloc>();

  final pendingBloc = KiwiContainer().resolve<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w,
            vertical: 26.h,
          ),
          child: Column(
            children: [
              AppInput(
                controller: searchBloc.searchController,
                isFilled: true,
                labelText: "ابحث عن ما تريد ؟",
                prefixIcon: "assets/icons/Search.svg",
                onChanged: (value) {
                  searchBloc.add(
                    GetSearchDataEvent(
                      keyWord: value.toString(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 26.h,
              ),
              Expanded(
                child: BlocBuilder(
                  bloc: pendingBloc
                    ..add(
                      GetPendingOrdersDataEvent(),
                    ),
                  builder: (context, state) {
                    if (state is GetPendingOrdersDataLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetPendingOrdersDataSuccessState) {
                      return ListView.builder(
                        itemBuilder: (context, index) => HomeItems(
                          model: state.data[index],
                          address: state.data[index].address,
                        ),
                        itemCount: state.data.length,
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
      ),
    );
  }
}

class HomeItems extends StatelessWidget {
  const HomeItems({
    super.key,
    required this.model,
    required this.address,
  });

  final PendingOrdersModel model;
  final Address address;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          OrderDetails(
            id: model.id,
            model: model,
            address: address,
          ),
        );
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(bottom: 16.h),
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 14.w,
          vertical: 4.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(
            15.r,
          ),
          color: const Color(0xff707070).withOpacity(0.05),
        ),
        height: 162.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "طلب رقم : # ${model.id}",
                  style: TextStyle(
                      fontSize: 17.sp,
                      color: getMaterialColor(),
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 95.w,
                  height: 23.h,
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 11.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(
                      7.r,
                    ),
                    color: getOrderStatusColor(model.status).withOpacity(
                      0.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      getOrderStatus(model.status),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: getOrderStatusTextColor(model.status),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "تاريخ الطلب : ${model.date}",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: const Color(
                  0xff9C9C9C,
                ),
              ),
            ),
            const Divider(
              color: Color(0xffE4E4E4),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(
                      8.r,
                    ),
                  ),
                  margin: EdgeInsetsDirectional.only(
                    end: 10.w,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    model.clientImage,
                    width: 46.w,
                    height: 41.h,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.clientName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: getMaterialColor(),
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/location.svg",
                            width: 12.w,
                            height: 14.h,
                            fit: BoxFit.scaleDown,
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          Flexible(
                            child: Text(
                              address.location,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300,
                                color: const Color(
                                  0xff9A9A9A,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              color: Color(0xffE4E4E4),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ...List.generate(
                      model.images.length,
                      (index) => Container(
                        width: 25.w,
                        height: 25.h,
                        margin: EdgeInsetsDirectional.only(end: 3.w),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(
                            7.r,
                          ),
                        ),
                        child: Image.network(
                          model.images[index].url,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    if (model.images.length > 3)
                      Container(
                        width: 25.w,
                        height: 25.h,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(7.r),
                          color: getMaterialColor().withOpacity(0.13),
                        ),
                        child: Center(
                          child: Text(
                            "+${model.images.length - 3}",
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: getMaterialColor(),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  "${model.totalPrice} ر.س",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: getMaterialColor(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60.h,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 10.w,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/images/center.svg",
              width: 21.w,
              height: 21.h,
              fit: BoxFit.scaleDown,
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              "سلة ثمار",
              style: TextStyle(
                fontSize: 14.sp,
                color: getMaterialColor(),
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: "الرئيسية",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: getMaterialColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
