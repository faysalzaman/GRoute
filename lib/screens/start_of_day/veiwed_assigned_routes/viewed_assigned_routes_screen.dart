import 'package:flutter/material.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:g_route/widgets/bottom_line_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ViewedAssignedRoutesScreen extends StatefulWidget {
  const ViewedAssignedRoutesScreen({super.key});

  @override
  State<ViewedAssignedRoutesScreen> createState() =>
      _ViewedAssignedRoutesScreenState();
}

class _ViewedAssignedRoutesScreenState
    extends State<ViewedAssignedRoutesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Sales Order's List"),
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
                    Container(
                      width: double.infinity,
                      height: context.height() * 0.35,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor)),
                      child: ListView.builder(
                        itemCount: 4,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            width: context.width() * 0.8,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Row(
                              children: [
                                Expanded(child: Text("${index + 1}")),
                                const Expanded(
                                  flex: 3,
                                  child: Text("SKR239w9er0wq99827382"),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'View Line Item',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: context.height() * 0.35,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor)),
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
