import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:swastik/presentation/view/splash/splashScreenCubit.dart';
import 'package:swastik/presentation/widget/custom_text_style.dart';

import '../../../config/colorConstant.dart';
import '../../../controller/login_controller.dart';
import '../authentication/login_screen.dart';
import '../dashboard_screen.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({Key? key}) : super(key: key);

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SplashScreenCubit(),
      child: Scaffold(
        body: Center(
          child: BlocConsumer<SplashScreenCubit, SplashScreenState>(
            listener: (context, state) {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => InvoiceScreen(),
              //   ),
              // );
              // return;
              if (state == SplashScreenState.Login) {
                controller.onUpdateToken();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              } else if (state == SplashScreenState.Dashboard) {
                controller.onUpdateToken();
                Get.offAll(()=>DashBoardScreen(
                  index: 0,
                ));

                // Navigator.of(context).pushAndRemoveUntil(
                //   MaterialPageRoute(
                //     builder: (context) => const LoginPage(),
                //   ),
                // );
              }
            },
            builder: (context, state) {
              return Container(
                width: MediaQuery.of(context).size.width,
                color: AppColors.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.sellsy,
                      color: Colors.white,
                      size: 120,
                    ),
                    const SizedBox(
                      height: 16,
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
                      height: 40,
                    ),
                    // SizedBox(
                    //     height: 100,
                    //     width: 100,
                    //     child: Image(image: AssetImage(Constant.logo))),
                    // SizedBox(height: 20,),
                    // SimpleTextWidget(title: intro_title1, fontSize: 24, color: color1, fontWeight: FontWeight.bold,),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
