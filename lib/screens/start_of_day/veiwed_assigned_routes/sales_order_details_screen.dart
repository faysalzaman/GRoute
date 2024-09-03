import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:g_route/constants/app_urls.dart';
import 'package:g_route/cubit/sales_order/sales_order_cubit.dart';
import 'package:g_route/utils/app_loading.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class SalesOrderDetailsScreen extends StatefulWidget {
  const SalesOrderDetailsScreen({super.key});

  @override
  State<SalesOrderDetailsScreen> createState() =>
      _SalesOrderDetailsScreenState();
}

class _SalesOrderDetailsScreenState extends State<SalesOrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    SalesOrderCubit.get(context).getGtinProduct("234324");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<SalesOrderCubit, SalesOrderState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SalesOrderGtinProductLoadingState) {
            return Center(
              child: AppLoading.spinkitLoading(AppColors.primaryColor, 50),
            );
          }
          if (state is SalesOrderGtinProductErrorState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  state.message,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.red),
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: context.height() * 0.15,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primaryColor,
                        AppColors.primaryColor.withOpacity(0.5),
                        const Color.fromARGB(255, 77, 119, 183)
                            .withOpacity(0.2),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: const BoxDecoration(
                    // gradient color
                    color: AppColors.primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          finish(context);
                        },
                      ),
                      const Text(
                        'Product Information',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 50),
                    ],
                  ),
                ),
                10.height,
                Container(
                  height: context.height() * 0.2,
                  width: context.width() * 1,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.black,
                            width: 2, // Set the border width
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              "${AppUrls.gs1Url}${SalesOrderCubit.get(context).gtinProductModel!.frontImage.toString().replaceAll("//", "/")}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.image_outlined),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("QR Code",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: PrettyQrView.data(
                              data: "null",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: context.width() * 0.98,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      KeyValueInfoWidget(
                        keyy: 'Brand Name',
                        value: SalesOrderCubit.get(context)
                                .gtinProductModel!
                                .brandName ??
                            "",
                      ),
                      KeyValueInfoWidget(
                        keyy: 'Brand Name Arabic',
                        value: SalesOrderCubit.get(context)
                                .gtinProductModel!
                                .brandNameAr ??
                            "",
                      ),
                      KeyValueInfoWidget(
                        keyy: 'GTIN',
                        value: SalesOrderCubit.get(context)
                                .gtinProductModel!
                                .barcode ??
                            "",
                      ),
                      KeyValueInfoWidget(
                        keyy: 'Country Sale',
                        value: SalesOrderCubit.get(context)
                                .gtinProductModel!
                                .countrySale ??
                            "",
                      ),
                      KeyValueInfoWidget(
                        keyy: 'GCP GLN Id',
                        value: SalesOrderCubit.get(context)
                                .gtinProductModel!
                                .gcpGLNID ??
                            "",
                      ),
                      KeyValueInfoWidget(
                        keyy: 'Child Product',
                        value: SalesOrderCubit.get(context)
                                .gtinProductModel!
                                .childProduct ??
                            "",
                      ),
                      KeyValueInfoWidget(
                        keyy: 'Product Type',
                        value: SalesOrderCubit.get(context)
                                .gtinProductModel!
                                .ProductType ??
                            "",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class KeyValueInfoWidget extends StatelessWidget {
  const KeyValueInfoWidget({
    super.key,
    required this.keyy,
    required this.value,
  });

  final String keyy;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(2),
              color: AppColors.primaryColor,
              child: Text(
                keyy,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          10.width,
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.only(right: 10),
              color: Colors.grey.withOpacity(0.4),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
