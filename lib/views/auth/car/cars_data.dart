import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/features/authentication/bloc.dart';
import 'package:thimar_driver/features/authentication/cars_model.dart';
import 'package:thimar_driver/features/authentication/events.dart';
import 'package:thimar_driver/features/authentication/states.dart';

class CarsData extends StatefulWidget {
  const CarsData({super.key});

  @override
  State<CarsData> createState() => _CarsDataState();
}

class _CarsDataState extends State<CarsData> {
  final bloc = KiwiContainer().resolve<AuthenticationBloc>()
    ..add(
      GetCarsDataEvent(),
    );

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          return Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "اختر موديل",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is GetCarsDataLoadingState) {
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is GetCarsDataSuccessState) {
                      return Expanded(
                        child: ListView.builder(
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          itemBuilder: (context, index) => _Item(
                            model: state.data[index],
                          ),
                          itemCount: state.data.length,
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          );
        }
    );
  }
}


class _Item extends StatelessWidget {
  const _Item({required this.model});

  final CarsModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, model);
      },
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 8.w,
          vertical: 8.h,
        ),
        margin: EdgeInsetsDirectional.only(
          bottom: 10.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(7.r),
          color: Theme.of(context).primaryColor.withOpacity(
            0.04,
          ),
        ),
        child: Center(
          child: Text(
            model.name,
          ),
        ),
      ),
    );
  }
}

