import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/features/authentication/bloc.dart';
import 'package:thimar_driver/features/authentication/events.dart';
import 'package:thimar_driver/features/authentication/states.dart';

class PhotoUpload extends StatefulWidget {
  final String? text;
  final File? image;
  final bool showPhoto;
  final int? imageNumber;

  const PhotoUpload(
      {super.key,
      this.text,
      required this.image,
      this.showPhoto = false,
      this.imageNumber});

  @override
  State<PhotoUpload> createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  final _getProfileBloc = KiwiContainer().resolve<AuthenticationBloc>();

  @override
  void initState() {
    super.initState();
    if (widget.showPhoto) {
      _getProfileBloc.add(GetProfileDataEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  widget.showPhoto
                      ? Colors.black.withOpacity(.32)
                      : Colors.transparent,
                  BlendMode.darken),
              child: BlocBuilder(
                  bloc: _getProfileBloc,
                  builder: (context, state) {
                    if (state is GetProfileLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetProfileSuccessState) {
                      final image = state.data.data;
                      List<String> images = [
                        image.image,
                        image.carLicenceImage,
                        image.carFormImage,
                        image.carInsuranceImage,
                        image.carFrontImage,
                        image.carBackImage,
                      ];
                      return Container(
                        clipBehavior: Clip.antiAlias,
                        width: 80.w,
                        height: 70.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            image: DecorationImage(
                                image: widget.image == null && widget.showPhoto
                                    ? NetworkImage(images[widget.imageNumber!])
                                    : widget.image == null
                                        ? const Icon(Icons.add) as ImageProvider
                                        : FileImage(widget.image!),
                                fit: BoxFit.fill)),
                      );
                    } else if (state is GetProfileErrorState) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink();
                  }),
            ),
            if (widget.showPhoto)
              const Center(
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          widget.text ?? '',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: widget.showPhoto ? FontWeight.bold : FontWeight.w300,
            fontSize:
                widget.showPhoto && widget.imageNumber == 0 ? 17.sp : 13.sp,
          ),
        )
      ],
    );
  }
}
