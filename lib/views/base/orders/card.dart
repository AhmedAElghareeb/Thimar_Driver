import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thimar_driver/features/home/home_model.dart';

import '../../../core/logic/helper_methods.dart';
import '../../../features/orders/model.dart';
import 'order_details.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key,
    required this.item, this.model, this.address,
  });

  final DriverOrdersModel item;

  final PendingOrdersModel? model;
  final Address? address;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          OrderDetails(
            id: item.id,
            model: model!,
            address: address!,
          ),
        );
      },
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          vertical: 10.h,
          horizontal: 14.w,
        ),
        margin: EdgeInsetsDirectional.symmetric(
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          borderRadius:
          BorderRadiusDirectional.circular(
            15.r,
          ),
          color: Colors.black.withOpacity(
            0.005,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 2.r,
              blurStyle: BlurStyle.inner,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "طلب رقم : # ${item.id}",
                  style: TextStyle(
                      fontSize: 17.sp,
                      color: getMaterialColor(),
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 95.w,
                  height: 23.h,
                  padding:
                  EdgeInsetsDirectional.symmetric(
                    horizontal: 11.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadiusDirectional
                        .circular(
                      7.r,
                    ),
                    color: getOrderStatusColor(
                        item.status),
                  ),
                  child: Center(
                    child: Text(
                      getOrderStatus(
                        item.status,
                      ),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: getOrderStatusTextColor(
                            item.status
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              item.date,
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
                    borderRadius:
                    BorderRadiusDirectional
                        .circular(
                      8.r,
                    ),
                  ),
                  margin: EdgeInsetsDirectional.only(
                    end: 10.w,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    item.clientImage,
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
                        item.clientName,
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
                          Expanded(
                            flex: 2,
                            child: Text(
                              item.location,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight:
                                FontWeight.w300,
                                color: const Color(
                                  0xff9A9A9A,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            const Divider(
              color: Color(0xffE4E4E4),
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ...List.generate(
                      item.images.length,
                          (index) => Container(
                        width: 25.w,
                        height: 25.h,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadiusDirectional
                              .circular(7.r),
                          border: Border.all(
                            color: const Color(
                              0xff61B80C,
                            ).withOpacity(0.06),
                          ),
                        ),
                        margin: EdgeInsetsDirectional
                            .only(end: 3.w),
                        child: Image.network(
                          item.images[index].url,
                          width: 25.w,
                          height: 25.h,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    if (item.images.length > 3)
                      Container(
                        width: 25.w,
                        height: 25.h,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadiusDirectional
                              .circular(7.r),
                          color: getMaterialColor()
                              .withOpacity(0.13),
                        ),
                        child: Center(
                          child: Text(
                            "+${item.images.length - 3}",
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight:
                              FontWeight.bold,
                              color:
                              getMaterialColor(),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  "${item.totalPrice} ر.س",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15.sp,
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