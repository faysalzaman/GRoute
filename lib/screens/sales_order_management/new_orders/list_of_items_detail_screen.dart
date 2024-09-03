import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ListOfItemsDetailScreen extends StatefulWidget {
  const ListOfItemsDetailScreen({super.key});

  @override
  State<ListOfItemsDetailScreen> createState() =>
      _ListOfItemsDetailScreenState();
}

class _ListOfItemsDetailScreenState extends State<ListOfItemsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                    const Color.fromARGB(255, 77, 119, 183).withOpacity(0.2),
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
                          "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
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
              child: const Column(
                children: [
                  KeyValueInfoWidget(
                    keyy: 'Item Name',
                    value: "null",
                  ),
                  KeyValueInfoWidget(
                    keyy: 'GTIN',
                    value: "null",
                  ),
                  KeyValueInfoWidget(
                    keyy: 'New Weight',
                    value: "null",
                  ),
                  KeyValueInfoWidget(
                    keyy: 'Unit of Measure',
                    value: "null",
                  ),
                  KeyValueInfoWidget(
                    keyy: 'Quantity',
                    value: "null",
                  ),
                  KeyValueInfoWidget(
                    keyy: 'Batch Number',
                    value: "null",
                  ),
                  KeyValueInfoWidget(
                    keyy: 'GLN',
                    value: "null",
                  ),
                  KeyValueInfoWidget(
                    keyy: 'Expiry Date',
                    value: "null",
                  ),
                  KeyValueInfoWidget(
                    keyy: 'Manufacture Date',
                    value: "null",
                  ),
                ],
              ),
            ),
          ],
        ),
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
