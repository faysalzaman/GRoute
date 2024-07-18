import 'package:flutter/material.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:g_route/screens/start_of_day/veiwed_assigned_routes/viewed_assigned_routes_screen.dart';
import 'package:g_route/utils/app_navigator.dart';
import 'package:g_route/widgets/bottom_line_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class StartOfDayScreen extends StatefulWidget {
  const StartOfDayScreen({super.key});

  @override
  State<StartOfDayScreen> createState() => _StartOfDayScreenState();
}

class _StartOfDayScreenState extends State<StartOfDayScreen> {
  List<GridItem>? items;

  @override
  void initState() {
    items = [
      GridItem(
        'Vehicle Checks',
        'assets/icons/vehicle_checks.png',
        () {},
      ),
      GridItem(
        'Loading / Unloading',
        'assets/icons/laoding_unloading.png',
        () {},
      ),
      GridItem(
        'Viewed Assigned Routes',
        'assets/icons/viewed_assigned_routes.png',
        () {
          AppNavigator.goToPage(
              context: context, screen: const ViewedAssignedRoutesScreen());
        },
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Start Of The Day'),
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
          onPressed: () {
            Navigator.pop(context);
          },
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
                    Image.asset(
                      "assets/icons/start_of_day_home.png",
                      width: context.width(),
                      height: context.height() * 0.15,
                      fit: BoxFit.cover,
                    ),
                    20.height,
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2 / 1.5,
                      ),
                      itemCount: items!.length,
                      itemBuilder: (context, index) {
                        return GridItemWidget2(item: items![index]);
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
  final void Function()? onTap;

  GridItem(
    this.title,
    this.icon,
    this.onTap,
  );
}

class GridItemWidget2 extends StatelessWidget {
  final GridItem item;

  const GridItemWidget2({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: context.height() * 0.15,
          width: context.width() * 0.5,
          child: Card(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: item.onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item.icon,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
