import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/core/design/app_button.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/authentication/bloc.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:thimar_driver/features/authentication/events.dart';
import 'package:thimar_driver/features/authentication/states.dart';
import 'package:thimar_driver/views/auth/forget_password.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:thimar_driver/views/auth/login.dart';

class CheckCodeScreen extends StatefulWidget {
  final String pageName, phone;

  const CheckCodeScreen(
      {super.key, required this.pageName, required this.phone});

  @override
  State<CheckCodeScreen> createState() => _CheckCodeScreenState();
}

class _CheckCodeScreenState extends State<CheckCodeScreen> {
  final _bloc = KiwiContainer().resolve<AuthenticationBloc>();
  final _resendCodeBloc = KiwiContainer().resolve<AuthenticationBloc>();
  final _formKey = GlobalKey<FormState>();
  bool _isTimerRunning = true;

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
    _resendCodeBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final timerController = CountDownController()..start();
    return Scaffold(
        body: SafeArea(
            child: ListView(padding: EdgeInsets.all(16.r), children: [
      Column(children: [
        SvgPicture.asset("assets/images/center.svg",
            height: 150.h, width: 150.w),
        Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Text(
                widget.pageName == 'check'
                    ? "Forget Password"
                    : "Active Account",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold))),
        SizedBox(height: 8.h),
        Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Text("Write code contain 4 digits",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).hintColor))),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              "${widget.phone}+",
              style: TextStyle(
                fontSize: 15.sp,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(width: 5.w),
            GestureDetector(
              onTap: () {
                navigateTo(
                  const ForgetPasswordView(),
                );
              },
              child: Text(
                "Check code change phone number",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 27.h),
        Form(
          key: _formKey,
          child: PinCodeTextField(
            validator: (value) {
              if (value!.isEmpty || value.length < 4) {
                return "Enter Code";
              }
              return null;
            },
            appContext: context,
            controller: _bloc.codeController,
            length: 4,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              selectedColor: Theme.of(context).primaryColor,
              inactiveColor: Theme.of(context).unselectedWidgetColor,
              borderRadius: BorderRadius.circular(15.r),
              fieldHeight: 60.h,
              fieldWidth: 70.w,
              activeFillColor: Colors.white,
            ),
            cursorColor: Theme.of(context).primaryColor,
            animationDuration: const Duration(milliseconds: 300),
            keyboardType: TextInputType.number,
            onChanged: (value) {},
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        BlocConsumer(
            listener: (context, state) {
              if (state is CheckCodeSuccessState) {
                // navigateTo(
                //   ResetPasswordScreen(
                //     phone: widget.phone,
                //     code: _bloc.codeController.text,
                //   ),
                // );
              }
            },
            bloc: _bloc,
            builder: (context, state) => AppButton(
                isLoading: state is CheckCodeLoadingState,
                text: "Confirm Code",
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    _bloc.add(PostCheckCodeDataEvent(
                        context: context, phone: widget.phone));
                  }
                })),
        SizedBox(
          height: 34.h,
        ),
        if (_isTimerRunning)
          Column(
            children: [
              Text(
                "Resend Code",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              Text(
                "Resend",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              StatefulBuilder(
                builder: (BuildContext context,
                        void Function(void Function()) setState2) =>
                    CircularCountDownTimer(
                  controller: timerController,
                  duration: 120,
                  width: 66.w,
                  height: 70.h,
                  ringColor: Theme.of(context).unselectedWidgetColor,
                  ringGradient: null,
                  fillColor: Theme.of(context).primaryColor,
                  fillGradient: null,
                  backgroundColor: Colors.transparent,
                  backgroundGradient: null,
                  strokeWidth: 2.w,
                  isReverse: true,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(
                    fontSize: 21.sp,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  onComplete: () {
                    _isTimerRunning = false;
                    setState(() {});
                  },
                  textFormat: CountdownTextFormat.MM_SS,
                  timeFormatterFunction: (defaultFormatterFunction, duration) {
                    if (duration.inSeconds == 0) {
                      return "0";
                    } else {
                      return Function.apply(
                          defaultFormatterFunction, [duration]);
                    }
                  },
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        if (!_isTimerRunning)
          BlocBuilder(
              bloc: _resendCodeBloc,
              builder: (context, state) {
                return AppButton(
                  isLoading: state is ResendCodeLoadingState,
                  text: "Resend",
                  width: 133.w,
                  onPress: () {
                    _isTimerRunning = true;
                    setState(() {});
                    timerController.restart(duration: 120);
                    _resendCodeBloc.add(PostResendCodeDataEvent(
                        phone: widget.phone, context: context));
                  },
                );
              }),
      ]),
      // SizedBox(height: 48.h),
      // Center(
      //     child: RichText(
      //         text: TextSpan(
      //             style: TextStyle(color: Theme.of(context).primaryColor),
      //             children: <TextSpan>[
      //       TextSpan(
      //           text:
      //               "${"Have An Account? "}\t",
      //           style: TextStyle(
      //             fontSize: 15.sp,
      //             color: Theme.of(context).primaryColor,
      //           )),
      //       TextSpan(
      //           recognizer: TapGestureRecognizer()
      //             ..onTap = () => navigateTo(
      //                   const LoginView(),
      //                 ),
      //           text: "Login",
      //           style: const TextStyle(
      //             fontWeight: FontWeight.bold,
      //           ))
      //     ])))
    ])));
  }
}
