import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_route/controller/image_controller/image_controller.dart';
import 'package:g_route/cubit/image/image_state.dart';
import 'package:g_route/services/connectivity_services.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());

  void postImage(
    List<File> images,
    String orderId,
    String imageType,
  ) async {
    emit(ImageLoading());
    try {
      var isConnected = await ConnectivityService.isConnected();
      if (!isConnected) {
        emit(ImageError(message: "No Internet Connection"));
      }

      await ImageController.uploadImage(images, orderId, imageType);
      emit(ImageLoaded());
    } catch (e) {
      emit(ImageError(message: e.toString().replaceAll("Exception:", "")));
    }
  }
}
