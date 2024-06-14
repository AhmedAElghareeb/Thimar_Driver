import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:thimar_driver/core/design/app_bar.dart';
import 'package:thimar_driver/core/design/app_button.dart';
import 'package:thimar_driver/features/home/home_model.dart';
import '../../../core/logic/helper_methods.dart';

class OrderPendingDetails extends StatefulWidget {
  const OrderPendingDetails({
    super.key,
    required this.id,
    required this.model
  });

  final int id;
  final PendingOrdersModel model;

  @override
  State<OrderPendingDetails> createState() => _OrderPendingDetailsState();
}

class _OrderPendingDetailsState extends State<OrderPendingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: "طلب رقم : # ${widget.id}",
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w,
            vertical: 20.h,
          ),
          children: [
            Text(
              "تفاصيل الطلب",
              style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: 19.h,
            ),
            Container(
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
                        "طلب رقم : # ${widget.model.id}",
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
                          color: getOrderStatusColor(
                            widget.model.status,
                          ).withOpacity(
                            0.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            getOrderStatus(
                              widget.model.status,
                            ),
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: getOrderStatusTextColor(
                                widget.model.status,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "تاريخ الطلب : ${widget.model.date}",
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
                          widget.model.clientImage,
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
                              widget.model.clientName,
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
                                    widget.model.address.location,
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
                            widget.model.images.length,
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
                                widget.model.images[index].url,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          if (widget.model.images.length > 3)
                            Container(
                              width: 25.w,
                              height: 25.h,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadiusDirectional.circular(7.r),
                                color: getMaterialColor().withOpacity(0.13),
                              ),
                              child: Center(
                                child: Text(
                                  "+${widget.model.images.length - 3}",
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
                        "${widget.model.totalPrice} ر.س",
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
            SizedBox(
              height: 16.h,
            ),
            Text(
              "عنوان التوصيل",
              style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: 13.h,
            ),
            Container(
              width: 343.w,
              height: 150.h,
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 15.w,
                vertical: 15.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(
                  15.r,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 17.r,
                    blurStyle: BlurStyle.outer,
                    offset: Offset(
                      0.w,
                      6.h,
                    ),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.model.address.type,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "العنوان : ${widget.model.address.location}",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            color: const Color(
                              0xff000000,
                            ).withOpacity(0.2),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "رقم الجوال : ${widget.model.address.phone}",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            color: const Color(
                              0xff000000,
                            ).withOpacity(0.2),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "الوصف : ${widget.model.address.description}",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            color: const Color(
                              0xff000000,
                            ).withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 72.w,
                    height: 62.h,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(
                        15.r,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        openMap(
                          title: widget.model.address.location,
                          lat: widget.model.address.lat,
                          long: widget.model.address.lng,
                        );
                      },
                      child: SvgPicture.asset(
                        "assets/icons/map.svg",
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              "ملخص الطلب",
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            Container(
              width: 342.w,
              height: 160.h,
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 16.w,
                vertical: 9.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(
                  13.r,
                ),
                color: const Color(
                  0xffF3F8EE,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "إجمالي المنتجات",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        "${widget.model.totalPrice} ر.س",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "سعر التوصيل",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        "${widget.model.deliveryPrice} ر.س",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "المجموع",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        "${widget.model.totalPrice! + widget.model.deliveryPrice} ر.س",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "تم الدفع بواسطة",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Text(
                        widget.model.payType,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 85.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  onPress: () {},
                  text: "قبول",
                  width: 163.w,
                  height: 60.h,
                ),
                AppButton(
                  onPress: () {},
                  text: "رفض",
                  width: 163.w,
                  height: 60.h,
                  backColor: const Color(0xffFF0000),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> openMap({String? title, lat, long}) async {
  final availableMaps = await MapLauncher.installedMaps;
  await availableMaps.first.showMarker(
    coords: Coords(
      lat,
      long,
    ),
    title: title!,
  );
}
