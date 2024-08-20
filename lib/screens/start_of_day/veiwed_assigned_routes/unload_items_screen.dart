// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:g_route/screens/start_of_day/veiwed_assigned_routes/signature_screen.dart';
import 'package:g_route/utils/app_navigator.dart';
import 'package:g_route/utils/app_snackbar.dart';
import 'package:g_route/widgets/bottom_line_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class UnloadItemsScreen extends StatefulWidget {
  const UnloadItemsScreen({super.key});

  @override
  State<UnloadItemsScreen> createState() => _UnloadItemsScreenState();
}

class _UnloadItemsScreenState extends State<UnloadItemsScreen>
    with SingleTickerProviderStateMixin {
  String appBarTitle = "Unload Items";

  final ImagePicker _picker = ImagePicker();
  final List<XFile>? images = [];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red), // Red border
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: SingleChildScrollView(
              child: Theme(
                data: Theme.of(context).copyWith(
                  cardColor:
                      Colors.white, // Set table background color to white
                  dataTableTheme: DataTableThemeData(
                    headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.pink,
                    ), // Set header color to pink
                    headingTextStyle: const TextStyle(
                      color: Colors.white, // Set header text color to white
                      fontWeight: FontWeight.bold,
                    ),
                    dataRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white), // Set row color to white
                    dataTextStyle: const TextStyle(color: Colors.black),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.red), // Set table border to red
                    ),
                  ),
                ),
                child: PaginatedDataTable(
                  columns: const [
                    DataColumn(label: Text('ItemCode')),
                    DataColumn(label: Text('ItemDesc')),
                    DataColumn(label: Text('GTIN')),
                    DataColumn(label: Text('Remarks')),
                  ],
                  source: _DataSource(),
                  rowsPerPage: 5,
                  columnSpacing: 20,
                  horizontalMargin: 10,
                  showCheckboxColumn: false,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              AppNavigator.goToPage(
                context: context,
                screen: const SignatureScreen(),
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
            onTap: () {
              showAwesomeSnackbar(
                context: context,
                title: "Delivered",
                message: "Items delivered successfully",
              );
              Navigator.of(context).pop();
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
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
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
          ),
          50.height,
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
        ],
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(
    15,
    (index) => {
      "ItemCode": "834AB4",
      "ItemDesc": "1",
      "GTIN": "2099756752",
      "Remarks": "4",
    },
  );

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    final Map<String, dynamic> row = _data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(row['ItemCode'].toString())),
        DataCell(Text(row['ItemDesc'].toString())),
        DataCell(Text(row['GTIN'].toString())),
        DataCell(Text(row['Remarks'].toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;
}
