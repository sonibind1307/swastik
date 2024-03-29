import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'package:swastik/config/colorConstant.dart';
import 'package:swastik/presentation/view/notification/local_notification.dart';
import 'package:swastik/presentation/view/profile/profile_controller.dart';
import 'package:swastik/presentation/view/splash/splash_screen.dart';

import 'controller/add_invoice_controller.dart';
import 'controller/add_vendor_controller.dart';
import 'controller/dashboard_controller.dart';
import 'controller/invoice_dashboard_controller.dart';
import 'controller/invoice_details_controller.dart';
import 'controller/vendor_list_controller.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBTnyL32n3aNoRMS4takqdVNg4CXqfW_ho",
          appId: "1:849137355051:android:8eb1947f1a1ffb2e249d6e",
          messagingSenderId: "849137355051",
          projectId: "realerp-ba53f",
          storageBucket: "realerp-ba53f.appspot.com"));

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  Get.put(AddInvoiceController());
  Get.put(VendorListController());
  Get.put(AddVendorController());
  Get.put(DashboardController());
  Get.put(ProfileController());
  Get.put(InvoiceDetailsController());
  Get.put(InvoiceDashboardController());

  SystemChannels.textInput.invokeMethod('TextInput.hide');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    FirebaseMessaging.instance.requestPermission();
    LocalNotificationService.initialize(context);

    // app terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {}
    });
    //Foreground
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.display(message);
    });
    // when apps open but in the background and message gets clicked
    FirebaseMessaging.onMessageOpenedApp.listen((message) {});

    super.initState();
  }

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
