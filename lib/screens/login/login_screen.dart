// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif_view/gif_view.dart'; // Import the gif_view package
import 'package:g_route/constants/app_colors.dart';
import 'package:g_route/cubit/auth/auth_cubit.dart';
import 'package:g_route/cubit/auth/auth_state.dart';
import 'package:g_route/screens/home_screen/home_screen.dart';
import 'package:g_route/utils/app_loading.dart';
import 'package:g_route/utils/app_navigator.dart';
import 'package:g_route/utils/app_snackbar.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _loginIdFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _loginIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool isEnglish = true;
  AuthCubit authCubit = AuthCubit();

  @override
  void dispose() {
    _loginIdFocus.dispose();
    _passwordFocus.dispose();
    _loginIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.camera,
    ].request();

    if (statuses[Permission.location]!.isDenied) {
      showAwesomeSnackbar(
        context: context,
        title: "Permission Denied",
        message: "Location permission is required for this feature.",
        contentType: ContentType.warning,
      );
    }
  }

  void _onLoginPressed() async {
    // Request permissions before logging in
    await _requestPermissions();

    if (_loginIdController.text.isEmpty || _passwordController.text.isEmpty) {
      showAwesomeSnackbar(
        context: context,
        title: "Warning!",
        message: "Please enter Login ID and Password",
        contentType: ContentType.warning,
      );
      return;
    }

    authCubit.login(
      _loginIdController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                decoration: const BoxDecoration(
                  // Radius from bottom only
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  color: AppColors.primaryColor,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  margin: const EdgeInsets.only(top: 150, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // GIF image using GifView.asset
                                    Expanded(
                                      flex: 2,
                                      child: GifView.asset(
                                        "assets/icons/groute_truck.gif",
                                        height: 70,
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                20.height,
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  // Adjusted height for smaller TextField
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: TextField(
                                    controller: _loginIdController,
                                    focusNode: _loginIdFocus,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 12),
                                      labelText: 'Enter your Login ID',
                                      prefixIcon: Icon(Icons.person, size: 20),
                                      border: OutlineInputBorder(),
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12, // Reduced font size
                                      ),
                                    ),
                                    style: const TextStyle(fontSize: 14),
                                    onSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_passwordFocus);
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: TextField(
                                    controller: _passwordController,
                                    focusNode: _passwordFocus,
                                    obscureText: !_isPasswordVisible,
                                    decoration: InputDecoration(
                                      labelText: 'Enter your Password',
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 12),
                                      prefixIcon:
                                          const Icon(Icons.lock, size: 20),
                                      labelStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12, // Reduced font size
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(
                                            () {
                                              _isPasswordVisible =
                                                  !_isPasswordVisible;
                                            },
                                          );
                                        },
                                      ),
                                      border: const OutlineInputBorder(),
                                    ),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                BlocConsumer<AuthCubit, AuthState>(
                                  bloc: authCubit,
                                  listener: (context, state) {
                                    if (state is AuthSuccess) {
                                      AppNavigator.replaceAll(
                                        context: context,
                                        screen: const HomeScreen(),
                                      );
                                    } else if (state is AuthFailed) {
                                      showAwesomeSnackbar(
                                        context: context,
                                        title: "Failed",
                                        message: state.error
                                            .toString()
                                            .replaceAll("Exception:", ""),
                                        contentType: ContentType.failure,
                                      );
                                      return;
                                    }
                                  },
                                  builder: (context, state) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextButton(
                                        onPressed: _onLoginPressed,
                                        child: state is AuthLoading
                                            ? Center(
                                                child:
                                                    AppLoading.spinkitLoading(
                                                        Colors.white, 30),
                                              )
                                            : const Text(
                                                'Login',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            50.height,
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.7,
                                  child: Switch(
                                    activeColor: AppColors.primaryColor,
                                    value: isEnglish,
                                    onChanged: (value) {
                                      setState(() {
                                        isEnglish = value;
                                      });
                                    },
                                  ),
                                ),
                                const Text("English")
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/icons/groute_pro_logo.png",
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            right: 10,
            top: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat("d MMMM yyyy (EEEE)").format(DateTime.now()),
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
