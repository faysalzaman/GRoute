import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:g_route/cubit/sales_order/sales_order_cubit.dart';
import 'package:g_route/model/start_of_the_day/assigned_orders_model.dart';
import 'package:g_route/model/start_of_the_day/goods_issue_model.dart';
import 'package:g_route/screens/start_of_day/veiwed_assigned_routes/assign_route_screen.dart';
import 'package:g_route/screens/start_of_day/veiwed_assigned_routes/sales_order_details_screen.dart';
import 'package:g_route/utils/app_navigator.dart';
import 'package:nb_utils/nb_utils.dart';

class SalesOrderScreen extends StatefulWidget {
  const SalesOrderScreen({super.key});

  @override
  State<SalesOrderScreen> createState() => _SalesOrderScreenState();
}

class _SalesOrderScreenState extends State<SalesOrderScreen> {
  int? selectedRowIndex;

  @override
  void initState() {
    SalesOrderCubit.get(context).getAssignedOrders();
    super.initState();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Sales Order"),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          onChanged: (value) {},
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 15,
                              bottom: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                    10.width,
                    // search button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {
                          // search by id
                          // and search by other feilds also
                          SalesOrderCubit.get(context).assignedOrders =
                              SalesOrderCubit.get(context)
                                  .assignedOrders
                                  .where((element) => element
                                      .tblGoodsIssueMaster!.salesOrderNo!
                                      .toString()
                                      .contains(searchController.text))
                                  .toList();
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<SalesOrderCubit, SalesOrderState>(
                builder: (context, state) {
                  return SizedBox(
                    child: _buildPOListTable(
                      SalesOrderCubit.get(context).assignedOrders,
                    ),
                  );
                },
              ),
              20.height,
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Line Items",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
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
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<SalesOrderCubit, SalesOrderState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total SO",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 100,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      // color: ColorPallete.primary,
                                      )),
                              child: Text(
                                "${SalesOrderCubit.get(context).assignedOrders.length}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total Items",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 100,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(border: Border.all()),
                              child: Text(
                                "${SalesOrderCubit.get(context).goodsIssueDetails.length}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPOListTable(List<AssignedOrdersModel> data) {
    _DataSource dataSource = _DataSource(
      data,
      selectedRowIndex,
      (index, selected) {
        setState(
          () {
            if (selected) {
              selectedRowIndex = index;
              SalesOrderCubit.get(context).getGoodsIssueDetails(
                  data[selectedRowIndex!].tblGoodsIssueMaster!.id!);
            } else {
              selectedRowIndex = null; // Deselect if needed
            }
          },
        );
      },
    );
    return Container(
      color: Colors.white,
      child: DataTableTheme(
        data: DataTableThemeData(
          headingRowColor: MaterialStateColor.resolveWith(
            (states) => AppColors.primaryColor,
          ), // Set the header color to blue
          dataRowColor: MaterialStateColor.resolveWith(
            (states) => Colors.white,
          ), // Set the table cells color to white
        ),
        child: PaginatedDataTable(
          columns: const [
            DataColumn(
              label: Text(
                'Sales Order No',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'ID',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Shipping Trx Code',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Ship To Location',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Grower Supplier GLN',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Ship From GLN',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Ship Date',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Activity Type',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Bis Step',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Disposition',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Bis Transaction Type',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Bis Transaction ID',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Purchase Order No',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Sales Invoice No',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Transaction Date Time',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'GCP GLN ID',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'GCP NO',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Created At',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Updated At',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Member Id',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          source: dataSource,
          columnSpacing: 20,
          horizontalMargin: 10,
          rowsPerPage: 2,
          showCheckboxColumn: true,
          checkboxHorizontalMargin: 10,
        ),
      ),
    );
  }

  Widget _buildLineItemsTable(List<GoodsIssueModel> data) {
    LineItemSource dataSource = LineItemSource(data, (GoodsIssueModel item) {
      AppNavigator.goToPage(
        context: context,
        screen: AssignRouteScreen(
          index: data.indexOf(item),
          buttonText: 'Start Journey',
          updateId: SalesOrderCubit.get(context)
              .assignedOrders[selectedRowIndex!]
              .id
              .toString(),
          gcpGlnId: SalesOrderCubit.get(context)
              .assignedOrders[selectedRowIndex!]
              .tblGoodsIssueMaster!
              .gcpGLNID
              .toString(),
          goodsIssueModel: item,
        ),
      );
    }, (GoodsIssueModel item) {
      AppNavigator.goToPage(
        context: context,
        screen: SalesOrderDetailsScreen(
          gtin: item.gTIN.toString(),
        ),
      );
    }, context);
    return Container(
      color: Colors.white,
      child: DataTableTheme(
        data: DataTableThemeData(
          headingRowColor: MaterialStateColor.resolveWith(
            (states) => AppColors.primaryColor,
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
          rowsPerPage: 2,
          showCheckboxColumn: true,
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<AssignedOrdersModel> _data;
  final int? _selectedRowIndex; // Single selected row index
  final Function(int index, bool selected) _onSelectRow;

  _DataSource(this._data, this._selectedRowIndex, this._onSelectRow);

  @override
  DataRow getRow(int index) {
    final AssignedOrdersModel data = _data[index];

    // Check if disposition is "Delivered"
    bool isDelivered = data.tblGoodsIssueMaster?.disposition == "delivered" ||
        data.tblGoodsIssueMaster?.disposition == "Delivered";

    return DataRow.byIndex(
      index: index,
      selected:
          _selectedRowIndex == index && !isDelivered, // Deselect if delivered
      onSelectChanged: (selected) {
        if (selected != null && !isDelivered) {
          // Call the callback to manage selection
          _onSelectRow(index, selected);
        } else if (isDelivered) {
          // Show a message that this order has been delivered
          // Use Flutter's standard method to show a snackbar
          toast("This order has been delivered.");
        }
      },
      cells: <DataCell>[
        DataCell(Text(data.tblGoodsIssueMaster!.salesOrderNo ?? '')),
        DataCell(Text(data.tblGoodsIssueMaster!.id ?? '')),
        DataCell(Text(data.tblGoodsIssueMaster!.shippingTrxCode ?? '')),
        DataCell(Text(data.tblGoodsIssueMaster!.shipToLocation ?? '')),
        DataCell(Text(data.tblGoodsIssueMaster!.growerSupplierGLN ?? '')),
        DataCell(Text(data.tblGoodsIssueMaster!.shipFromGLN ?? '')),
        DataCell(Text(data.tblGoodsIssueMaster!.shipDate ?? '')),
        DataCell(Text(data.tblGoodsIssueMaster!.activityType ?? '')),
        DataCell(Text(data.tblGoodsIssueMaster!.bisStep ?? '')),
        DataCell(Text(
          data.tblGoodsIssueMaster!.disposition ?? '',
          style: TextStyle(
            color: data.tblGoodsIssueMaster!.disposition == "delivered" ||
                    data.tblGoodsIssueMaster!.disposition == "Delivered"
                ? Colors.green
                : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        )),
        DataCell(Text(data.tblGoodsIssueMaster!.bisTransactionType ?? '')),
        DataCell(Text(data.tblGoodsIssueMaster!.bisTransactionID ?? '')),
        DataCell(Text(data.tblGoodsIssueMaster!.purchaseOrderNo ?? '')),
        DataCell(Text(data.tblGoodsIssueMaster!.salesInvoiceNo ?? '')),
        DataCell(Text(data.tblGoodsIssueMaster!.transactionDateTime ?? '')),
        DataCell(Text(data.tblGoodsIssueMaster!.gcpGLNID ?? '')),
        DataCell(Text(data.tblGoodsIssueMaster!.gCPNo ?? '')),
        DataCell(Text(data.tblGoodsIssueMaster!.createdAt ?? '')),
        DataCell(Text(data.tblGoodsIssueMaster!.updatedAt ?? '')),
        DataCell(Text(data.tblGoodsIssueMaster!.memberId ?? '')),
      ],
    );
  }

  @override
  int get rowCount => _data.length;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get selectedRowCount => _selectedRowIndex == null ? 0 : 1;
}

class LineItemSource extends DataTableSource {
  final List<GoodsIssueModel> _data;
  final void Function(GoodsIssueModel) onDoubleTap;
  final void Function(GoodsIssueModel) onSingleTap;
  int? _selectedRowIndex;
  final BuildContext context;

  LineItemSource(
    this._data,
    this.onDoubleTap,
    this.onSingleTap,
    this.context,
  );

  @override
  DataRow getRow(int index) {
    final GoodsIssueModel data = _data[index];

    return DataRow.byIndex(
      index: index,
      selected: _selectedRowIndex == index, // Highlight the selected row
      onSelectChanged: (selected) {
        // Handle single tap selection
        if (selected != null) {
          if (_selectedRowIndex == index) {
            // If the same row is double-tapped, deselect it
            _selectedRowIndex = null;
            SalesOrderCubit.get(context).goodsIssueDetails.clear();
          } else {
            // Select the new row
            _selectedRowIndex = index;
          }
          notifyListeners();
        }
      },
      cells: <DataCell>[
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            onDoubleTap: () {
              if (_selectedRowIndex == index) {
                // On double tap, deselect the row
                _selectedRowIndex = null;
              }
              notifyListeners();
            },
            child: Text(data.shippingTrxCode ?? ''),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            onDoubleTap: () {
              if (_selectedRowIndex == index) {
                // On double tap, deselect the row
                _selectedRowIndex = null;
              }
              notifyListeners();
            },
            child: Text(data.gTIN ?? ''),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            onDoubleTap: () {
              if (_selectedRowIndex == index) {
                // On double tap, deselect the row
                _selectedRowIndex = null;
              }
              notifyListeners();
            },
            child: Text(data.itemSKU ?? ''),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            onDoubleTap: () {
              if (_selectedRowIndex == index) {
                // On double tap, deselect the row
                _selectedRowIndex = null;
              }
              notifyListeners();
            },
            child: Text(data.batchNo ?? ''),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            onDoubleTap: () {
              if (_selectedRowIndex == index) {
                // On double tap, deselect the row
                _selectedRowIndex = null;
              }
              notifyListeners();
            },
            child: Text(data.serialNo ?? ''),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            onDoubleTap: () {
              if (_selectedRowIndex == index) {
                // On double tap, deselect the row
                _selectedRowIndex = null;
              }
              notifyListeners();
            },
            child: Text(data.manufacturingDate ?? ''),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            onDoubleTap: () {
              if (_selectedRowIndex == index) {
                // On double tap, deselect the row
                _selectedRowIndex = null;
              }
              notifyListeners();
            },
            child: Text(data.expiryDate ?? ''),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            onDoubleTap: () {
              if (_selectedRowIndex == index) {
                // On double tap, deselect the row
                _selectedRowIndex = null;
              }
              notifyListeners();
            },
            child: Text(data.packagingDate ?? ''),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            onDoubleTap: () {
              if (_selectedRowIndex == index) {
                // On double tap, deselect the row
                _selectedRowIndex = null;
              }
              notifyListeners();
            },
            child: Text(data.sellBy ?? ''),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            onDoubleTap: () {
              if (_selectedRowIndex == index) {
                // On double tap, deselect the row
                _selectedRowIndex = null;
              }
              notifyListeners();
            },
            child: Text(data.receivingUOM ?? ''),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            onDoubleTap: () {
              if (_selectedRowIndex == index) {
                // On double tap, deselect the row
                _selectedRowIndex = null;
              }
              notifyListeners();
            },
            child: Text(data.boxBarcode ?? ''),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            onDoubleTap: () {
              if (_selectedRowIndex == index) {
                // On double tap, deselect the row
                _selectedRowIndex = null;
              }
              notifyListeners();
            },
            child: Text(data.sSCCBarcode ?? ''),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            onDoubleTap: () {
              if (_selectedRowIndex == index) {
                // On double tap, deselect the row
                _selectedRowIndex = null;
              }
              notifyListeners();
            },
            child: Text(data.qty ?? ''),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            onDoubleTap: () {
              if (_selectedRowIndex == index) {
                // On double tap, deselect the row
                _selectedRowIndex = null;
              }
              notifyListeners();
            },
            child: Text(data.eUDAMEDCode ?? ''),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            onDoubleTap: () {
              if (_selectedRowIndex == index) {
                // On double tap, deselect the row
                _selectedRowIndex = null;
              }
              notifyListeners();
            },
            child: Text(data.uDICode ?? ''),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            onDoubleTap: () {
              if (_selectedRowIndex == index) {
                // On double tap, deselect the row
                _selectedRowIndex = null;
              }
              notifyListeners();
            },
            child: Text(data.gPCCode ?? ''),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            onDoubleTap: () {
              if (_selectedRowIndex == index) {
                // On double tap, deselect the row
                _selectedRowIndex = null;
              }
              notifyListeners();
            },
            child: Text(data.tblGoodsIssueMasterId ?? ''),
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => _data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedRowIndex == null ? 0 : 1;
}