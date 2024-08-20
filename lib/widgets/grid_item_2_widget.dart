import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

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
    return Container(
      color: Colors
          .white, // Ensures the background of the whole container is white
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Sets the background color to white
              borderRadius: BorderRadius.circular(10),
            ),
            height: context.height() * 0.15,
            width: context.width() * 0.5,
            child: Card(
              color: Colors
                  .white, // Sets the background color of the card to white
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
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .black, // Ensures the text is black for better contrast
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
