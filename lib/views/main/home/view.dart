import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/design/app_input.dart';
import 'package:thimar_driver/core/logic/cache_helper.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/home/events.dart';

import '../../../features/home/bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final searchBloc = KiwiContainer().resolve<HomeBloc>();

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
                child: ListView.builder(
                  itemBuilder: (context, index) => const HomeItems(),
                  itemCount: 5,
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 16.h),
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 14.w,
        vertical: 4.h,
      ),
      // clipBehavior: Clip.antiAlias,
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
                "طلب رقم : # رقم الطلب",
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
                  color: getMaterialColor().withOpacity(
                    0.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    "حالة الطلب",
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
            "تاريخ الطلب",
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
                  CacheHelper.getImage(),
                  width: 46.w,
                  height: 41.h,
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                children: [
                  Text(
                    "اسم العميل",
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
                      Text(
                        "العنوان",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                          color: const Color(
                            0xff9A9A9A,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
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
                    3,
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
                        CacheHelper.getImage(),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  // if (item.products.length > 3)
                  //   Container(
                  //     width: 25.w,
                  //     height: 25.h,
                  //     clipBehavior:
                  //     Clip.antiAlias,
                  //     decoration: BoxDecoration(
                  //       borderRadius:
                  //       BorderRadiusDirectional
                  //           .circular(7.r),
                  //       color: getMaterialColor()
                  //           .withOpacity(0.13),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         "+${item.products.length - 3}",
                  //         style: TextStyle(
                  //           fontSize: 11.sp,
                  //           fontWeight:
                  //           FontWeight.bold,
                  //           color: getMaterialColor(),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
              Text(
                "سعر الطلب",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: getMaterialColor()),
              ),
            ],
          )
        ],
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
