// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:g_route/controller/image_controller/image_controller.dart';
import 'package:g_route/controller/update_controller.dart';
import 'package:g_route/cubit/image/image_cubit.dart';
import 'package:g_route/cubit/image/image_state.dart';
import 'package:g_route/cubit/sales_order/sales_order_cubit.dart';
import 'package:g_route/model/start_of_the_day/customers_profile_model.dart';
import 'package:g_route/model/start_of_the_day/goods_issue_model.dart';
import 'package:g_route/screens/start_of_day/veiwed_assigned_routes/sales_order_details_screen.dart';
import 'package:g_route/screens/start_of_day/veiwed_assigned_routes/sales_order_screen.dart';
import 'package:g_route/screens/start_of_day/veiwed_assigned_routes/signature_screen.dart';
import 'package:g_route/utils/app_loading.dart';
import 'package:g_route/utils/app_navigator.dart';
import 'package:g_route/utils/app_snackbar.dart';
import 'package:g_route/widgets/bottom_line_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class UnloadItemsScreen extends StatefulWidget {
  const UnloadItemsScreen({
    super.key,
    required this.index,
    required this.updateId,
    required this.customersProfileModel,
    required this.goodsIssueModel,
  });

  final int index;
  final String updateId;
  final CustomersProfileModel customersProfileModel;
  final GoodsIssueModel goodsIssueModel;

  @override
  State<UnloadItemsScreen> createState() => _UnloadItemsScreenState();
}

class _UnloadItemsScreenState extends State<UnloadItemsScreen>
    with SingleTickerProviderStateMixin {
  String appBarTitle = "Unload Items";

  final ImagePicker _picker = ImagePicker();
  final List<XFile>? images = [];

  late TabController _tabController;

  ImageCubit imageCubit = ImageCubit();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    // TODO: this has to be done

    // salesOrderDetailCubit.getSalesOrderDetail(
    //     DeliveryAssignmentCubit.get(context)
    //         .deliveryAssignmentModel!
    //         .orders![widget.index]
    //         .tblSalesOrderId
    //         .toString());
  }

  Future<void> pickImage() async {
    if (images!.length < 5) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          images!.add(image);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You can only add up to 5 images.'),
        ),
      );
    }
  }

  void removeImage(int index) {
    setState(() {
      images!.removeAt(index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final OrderService _orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(appBarTitle),
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
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: AppColors.primaryColor,
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'Unload Items'),
              Tab(text: 'Capture Image'),
            ],
          ),
          10.height,
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                UnloadItemsTab(context),
                CaptureImageTab(context),
              ],
            ),
          ),
          const BottomLineWidget(),
        ],
      ),
    );
  }

  SingleChildScrollView UnloadItemsTab(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: BlocConsumer<SalesOrderCubit, SalesOrderState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is SalesOrderGoodsIssueLoading) {
                  return _buildLineItemsTable([]);
                }
                return _buildLineItemsTable(
                  SalesOrderCubit.get(context).goodsIssueDetails,
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              AppNavigator.goToPage(
                context: context,
                screen: SignatureScreen(
                  index: widget.index,
                  updateId: widget.updateId,
                  customersProfileModel: widget.customersProfileModel,
                ),
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
              child: const Center(
                child: Text(
                  "Signature Capture",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () async {
              try {
                await _orderService.updateOrderStatus(
                  orderId: widget.updateId,
                  currentDate: DateTime.now().toIso8601String(),
                  action: OrderAction.invoiceCreationTime,
                );

                await _orderService.updateOrderStatus(
                  orderId: widget.updateId,
                  currentDate: DateTime.now().toIso8601String(),
                  action: OrderAction.unloadingTime,
                );

                await _orderService.updateOrderStatus(
                  orderId: widget.updateId,
                  currentDate: DateTime.now().toIso8601String(),
                  action: OrderAction.completed,
                );

                SalesOrderCubit.get(context).getAssignedOrders();

                showAwesomeSnackbar(
                  context: context,
                  title: "Delivered",
                  message: "Items delivered successfully",
                );
                Navigator.of(context).pop();
              } catch (e) {
                // Handle error, e.g., show an error message
                print('Failed to update order: $e');

                showAwesomeSnackbar(
                  context: context,
                  title: "Delivered",
                  message: "Items delivered successfully",
                );
                Navigator.of(context).pop();
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(5),
              height: 40,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: const Center(
                child: Text(
                  "Print Invoice & delivery Note",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          10.height,
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
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  SingleChildScrollView CaptureImageTab(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          images!.isNotEmpty
              ? SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.file(
                    File(images!.last.path),
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: const Center(
                    child: Text('No Image Captured'),
                  ),
                ),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images!.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Image.file(
                        File(images![index].path),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: () => removeImage(index),
                        child: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          10.height,
          GestureDetector(
            onTap: pickImage,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(5),
              height: 40,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: const Center(
                child: Text(
                  "Capture Image",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          10.height,
          BlocConsumer<ImageCubit, ImageState>(
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
                showAwesomeSnackbar(
                  context: context,
                  title: "Saved",
                  message: "Image saved successfully",
                );

                // clear images
                setState(() {
                  images!.clear();
                });

                // and goes back to the 0th tab
                _tabController.animateTo(0);
              }
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: () async {
                  if (images != null && images!.isNotEmpty) {
                    List<File> files = [];

                    // Resize images if needed before adding them to the files list
                    for (var image in images!) {
                      File file = File(image.path);
                      File resizedFile =
                          await ImageController.resizeImageIfNeeded(file);
                      files.add(resizedFile);
                    }

                    // Log the files being uploaded
                    print(
                        "Uploading files: ${files.map((f) => f.path).join(', ')}");

                    // Call the method with the resized files
                    imageCubit.postImage(
                      files,
                      widget.updateId,
                      "Image",
                    );
                  } else {
                    print("No images to upload.");
                  }
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
                            "Save Image",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLineItemsTable(List<GoodsIssueModel> data) {
    LineItemSource dataSource = LineItemSource(
      data,
      (GoodsIssueModel item) {},
      (GoodsIssueModel item) {
        AppNavigator.goToPage(
            context: context, screen: const SalesOrderDetailsScreen());
      },
    );
    return Container(
      color: Colors.white,
      child: DataTableTheme(
        data: DataTableThemeData(
          headingRowColor: MaterialStateColor.resolveWith(
            (states) => Colors.pink,
          ), // Set the header color to blue
          dataRowColor: MaterialStateColor.resolveWith(
            (states) => Colors.white,
          ), // Set the table cells color to white
        ),
        child: PaginatedDataTable(
          columns: const [
            DataColumn(
              label: Text(
                'Shipping Trx Code',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'GTIN',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Item SKU',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Batch No',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Serial No',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Manufacturing Date',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Expiry Date',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Packaging Date',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Sell By',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Receiving UOM',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Box Barcode',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'SSCC Barcode',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Quantity',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'EUDAMED Code',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'UDI Code',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'GPC Code',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Tbl Goods Issue Master Id',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          source: dataSource,
          columnSpacing: 20,
          horizontalMargin: 10,
          rowsPerPage: 3,
          showCheckboxColumn: true,
        ),
      ),
    );
  }
}
