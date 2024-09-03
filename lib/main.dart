import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:g_route/cubit/customer_profile/customer_profile_cubit.dart';
import 'package:g_route/cubit/sales_order/sales_order_cubit.dart';
import 'package:g_route/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => DeliveryAssignmentCubit(),
        // ),
        BlocProvider(create: (context) => SalesOrderCubit()),
        BlocProvider(create: (context) => CustomersProfileCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue, // Your primary color
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return AppColors.primaryColor; // Change to your primary color
              }
              return Colors.white; // Default color when not selected
            }),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
