// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:g_route/cubit/auth/auth_cubit.dart';
import 'package:g_route/cubit/auth/auth_state.dart';
import 'package:g_route/screens/home_screen/home_screen.dart';
import 'package:g_route/utils/app_loading.dart';
import 'package:g_route/utils/app_navigator.dart';
import 'package:g_route/utils/app_snackbar.dart';
import 'package:g_route/widgets/bottom_line_widget.dart';
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
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: const Text(
          'User Login',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              // Add your menu action here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat("d MMMM yyyy (EEEE)").format(DateTime.now()),
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  20.height,
                  Image.asset(
                    "assets/icons/groute_pro_logo.png",
                    width: 170,
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                  50.height,
                  Row(
                    children: [
                      Image.asset(
                        "assets/icons/email.png",
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.height * 0.07,
                        fit: BoxFit.fill,
                      ),
                      10.width,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextField(
                          controller: _loginIdController,
                          focusNode: _loginIdFocus,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            labelText: 'Enter your Login ID',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          onSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_passwordFocus);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Image.asset(
                        "assets/icons/password.png",
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.height * 0.07,
                        fit: BoxFit.fill,
                      ),
                      10.width,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextField(
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Enter your Password',
                            contentPadding: const EdgeInsets.all(10),
                            prefixIcon: const Icon(Icons.lock),
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Add your forgot password action here
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'Forgot Password? ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Add your forgot password action here
                            },
                            child: const Text(
                              'Click here',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: _onLoginPressed,
                          child: state is AuthLoading
                              ? Center(
                                  child: AppLoading.spinkitLoading(
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
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.language_outlined,
                          color: Colors.black,
                          size: 35,
                        ),
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
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_forward,
                          size: 30,
                        ),
                        Image.asset(
                          "assets/icons/qr_code.png",
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const BottomLineWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
