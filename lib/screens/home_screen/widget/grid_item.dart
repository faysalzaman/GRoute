import 'package:flutter/material.dart';
import 'package:g_route/screens/home_screen/home_screen.dart';

class GridItemWidget extends StatelessWidget {
  final GridItem item;

  const GridItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          height: 100,
          width: 120,
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
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ...item.links.map(
          (e) => Padding(
            padding: const EdgeInsets.only(left: 10),
            child: GestureDetector(
              onTap: e["onTap"],
              child: Text(
                e["name"],
                style: const TextStyle(
                  fontSize: 10,
                  // decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
