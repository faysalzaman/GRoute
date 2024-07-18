// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:g_route/constants/app_colors.dart';
import 'package:g_route/screens/home_screen/home_screen.dart';
import 'package:g_route/utils/app_navigator.dart';
import 'package:g_route/widgets/bottom_line_widget.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

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

  @override
  void dispose() {
    _loginIdFocus.dispose();
    _passwordFocus.dispose();
    _loginIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool isEnglish = true;

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
        // menu icon will be show on right side
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
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextField(
                          controller: _loginIdController,
                          focusNode: _loginIdFocus,
                          decoration: const InputDecoration(
                            labelText: 'Enter your Login ID',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
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
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextField(
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Enter your Password',
                            prefixIcon: const Icon(Icons.lock),
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        AppNavigator.goToPage(
                            context: context, screen: const HomeScreen());
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
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
                              setState(
                                () {
                                  isEnglish = value;
                                },
                              );
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
                        )
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
