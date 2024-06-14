import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_driver/core/logic/cache_helper.dart';
import 'package:thimar_driver/core/logic/dio_helper.dart';
import 'package:thimar_driver/core/logic/helper_methods.dart';
import 'package:thimar_driver/features/authentication/cars_model.dart';
import 'package:thimar_driver/features/authentication/login_model.dart';
import 'package:thimar_driver/features/authentication/profile_model.dart';
import 'package:thimar_driver/views/base/home_nav_bar.dart';
import 'city_model.dart';
import 'events.dart';
import 'states.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvents, AuthenticationStates> {
  AuthenticationBloc(this.dioHelper) : super(AuthenticationStates()) {
    on<GetCitiesDataEvent>(cities);
    on<GetCarsDataEvent>(cars);
    on<DriverLoginEvent>(login);
    on<DriverRegisterEvent>(register);
    on<DriverForgetPasswordEvent>(forgetPassword);
    on<DriverLogOutEvent>(logOut);
    on<GetProfileDataEvent>(getProfileData);
    on<PostCheckCodeDataEvent>(_postData);
    on<PostResendCodeDataEvent>(_resendCode);
    on<PostEditProfileDataEvent>(_editProfile);
  }

  File? licenseImage, carFormImage, carInsurance, frontCarImage, backCarImage;

  CityModel? selectedCity;
  CarsModel? selectedCar;
  late int cityId;

  final phController = TextEditingController();
  final passController = TextEditingController();
  final iBanController = TextEditingController();
  final bankNameController = TextEditingController();
  final carTypeController = TextEditingController();
  final carModelController = TextEditingController();

  final DioHelper dioHelper;
  final formKey = GlobalKey<FormState>();

  Future<void> cities(
      GetCitiesDataEvent event, Emitter<AuthenticationStates> emit) async {
    emit(
      GetCitiesDataLoadingState(),
    );

    final response = await dioHelper.getFromServer(
      url: "cities/1",
    );

    if (response.success) {
      final list = List.from(response.response!.data['data'] ?? [])
          .map((e) => CityModel.fromJson(e))
          .toList();
      emit(
        GetCitiesDataSuccessState(
          list: list,
        ),
      );
    } else {
      emit(
        GetCitiesDataFailedState(),
      );
    }
  }

  Future<void> cars(
      GetCarsDataEvent event, Emitter<AuthenticationStates> emit) async {
    emit(
      GetCarsDataLoadingState(),
    );

    final response = await dioHelper.getFromServer(
      url: "car_models",
    );

    if (response.success) {
      final list = CarsData.fromJson(response.response!.data);

      emit(
        GetCarsDataSuccessState(
          data: list.data,
        ),
      );
    } else {
      emit(
        GetCarsDataFailedState(),
      );
    }
  }

  Future<void> login(
      DriverLoginEvent event, Emitter<AuthenticationStates> emit) async {
    emit(
      DriverLoginLoadingState(),
    );

    final response = await dioHelper.sendToServer(url: "login", body: {
      "phone": phController.text,
      "password": passController.text,
      "device_token": FirebaseMessaging.instance.getToken(),
      "type": Platform.operatingSystem,
      "user_type": "driver",
    });

    if (response.success) {
      await CacheHelper.saveLoginData(
        DriverModel.fromJson(
          response.response!.data['data'],
        ),
      );
      showSnackBar(
        response.msg,
        typ: MessageType.success,
      );
      navigateTo(
        const HomeNavBar(),
      );
      emit(
        DriverLoginSuccessState(),
      );
    } else {
      showSnackBar(
        response.msg,
      );
      emit(
        DriverLoginFailedState(),
      );
    }
  }

  Future<void> logOut(
      DriverLogOutEvent event, Emitter<AuthenticationStates> emit) async {
    emit(DriverLogOutLoadingState());
    final response = await DioHelper().sendToServer(url: "logout", body: {
      "device_token": FirebaseMessaging.instance.getToken(),
      "type": Platform.operatingSystem,
    });

    if (response.success) {
      CacheHelper.removeLoginInfo();
      emit(DriverLogOutSuccessState());
      showSnackBar(
        response.msg,
        typ: MessageType.success,
      );
    } else {
      showSnackBar(
        response.msg,
      );
      emit(DriverLogOutFailedState());
    }
  }

  Future<void> forgetPassword(DriverForgetPasswordEvent event,
      Emitter<AuthenticationStates> emit) async {
    emit(
      DriverForgetPasswordLoadingState(),
    );

    final response = await DioHelper().sendToServer(
      url: "forget_password",
      body: {
        "phone": phController.text,
      },
    );

    if (response.success) {
      showSnackBar(
        response.msg,
        typ: MessageType.success,
      );
      emit(
        DriverForgetPasswordSuccessState(),
      );
    } else {
      showSnackBar(
        response.msg,
      );
      emit(
        DriverForgetPasswordFailedState(),
      );
    }
  }

  Future<void> register(
      DriverRegisterEvent event, Emitter<AuthenticationStates> emit) async {
    emit(DriverRegisterLoadingState());
    final response =
        await dioHelper.sendToServer(url: "driver_register", body: {
      "fullname": event.name,
      "phone": event.phone,
      "city_id": cityId,
      "lat": CacheHelper.getLat(),
      "lng": CacheHelper.getLongitude(),
      "location": event.location,
      "identity_number": event.id,
      "email": event.email,
      "password": event.password,
      "password_confirmation": event.confirmPassword,
      "car_licence_image": MultipartFile.fromFileSync(licenseImage!.path,
          filename: licenseImage!.path.split("/").last),
      "car_form_image": MultipartFile.fromFileSync(carFormImage!.path,
          filename: carFormImage!.path.split("/").last),
      "car_insurance_image": MultipartFile.fromFileSync(carInsurance!.path,
          filename: carInsurance!.path.split("/").last),
      "car_front_image": MultipartFile.fromFileSync(frontCarImage!.path,
          filename: frontCarImage!.path.split("/").last),
      "car_back_image": MultipartFile.fromFileSync(backCarImage!.path,
          filename: backCarImage!.path.split("/").last),
      "car_type": carTypeController.text,
      "model_id": carModelController.text,
      "iban": iBanController.text,
      "bank_name": bankNameController.text
    });
    if (response.success) {
      emit(
        DriverRegisterSuccessState(
          context: event.context,
          msg: response.response!.statusMessage ?? "",
        ),
      );
    } else {
      emit(
        DriverRegisterFailedState(
          context: event.context,
          msg: response.response!.statusMessage ?? "",
        ),
      );
    }
  }

  void getProfileData(
      GetProfileDataEvent event, Emitter<AuthenticationStates> emit) async {
    emit(GetProfileLoadingState());

    final response = await dioHelper.getFromServer(
      url: "driver/profile",
    );
    final data = ProfileData.fromJson(response.response!.data);
    if (response.success) {
      emit(
        GetProfileSuccessState(
          data: data,
        ),
      );
    } else {
      emit(
        GetProfileErrorState(
          message: response.msg,
        ),
      );
    }
  }

  final nameController = TextEditingController(text: CacheHelper.getFullName());
  final phoneController = TextEditingController(text: CacheHelper.getPhone());
  final cityController = TextEditingController(text: CacheHelper.getCity());
  final idController = TextEditingController(text: "");
  File? userImage;

  Future<void> _editProfile(PostEditProfileDataEvent event,
      Emitter<AuthenticationStates> emit) async {
    emit(EditProfileLoadingState());

    final response = await dioHelper.sendToServer(url: "driver/profile", body: {
      "fullname": nameController.text,
      "phone": phoneController.text,
      if (userImage != null)
        "image": MultipartFile.fromFileSync(userImage!.path,
            filename: userImage!.path.split("/").last),
      "identity_number": idController.text,
      if (licenseImage != null)
        "car_licence_image": MultipartFile.fromFileSync(licenseImage!.path,
            filename: licenseImage!.path.split("/").last),
      if (carFormImage != null)
        "car_form_image": MultipartFile.fromFileSync(carFormImage!.path,
            filename: carFormImage!.path.split("/").last),
      if (carInsurance != null)
        "car_insurance_image": MultipartFile.fromFileSync(carInsurance!.path,
            filename: carInsurance!.path.split("/").last),
      if (frontCarImage != null)
        "car_front_image": MultipartFile.fromFileSync(frontCarImage!.path,
            filename: frontCarImage!.path.split("/").last),
      if (backCarImage != null)
        "car_back_image": MultipartFile.fromFileSync(backCarImage!.path,
            filename: backCarImage!.path.split("/").last),
      if (cityId != null) "city_id": cityId,
      "iban": iBanController.text,
      "bank_name": bankNameController.text,
      "car_type": carTypeController.text,
      "model_id": carModelController.text,
    });
    if (response.success) {
      emit(EditProfileSuccessState(
          context: event.context,
          message: response.response!.statusMessage ?? "",
          image: userImage?.path));
      await CacheHelper.setFullName(nameController.text);
      await CacheHelper.setPhone(phoneController.text);
      await CacheHelper.setCityName(cityController.text);
    } else {
      emit(EditProfileErrorState(
          context: event.context,
          message: response.response!.statusMessage ?? "",
          statusCode: response.response!.statusCode ?? 200));
    }
  }

  final codeController = TextEditingController();

  Future<void> _postData(
      PostCheckCodeDataEvent event, Emitter<AuthenticationStates> emit) async {
    emit(CheckCodeLoadingState());
    final map = {
      'code': codeController.text,
      'phone': event.phone,
    };
    final response = await dioHelper.sendToServer(url: "check_code", body: map);
    if (response.success) {
      emit(CheckCodeSuccessState(
          message: "تم التحقق بنجاح", context: event.context));
    } else {
      emit(CheckCodeErrorState(
          message: response.response!.statusMessage ?? "",
          statueCode: response.response?.statusCode ?? 200,
          context: event.context));
    }
  }

  Future<void> _resendCode(
      PostResendCodeDataEvent event, Emitter<AuthenticationStates> emit) async {
    emit(ResendCodeLoadingState());

    final response = await dioHelper.sendToServer(url: "resend_code", body: {
      "phone": event.phone,
    });

    if (response.success) {
      emit(ResendCodeSuccessState(
        message: response.response!.statusMessage ?? "",
        context: event.context,
      ));
    } else {
      emit(ResendCodeErrorState(
          message: response.response!.statusMessage ?? "",
          statusCode: response.response?.statusCode ?? 200,
          context: event.context));
    }
  }
}
