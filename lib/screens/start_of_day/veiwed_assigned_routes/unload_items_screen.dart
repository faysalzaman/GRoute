// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:g_route/controller/image_controller/image_controller.dart';
import 'package:g_route/controller/update_controller.dart';
import 'package:g_route/cubit/delivery_assignment/delivery_assignment_cubit.dart';
import 'package:g_route/cubit/image/image_cubit.dart';
import 'package:g_route/cubit/image/image_state.dart';
import 'package:g_route/cubit/sales_order_detail/sales_order_detail_cubit.dart';
import 'package:g_route/cubit/sales_order_detail/sales_order_detail_state.dart';
import 'package:g_route/model/start_of_the_day/sales_order_detail_model.dart';
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
  });

  final int index;

  @override
  State<UnloadItemsScreen> createState() => _UnloadItemsScreenState();
}

class _UnloadItemsScreenState extends State<UnloadItemsScreen>
    with SingleTickerProviderStateMixin {
  String appBarTitle = "Unload Items";

  final ImagePicker _picker = ImagePicker();
  final List<XFile>? images = [];

  late TabController _tabController;

  SalesOrderDetailCubit salesOrderDetailCubit = SalesOrderDetailCubit();
  List<SalesOrderDetailModel> table = [];

  ImageCubit imageCubit = ImageCubit();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    salesOrderDetailCubit.getSalesOrderDetail(
        DeliveryAssignmentCubit.get(context)
            .deliveryAssignmentModel!
            .orders![widget.index]
            .tblSalesOrderId
            .toString());
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
          BlocConsumer<SalesOrderDetailCubit, SalesOrderDetailState>(
            bloc: salesOrderDetailCubit,
            listener: (context, state) {
              if (state is SalesOrderDetailLoaded) {
                table = state.salesOrderDetail;
              }
            },
            builder: (context, state) {
              if (state is SalesOrderDetailLoading) {
                return Center(
                  child: AppLoading.spinkitLoading(AppColors.primaryColor, 50),
                );
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red), // Red border
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: SizedBox(
                    width: MediaQuery.of(context)
                        .size
                        .width, // Ensure the table fits within the screen

                    child: Theme(
                      data: Theme.of(context).copyWith(
                        cardColor: Colors
                            .white, // Set the background color of the table to white
                        dataTableTheme: DataTableThemeData(
                          headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.pink,
                          ),
                          headingTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          dataRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors
                                .white, // Set row background color to white
                          ),
                        ),
                      ),
                      child: PaginatedDataTable(
                        // header: const Text('Sales Order Details'),
                        rowsPerPage: 4, // Show 5 items per page
                        columns: const [
                          // DataColumn(label: Text('ID')),
                          DataColumn(label: Text('RP Doc No')),
                          DataColumn(label: Text('Date Time Created')),
                          DataColumn(label: Text('SO Ref Code No')),
                          DataColumn(label: Text('SO Item Code')),
                          DataColumn(label: Text('SO Item Description')),
                          DataColumn(label: Text('SO Order Qty')),
                          DataColumn(label: Text('SO Item Unit')),
                          DataColumn(label: Text('SO Item Price')),
                          DataColumn(label: Text('SO Customer No')),
                          DataColumn(label: Text('SO Already Selected')),
                          DataColumn(label: Text('SO Item Free Qty')),
                          DataColumn(label: Text('SO Total Amount Price')),
                          DataColumn(label: Text('SO Total Amount Net Price')),
                          DataColumn(label: Text('SO Total Vat Amount')),
                          DataColumn(label: Text('SO Total Discount Amount')),
                          DataColumn(label: Text('SO Remarks')),
                          DataColumn(label: Text('Order')),
                        ],
                        source: _DataSource(table, context),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              AppNavigator.goToPage(
                context: context,
                screen: SignatureScreen(index: widget.index),
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
                  orderId: DeliveryAssignmentCubit.get(context)
                      .deliveryAssignmentModel!
                      .orders![widget.index]
                      .id
                      .toString(),
                  currentDate: DateTime.now().toIso8601String(),
                  action: OrderAction.invoiceCreationTime,
                );

                await _orderService.updateOrderStatus(
                  orderId: DeliveryAssignmentCubit.get(context)
                      .deliveryAssignmentModel!
                      .orders![widget.index]
                      .id
                      .toString(),
                  currentDate: DateTime.now().toIso8601String(),
                  action: OrderAction.unloadingTime,
                );

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
                      DeliveryAssignmentCubit.get(context)
                          .deliveryAssignmentModel!
                          .orders![widget.index]
                          .id
                          .toString(),
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
}

class _DataSource extends DataTableSource {
  final List<SalesOrderDetailModel> _data;
  final BuildContext context;

  _DataSource(this._data, this.context);

  @override
  DataRow? getRow(int index) {
    final SalesOrderDetailModel e = _data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        // DataCell(Text(e.id.toString())),
        DataCell(Text(e.rPDocNo.toString())),
        DataCell(Text(e.dateTimeCreated.toString())),
        DataCell(Text(e.sORefCodeNo.toString())),
        DataCell(Text(e.sOItemCode.toString())),
        DataCell(Text(e.sOItemDescription.toString())),
        DataCell(Text(e.sOOrderQty.toString())),
        DataCell(Text(e.sOItemUnit.toString())),
        DataCell(Text(e.sOItemPrice.toString())),
        DataCell(Text(e.sOCustomerNo.toString())),
        DataCell(Text(e.sOAlreadySelected.toString())),
        DataCell(Text(e.sOItemFreeQty.toString())),
        DataCell(Text(e.sOTotalAmountPrice.toString())),
        DataCell(Text(e.sOTotalAmountNetPrice.toString())),
        DataCell(Text(e.sOTotalVatAmount.toString())),
        DataCell(Text(e.sOTotalDiscountAmount.toString())),
        DataCell(Text(e.sORemarks.toString())),
        DataCell(Text(e.order.toString())),
      ],
    );
  }

  @override
  int get rowCount => _data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
