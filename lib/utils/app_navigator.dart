import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppNavigator {
  // Method to navigate to a new page with animation
  static goToPage({required BuildContext context, required Widget screen}) {
    return Navigator.push(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 400),
        type: PageTransitionType.fade,
        child: screen,
      ),
    );
  }

  // Method to replace the current route with a new route
  static replaceTo({required BuildContext context, required Widget screen}) {
    return Navigator.pushReplacement(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 400),
        type: PageTransitionType.fade,
        child: screen,
      ),
    );
  }

  // Method to clear the entire navigation stack and open a new page
  static replaceAll({required BuildContext context, required Widget screen}) {
    return Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 400),
        type: PageTransitionType.fade,
        child: screen,
      ),
      (Route<dynamic> route) => false, // Removes all routes below the new route
    );
  }
}
