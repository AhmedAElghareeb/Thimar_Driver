import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/notifications/bloc.dart';
import 'package:thimar_driver/features/notifications/events.dart';
import 'package:thimar_driver/features/notifications/model.dart';
import 'package:thimar_driver/features/notifications/states.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final bloc = KiwiContainer().resolve<NotificationsBloc>()
    ..add(
      GetNotificationsEvent(),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "الإشعارات",
        ),
      ),
      body: SafeArea(
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is NotificationsLoadingState) {
              return const Center(child: CircularProgressIndicator(),);
            } else if (state is NotificationsSuccessState) {
              return ListView.builder(
                itemBuilder: (context, index) => _Item(
                  model: state.notifications[index],
                ),
                itemCount: state.notifications.length,
              );
            } else {
              return const SizedBox.shrink();
            }
          },
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

class _Item extends StatelessWidget {
  const _Item({
    required this.model,
  });

  final NotificationsModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 10.h),
      padding: EdgeInsetsDirectional.only(start: 10.w, top: 10.h),
      height: 80.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(
            15.r,
          ),
          color: Colors.grey[100],
      ),
      child: Row(
        children: [
          Image.network(
            model.image,
            width: 33.w,
            height: 33.h,
            fit: BoxFit.scaleDown,
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: getMaterialColor()
                ),
              ),
              Text(
                model.body,
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xff989898,),
                ),
              ),
              Text(
                model.createdAt,
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                    color: getMaterialColor()
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
