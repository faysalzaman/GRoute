import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:g_route/screens/home_screen/widget/grid_item.dart';
import 'package:g_route/screens/sales_order_management/sales_order_management_screen.dart';
import 'package:g_route/screens/start_of_day/start_of_day_screen.dart';
import 'package:g_route/utils/app_navigator.dart';
import 'package:g_route/utils/app_snackbar.dart';
import 'package:g_route/widgets/bottom_line_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GridItem>? items;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      showAwesomeSnackbar(
        context: context,
        title: "Success",
        message: "You are logged in successfully.",
        contentType: ContentType.success,
      );
      return;
    });
    items = [
      GridItem(
        'Start of Day',
        'assets/icons/start_of_day.png',
        [
          {
            "onTap": () {},
            "name": "Vehicle Checks",
          },
          {
            "onTap": () {},
            "name": "Loading/Unloading",
          },
          {
            "onTap": () {},
            "name": "View Assigned Routes",
          }
        ],
        () {
          AppNavigator.goToPage(
              context: context, screen: const StartOfDayScreen());
        },
      ),
      GridItem(
        'Sales Order Management',
        'assets/icons/sales_order_management.png',
        [
          {
            "onTap": () {},
            "name": "New Orders",
          },
          {
            "onTap": () {},
            "name": "Sales Return",
          },
          {
            "onTap": () {},
            "name": "Order History",
          },
          {
            "onTap": () {},
            "name": "Custom Profile",
          }
        ],
        () {
          AppNavigator.goToPage(
              context: context, screen: const SalesOrderManagementScreen());
        },
      ),
      GridItem(
        'Inventory Management',
        'assets/icons/inventory_management.png',
        [
          {
            "onTap": () {},
            "name": "SO Stocks Availability",
          },
          {
            "onTap": () {},
            "name": "Request Van Stock",
          },
          {
            "onTap": () {},
            "name": "Reconcile Van Stock",
          },
          {
            "onTap": () {},
            "name": "Stocks on Van",
          },
          {
            "onTap": () {},
            "name": "Transfer Van Stock",
          }
        ],
        () {},
      ),
      GridItem(
        'Route Plan Management',
        'assets/icons/route_plan_management.png',
        [
          {
            "onTap": () {},
            "name": "Plan Route",
          },
          {
            "onTap": () {},
            "name": "Route Check",
          },
          {
            "onTap": () {},
            "name": "Route Statistics",
          }
        ],
        () {},
      ),
      GridItem(
        'Sales Invoice Management',
        'assets/icons/sales_invoice_management.png',
        [
          {
            "onTap": () {},
            "name": "Cash/Credit Sales",
          },
          {
            "onTap": () {},
            "name": "Spot Sales",
          },
          {
            "onTap": () {},
            "name": "Outstanding Balance",
          },
          {
            "onTap": () {},
            "name": "Products Discounts",
          },
          {
            "onTap": () {},
            "name": "Item Samples",
          }
        ],
        () {},
      ),
      GridItem(
        'Dynamic Promotions',
        'assets/icons/dynamic_promotions.png',
        [
          {
            "onTap": () {},
            "name": "Sales Promotion Offers",
          },
          {
            "onTap": () {},
            "name": "New Offer Products",
          }
        ],
        () {},
      ),
      GridItem(
        'Item Returns',
        'assets/icons/item_returns.png',
        [
          {
            "onTap": () {},
            "name": "Damages",
          },
          {
            "onTap": () {},
            "name": "Expired Items",
          },
          {
            "onTap": () {},
            "name": "Cancelled Items",
          }
        ],
        () {},
      ),
      GridItem(
        'Parameters',
        'assets/icons/parameters.png',
        [
          {
            "onTap": () {},
            "name": "Settings",
          },
          {
            "onTap": () {},
            "name": "Connectivity",
          },
          {
            "onTap": () {},
            "name": "Users Creation",
          },
          {
            "onTap": () {},
            "name": "Admin Panel",
          }
        ],
        () {},
      ),
      GridItem(
        'About',
        'assets/icons/about.png',
        [
          {
            "onTap": () {},
            "name": "Application Version",
          },
          {
            "onTap": () {},
            "name": "New Updates",
          },
          {
            "onTap": () {},
            "name": "New Release",
          }
        ],
        () {},
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // #E1F2F5
      backgroundColor: const Color(0xFFE1F2F5),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('GRoute Pro (Van Sales)'),
        centerTitle: true,
        // text color of the title
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        // icon color of the leading icon
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 0,
                        childAspectRatio: 0.5,
                      ),
                      itemCount: items!.length,
                      itemBuilder: (context, index) {
                        return GridItemWidget(item: items![index]);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const BottomLineWidget(),
        ],
      ),
    );
  }
}

class GridItem {
  final String title;
  final String icon;
  final List links;
  final void Function()? onTap;

  GridItem(
    this.title,
    this.icon,
    this.links,
    this.onTap,
  );
}
