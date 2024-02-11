import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swastik/presentation/view/invoice_screen.dart';

import 'controller/add_invoice_controller.dart';

void main() {
  Get.put(AddInvoiceController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: InvoiceScreen(),
    );
  }
}
