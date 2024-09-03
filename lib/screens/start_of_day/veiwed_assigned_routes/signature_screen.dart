// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:g_route/cubit/image/image_cubit.dart';
import 'package:g_route/cubit/image/image_state.dart';
import 'package:g_route/model/start_of_the_day/customers_profile_model.dart';
import 'package:g_route/utils/app_loading.dart';
import 'package:g_route/utils/app_snackbar.dart';
import 'package:g_route/widgets/bottom_line_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({
    super.key,
    required this.index,
    required this.updateId,
    required this.customersProfileModel,
  });

  final int index;
  final String updateId;
  final CustomersProfileModel customersProfileModel;

  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  File? imageFile;

  ImageCubit imageCubit = ImageCubit();

  Future<void> saveSignature() async {
    final signatureData = await _signaturePadKey.currentState!.toImage();
    final bytes =
        await signatureData.toByteData(format: ui.ImageByteFormat.png);

    if (bytes != null) {
      final buffer = bytes.buffer.asUint8List();

      // Check if the device is running Android 11 or higher
      if (await Permission.storage.isGranted ||
          await _requestStoragePermission()) {
        final directory = await getApplicationDocumentsDirectory();
        final path = '${directory.path}/signature.png';
        imageFile = File(path);
        await imageFile!.writeAsBytes(buffer);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission not granted')),
        );
      }
    }
  }

  Future<bool> _requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    } else {
      // For Android 11 or higher
      if (await Permission.manageExternalStorage.request().isGranted) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Receiver Signature"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<ImageCubit, ImageState>(
        bloc: imageCubit,
        listener: (context, state) {
          if (state is ImageError) {
            showAwesomeSnackbar(
              context: context,
              title: "Error",
              message: state.message,
            );
          }
          if (state is ImageLoaded) {
            // clear signature pad
            _signaturePadKey.currentState!.clear();

            showAwesomeSnackbar(
              context: context,
              title: "Saved",
              message: "Signature saved successfully",
            );

            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: SfSignaturePad(
                  key: _signaturePadKey,
                  backgroundColor: Colors.white,
                  strokeColor: Colors.black,
                  minimumStrokeWidth: 1.0,
                  maximumStrokeWidth: 4.0,
                ),
              ),
              20.height,
              GestureDetector(
                onTap: () async {
                  await saveSignature();

                  imageCubit.postImage(
                    [imageFile!],
                    widget.updateId,
                    "Signature",
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(5),
                  height: 40,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                  child: Center(
                    child: state is ImageLoading
                        ? AppLoading.spinkitLoading(Colors.white, 30)
                        : const Text(
                            "Save Signature",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
              30.height,
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(5),
                    height: 40,
                    width: 100,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                    ),
                    child: const Center(
                      child: Text(
                        "Back",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const BottomLineWidget(),
            ],
          );
        },
      ),
    );
  }
}
