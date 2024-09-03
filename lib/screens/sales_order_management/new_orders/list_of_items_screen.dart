// ignore_for_file: collection_methods_unrelated_type

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:g_route/screens/sales_order_management/new_orders/list_of_items_detail_screen.dart';
import 'package:g_route/utils/app_navigator.dart';
import 'package:nb_utils/nb_utils.dart';

class ListOfItemsScreen extends StatefulWidget {
  const ListOfItemsScreen({super.key});

  @override
  State<ListOfItemsScreen> createState() => _ListOfItemsScreenState();
}

class _ListOfItemsScreenState extends State<ListOfItemsScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("PKrefd23143212"),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: context.width() * 1,
                height: 40,
                decoration: const BoxDecoration(color: AppColors.primaryColor),
                child: const Text(
                  'List of Items in SO',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        width: context.width() * 0.9,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.2))),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(5),
                          title: const Text(
                            "Item Name Khalid bi Waleen Ibn Taha Ibne asar",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: const Text(
                            "23423849328",
                            style: TextStyle(fontSize: 13),
                          ),
                          leading: ClipOval(
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
                          trailing: GestureDetector(
                            onTap: () {
                              AppNavigator.goToPage(
                                context: context,
                                screen: const ListOfItemsDetailScreen(),
                              );
                            },
                            child: Image.asset("assets/icons/view.png"),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
