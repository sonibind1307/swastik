import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../config/colorConstant.dart';
import '../../../controller/login_controller.dart';
import '../../widget/custom_text_style.dart';
import '../../widget/edit_text_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  LoginController loginController = LoginController();
  String? last10DigitsMobileNumber;

  late TabController _tabController;

  getMobileNUmber() async {
    String? selectedPhoneNumber = await SmsAutoFill().hint;
    debugPrint("selectedPhoneNumber -> $selectedPhoneNumber");
    if (selectedPhoneNumber != null) {
      last10DigitsMobileNumber =
          selectedPhoneNumber.substring(selectedPhoneNumber.length - 10);
      if (last10DigitsMobileNumber == null ||
          last10DigitsMobileNumber!.isEmpty) {
        debugPrint("last10DigitsMobileNumber $last10DigitsMobileNumber");
      } else {
        loginController.phoneController.text = last10DigitsMobileNumber!;
        debugPrint("enter in mobile login");
      }
    } else {}
    debugPrint("Sim Number -> $last10DigitsMobileNumber");
  }

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Center(
              child: FaIcon(
                FontAwesomeIcons.sellsy,
                color: Colors.white,
                size: 120,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextStyle.bold(
                    text: "Real", color: Colors.white, fontSize: 32),
                CustomTextStyle.bold(
                    text: "ERP", color: Colors.white, fontSize: 32),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: Colors.grey,
                        indicatorColor: Colors.blue,
                        controller: _tabController,
                        tabs: const [
                          Tab(text: 'Phone Number'),
                          Tab(text: 'Username/Password'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomTextStyle.bold(
                                      text: "Mobile Number",
                                    ),
                                    CustomTextStyle.regular(
                                        text:
                                            "Please enter your phone number to verify your account",
                                        fontSize: 12),
                                    GestureDetector(
                                      onTap: () {
                                        getMobileNUmber();
                                      },
                                      child: Card(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  color: Colors.white,
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child: const Icon(
                                                      Icons.phone_android),
                                                ),
                                                Expanded(
                                                  child: CustomEditTestWidgets
                                                      .textEditPhoneLogin(
                                                          controller:
                                                              loginController
                                                                  .phoneController,
                                                          context: context,
                                                          hint: "Phone Number",
                                                          onTap: () {
                                                            getMobileNUmber();
                                                          }),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => Align(
                                        alignment: Alignment.centerLeft,
                                        child: CustomTextStyle.regular(
                                            text:
                                                loginController.errorMsg.value,
                                            color: Colors.red,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Obx(
                                      () => ElevatedButton(
                                        onPressed: () {
                                          // getMobileNUmber();
                                          if (loginController.isLoading ==
                                              false) {
                                            loginController.onLoginClick("1");
                                          }
                                        },
                                        style: ButtonStyle(
                                          overlayColor: MaterialStateProperty
                                              .resolveWith<Color?>(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.hovered)) {
                                                return AppColors
                                                    .hoverColor; //<-- SEE HERE
                                              }
                                              return null; // Defer to the widget's default.
                                            },
                                          ),
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 10),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red),
                                        ),
                                        child: loginController.isLoading == true
                                            ? const Padding(
                                                padding: EdgeInsets.only(
                                                    top: 4,
                                                    bottom: 4,
                                                    left: 16.0,
                                                    right: 16.0),
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomTextStyle.bold(
                                                  text: "LOGIN",
                                                ),
                                              ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CustomTextStyle.bold(
                                      text: "Username & Password",
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    // CustomTextStyle.regular(
                                    //     text:
                                    //         "Please enter your username. We will send you 4-digit code to verify your account",
                                    //     fontSize: 12),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: Row(
                                            children: [
                                              Container(
                                                color: Colors.white,
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: const Icon(Icons.person),
                                              ),
                                              Expanded(
                                                child: CustomEditTestWidgets
                                                    .textEditTextLogin(
                                                        controller: loginController
                                                            .userNameController,
                                                        context: context,
                                                        hint: "Username"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: Row(
                                            children: [
                                              Container(
                                                color: Colors.white,
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child:
                                                    const Icon(Icons.password),
                                              ),
                                              // Expanded(
                                              //   child: CustomEditTestWidgets
                                              //       .textEditTextLogin(
                                              //           controller: loginController
                                              //               .passwordController,
                                              //           context: context,
                                              //           hint: "Password"),
                                              //
                                              //
                                              // ),
                                              Expanded(
                                                child: Container(
                                                  height: 48,
                                                  margin: const EdgeInsets.only(
                                                      left: 4),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4),
                                                  // color: Colors.red,
                                                  color: Colors.grey.shade200,
                                                  child: TextFormField(
                                                    obscureText: _obscureText,
                                                    controller: loginController
                                                        .passwordController,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    maxLines: 1,
                                                    decoration: InputDecoration(
                                                        suffixIcon: IconButton(
                                                          icon: Icon(
                                                            _obscureText
                                                                ? Icons
                                                                    .visibility_off
                                                                : Icons
                                                                    .visibility,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              _obscureText =
                                                                  !_obscureText;
                                                            });
                                                          },
                                                        ),
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4)),
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color: AppColors
                                                                  .black300),
                                                        ),
                                                        hintText:
                                                            "Enter Password"),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => Align(
                                        alignment: Alignment.centerLeft,
                                        child: CustomTextStyle.regular(
                                            text:
                                                loginController.errorUser.value,
                                            color: Colors.red,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Obx(
                                      () => ElevatedButton(
                                        onPressed: () {
                                          if (loginController.isLoading ==
                                              false) {
                                            loginController.onLoginClick("2");
                                          }
                                        },
                                        style: ButtonStyle(
                                          overlayColor: MaterialStateProperty
                                              .resolveWith<Color?>(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.hovered)) {
                                                return AppColors
                                                    .hoverColor; //<-- SEE HERE
                                              }
                                              return null; // Defer to the widget's default.
                                            },
                                          ),
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 10),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red),
                                        ),
                                        child: loginController.isLoading == true
                                            ? const Padding(
                                                padding: EdgeInsets.only(
                                                    top: 4,
                                                    bottom: 4,
                                                    left: 16.0,
                                                    right: 16.0),
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomTextStyle.bold(
                                                  text: "LOGIN",
                                                ),
                                              ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
