import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiwi/kiwi.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:thimar_driver/core/design/app_bar.dart';
import 'package:thimar_driver/core/design/app_button.dart';
import 'package:thimar_driver/core/design/app_input.dart';
import 'package:thimar_driver/features/orders/accept_order/bloc.dart';
import 'package:thimar_driver/features/orders/bloc.dart';
import 'package:thimar_driver/features/orders/events.dart';
import 'package:thimar_driver/features/orders/finish_deliver/bloc.dart';
import 'package:thimar_driver/features/orders/refuse_order/bloc.dart';
import 'package:thimar_driver/features/orders/start_deliver/bloc.dart';
import 'package:thimar_driver/features/orders/states.dart';
import 'package:thimar_driver/views/base/home_nav_bar.dart';
import '../../../core/logic/helper_methods.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({
    super.key,
    required this.id, required this.fromWhere,
  });

  final int id;
  final String fromWhere;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final bloc = KiwiContainer().resolve<OrdersBloc>();
  final _refuseBloc = KiwiContainer().resolve<RefuseOrderBloc>();
  final _acceptBloc = KiwiContainer().resolve<AcceptOrderBloc>();
  final _startDeliver = KiwiContainer().resolve<StartDeliverBloc>();
  final _finishDeliver = KiwiContainer().resolve<FinishDeliverBloc>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bloc.add(
      GetOrderDetailsDataEvent(
        widget.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: "طلب رقم : # ${widget.id}",
      ),
      body: SafeArea(
        child: BlocConsumer(
          bloc: bloc,
          listener: (context, state) {
            if (state is GetOrdersDetailsDataLoadingState) {
              const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          builder: (context, state) {
            if (state is GetOrdersDetailsDataSuccessState) {
              var item = state.model;
              return ListView(
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
                      vertical: 16.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(
                        15.r,
                      ),
                      color: const Color(0xff707070).withOpacity(0.05),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 11.w,
                                vertical: 5.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(
                                  7.r,
                                ),
                                color: getOrderStatusColor(
                                  item.status,
                                ).withOpacity(
                                  0.5,
                                ),
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
                                      item.status,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "تاريخ الطلب : ${item.date}",
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
                                      Flexible(
                                        child: Text(
                                          item.location,
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
                                  item.images.length,
                                  (index) => Container(
                                    width: 25.w,
                                    height: 25.h,
                                    margin:
                                        EdgeInsetsDirectional.only(end: 3.w),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(
                                        7.r,
                                      ),
                                    ),
                                    child: Image.network(
                                      item.images[index].url,
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
                                          BorderRadiusDirectional.circular(7.r),
                                      color:
                                          getMaterialColor().withOpacity(0.13),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "+${item.images.length - 3}",
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
                              "${item.totalPrice} ر.س",
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
                                item.address.type,
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
                                "العنوان : ${item.address.location}",
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
                                "رقم الجوال : ${item.address.phone}",
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
                                "الوصف : ${item.address.description}",
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
                                title: item.address.location,
                                lat: item.address.lat,
                                long: item.address.lng,
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
                              "${item.totalPrice} ر.س",
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
                              "${item.deliveryPrice} ر.س",
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
                              "${item.totalPrice + item.deliveryPrice} ر.س",
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
                              item.payType,
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
                    height: 20.h,
                  ),
                  item.status == "pending"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //accept order button
                            BlocBuilder(
                              buildWhen: (previous, current) =>
                                  current is SuccessAcceptState,
                              bloc: _acceptBloc,
                              builder: (context, state) {
                                return AppButton(
                                  onPress: () {
                                    _acceptBloc.add(
                                      StartAcceptOrderEvent(id: widget.id),
                                    );
                                    navigateTo(
                                      OrderDetails(
                                        id: item.id,
                                        fromWhere: widget.fromWhere,
                                      ),
                                    );
                                  },
                                  isLoading: state is LoadingAcceptState,
                                  text: "قبول",
                                  width: 163.w,
                                  height: 60.h,
                                );
                              },
                            ),
                            //refuse order button
                            BlocConsumer(
                              bloc: _refuseBloc,
                              listener: (context, state) {
                                if (state is SuccessState) {
                                  pop();
                                }
                              },
                              builder: (context, state) {
                                return AppButton(
                                  onPress: () {
                                    _refuseBloc.add(
                                      StartRefuseOrderEvent(
                                        id: widget.id,
                                      ),
                                    );
                                  },
                                  isLoading: state is LoadingState,
                                  text: "رفض",
                                  width: 163.w,
                                  height: 60.h,
                                  backColor: const Color(0xffFF0000),
                                );
                              },
                            ),
                          ],
                        )
                      : item.status == "accepted"
                          ? BlocConsumer(
                              bloc: _startDeliver,
                              listener: (context, state) {
                                if (state is SuccessStartDeliverState) {
                                  bloc.add(GetOrderDetailsDataEvent(item.id));
                                  setState(() {});
                                }
                              },
                              builder: (context, state) {
                                return AppButton(
                                  onPress: () {
                                    _startDeliver
                                        .add(FirstStartDeliver(id: item.id));
                                  },
                                  text: "بدء التوصيل",
                                  isLoading: state is LoadingStartDeliverState,
                                  width: 343.w,
                                  height: 60.h,
                                );
                              },
                            )
                          : item.status == "in_way"
                              ? BlocConsumer(
                                  bloc: _finishDeliver,
                                  listener: (context, state) {
                                    if (state is SuccessFinishDeliverState) {
                                      navigateTo(const HomeNavBar());
                                    }
                                  },
                                  builder: (context, state) {
                                    return AppButton(
                                      onPress: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) => Container(
                                            padding: EdgeInsetsDirectional.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.r),
                                                topRight: Radius.circular(20.r),
                                              ),
                                            ),
                                            child: SingleChildScrollView(
                                              padding: EdgeInsetsDirectional
                                                  .symmetric(horizontal: 16.w),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    height: 13.h,
                                                  ),
                                                  Text(
                                                    "المبلغ المستحق من العميل",
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 13.h,
                                                  ),
                                                  Text(
                                                    "${item.totalPrice + item.deliveryPrice} ر.س",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 24.sp,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 13.h,
                                                  ),
                                                  Form(
                                                    key: _formKey,
                                                    child: AppInput(
                                                      controller: _finishDeliver
                                                          .clientPaidAmount,
                                                      validator: (val) {
                                                        if (val!.isEmpty) {
                                                          return "من فضلك أدخل المبلغ";
                                                        }
                                                        return null;
                                                      },
                                                      labelText:
                                                          "اكتب المبلغ المستلم من العميل",
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 25.h,
                                                  ),
                                                  AppButton(
                                                    onPress: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        _finishDeliver.add(
                                                          FinishDeliverEvent(
                                                            id: item.id,
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    text: "تأكيد",
                                                    width: 343.w,
                                                    height: 60.h,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      text: "إنهاء الطلب",
                                      width: 343.w,
                                      height: 60.h,
                                    );
                                  },
                                )
                              : const SizedBox.shrink()
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
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
