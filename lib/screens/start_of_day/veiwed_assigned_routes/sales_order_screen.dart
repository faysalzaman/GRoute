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
                          controller: searchController,
                          onChanged: (value) {
                            SalesOrderCubit.get(context)
                                .getFilterAssignedOrders(value);
                          },
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
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {
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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: BlocBuilder<SalesOrderCubit, SalesOrderState>(
                  builder: (context, state) {
                    if (state is SalesOrderAssignedFilterState) {
                      return SizedBox(
                        child: _buildPOListTable(
                          SalesOrderCubit.get(context).filterAssignedOrders,
                        ),
                      );
                    }
                    return SizedBox(
                      child: _buildPOListTable(
                        SalesOrderCubit.get(context).assignedOrders,
                      ),
                    );
                  },
                ),
              ),
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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                ),
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
                              width: MediaQuery.of(context).size.width * 0.3,
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
                              width: MediaQuery.of(context).size.width * 0.3,
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
              5.height,
              Visibility(
                visible: selectedRowIndex != null,
                child: GestureDetector(
                  onTap: () {
                    AppNavigator.goToPage(
                      context: context,
                      screen: AssignRouteScreen(
                        index: selectedRowIndex!,
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
                        goodsIssueModel:
                            SalesOrderCubit.get(context).goodsIssueDetails[0],
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      "Proceed",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
              selectedRowIndex = null;
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
          ),
          dataRowColor: MaterialStateColor.resolveWith(
            (states) => Colors.white,
          ),
        ),
        child: PaginatedDataTable(
          columns: const [
            DataColumn(label: CustomDataColumnLabel(label: 'ID')),
            DataColumn(
                label: CustomDataColumnLabel(label: 'Shipping Trx Code')),
            DataColumn(label: CustomDataColumnLabel(label: 'Ship To Location')),
            DataColumn(
                label: CustomDataColumnLabel(label: 'Grower Supplier GLN')),
            DataColumn(label: CustomDataColumnLabel(label: 'Ship From GLN')),
            DataColumn(label: CustomDataColumnLabel(label: 'Ship Date')),
            DataColumn(label: CustomDataColumnLabel(label: 'Activity Type')),
            DataColumn(label: CustomDataColumnLabel(label: 'Bis Step')),
            DataColumn(label: CustomDataColumnLabel(label: 'Disposition')),
            DataColumn(
                label: CustomDataColumnLabel(label: 'Bis Transaction Type')),
            DataColumn(
                label: CustomDataColumnLabel(label: 'Bis Transaction ID')),
            DataColumn(
                label: CustomDataColumnLabel(label: 'Purchase Order No')),
            DataColumn(label: CustomDataColumnLabel(label: 'Sales Order No')),
            DataColumn(label: CustomDataColumnLabel(label: 'Sales Invoice No')),
            DataColumn(
                label: CustomDataColumnLabel(label: 'Transaction Date Time')),
            DataColumn(label: CustomDataColumnLabel(label: 'GCP GLN ID')),
            DataColumn(label: CustomDataColumnLabel(label: 'GCP NO')),
            DataColumn(label: CustomDataColumnLabel(label: 'Created At')),
            DataColumn(label: CustomDataColumnLabel(label: 'Updated At')),
            DataColumn(label: CustomDataColumnLabel(label: 'Member Id')),
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

  Widget _buildLineItemsTable(List<GoodsIssueModel> data) {
    LineItemSource dataSource = LineItemSource(
      data,
      (GoodsIssueModel item) {
        AppNavigator.goToPage(
          context: context,
          screen: SalesOrderDetailsScreen(
            gtin: item.gTIN.toString(),
          ),
        );
      },
    );
    return Container(
      color: Colors.white,
      child: DataTableTheme(
        data: DataTableThemeData(
          headingRowColor: MaterialStateColor.resolveWith(
            (states) => AppColors.primaryColor,
          ),
          dataRowColor: MaterialStateColor.resolveWith(
            (states) => Colors.white,
          ),
        ),
        child: PaginatedDataTable(
          columns: const [
            DataColumn(
                label: CustomDataColumnLabel(label: 'Shipping Trx Code')),
            DataColumn(label: CustomDataColumnLabel(label: 'GTIN')),
            DataColumn(label: CustomDataColumnLabel(label: 'Item SKU')),
            DataColumn(label: CustomDataColumnLabel(label: 'Batch No')),
            DataColumn(label: CustomDataColumnLabel(label: 'Serial No')),
            DataColumn(
                label: CustomDataColumnLabel(label: 'Manufacturing Date')),
            DataColumn(label: CustomDataColumnLabel(label: 'Expiry Date')),
            DataColumn(label: CustomDataColumnLabel(label: 'Packaging Date')),
            DataColumn(label: CustomDataColumnLabel(label: 'Sell By')),
            DataColumn(label: CustomDataColumnLabel(label: 'Receiving UOM')),
            DataColumn(label: CustomDataColumnLabel(label: 'Box Barcode')),
            DataColumn(label: CustomDataColumnLabel(label: 'SSCC Barcode')),
            DataColumn(label: CustomDataColumnLabel(label: 'Quantity')),
            DataColumn(label: CustomDataColumnLabel(label: 'EUDAMED Code')),
            DataColumn(label: CustomDataColumnLabel(label: 'UDI Code')),
            DataColumn(label: CustomDataColumnLabel(label: 'GPC Code')),
            DataColumn(
                label:
                    CustomDataColumnLabel(label: 'Tbl Goods Issue Master Id')),
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

class CustomDataColumnLabel extends StatelessWidget {
  final String label;

  const CustomDataColumnLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      decoration: const BoxDecoration(color: AppColors.primaryColor),
      child: Row(
        children: [
          const VerticalDivider(
            color: Colors.white, // Color of the vertical divider
            thickness: 2, // Thickness of the divider
            width: 10, // Space between text and the divider
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<AssignedOrdersModel> _data;
  final int? _selectedRowIndex;
  final Function(int index, bool selected) _onSelectRow;

  _DataSource(this._data, this._selectedRowIndex, this._onSelectRow);

  @override
  DataRow getRow(int index) {
    final AssignedOrdersModel data = _data[index];
    return DataRow.byIndex(
      index: index,
      selected: _selectedRowIndex == index,
      onSelectChanged: (selected) {
        if (selected != null) {
          _onSelectRow(index, selected);
        }
      },
      cells: <DataCell>[
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.id ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.shippingTrxCode ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.shipToLocation ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.growerSupplierGLN ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.shipFromGLN ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.shipDate ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.activityType ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.bisStep ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            data.tblGoodsIssueMaster!.disposition ?? '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: data.tblGoodsIssueMaster!.disposition == "delivered" ||
                      data.tblGoodsIssueMaster!.disposition == "Delivered"
                  ? Colors.green
                  : Colors.black,
            ),
          ),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.bisTransactionType ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.bisTransactionID ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.purchaseOrderNo ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.salesOrderNo ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.salesInvoiceNo ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.transactionDateTime ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.gcpGLNID ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.gCPNo ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.createdAt ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.updatedAt ?? ''),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(data.tblGoodsIssueMaster!.memberId ?? ''),
        )),
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
  final void Function(GoodsIssueModel) onSingleTap;

  LineItemSource(this._data, this.onSingleTap);

  @override
  DataRow getRow(int index) {
    final GoodsIssueModel data = _data[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(data.shippingTrxCode ?? ''),
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(data.gTIN ?? ''),
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(data.itemSKU ?? ''),
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(data.batchNo ?? ''),
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(data.serialNo ?? ''),
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(data.manufacturingDate ?? ''),
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(data.expiryDate ?? ''),
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(data.packagingDate ?? ''),
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(data.sellBy ?? ''),
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(data.receivingUOM ?? ''),
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(data.boxBarcode ?? ''),
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(data.sSCCBarcode ?? ''),
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(data.qty ?? ''),
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(data.eUDAMEDCode ?? ''),
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(data.uDICode ?? ''),
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(data.gPCCode ?? ''),
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () => onSingleTap(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(data.tblGoodsIssueMasterId ?? ''),
            ),
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
  int get selectedRowCount => 0;
}
