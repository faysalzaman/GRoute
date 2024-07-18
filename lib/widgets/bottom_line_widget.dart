import 'package:flutter/material.dart';
import 'package:g_route/constants/app_colors.dart';

class BottomLineWidget extends StatelessWidget {
  const BottomLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      width: double.infinity,
      height: 30,
    );
  }
}
