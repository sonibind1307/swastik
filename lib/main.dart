import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'package:swastik/config/colorConstant.dart';
import 'package:swastik/presentation/view/splash/splash_screen.dart';

import 'controller/add_invoice_controller.dart';

void main() {
  Get.put(AddInvoiceController());
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: AppColors.primaryColor.toMaterialColor(),
        // fontFamily: 'Poppins',
      ),
      title: 'Flutter Demo',
      home: SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
