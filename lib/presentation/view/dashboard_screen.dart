import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swastik/config/colorConstant.dart';
import 'package:swastik/presentation/view/authentication/login_screen.dart';
import 'package:swastik/presentation/view/profile/profile_controller.dart';
import 'package:swastik/presentation/view/profile/profile_screen.dart';
import 'package:swastik/presentation/view/task/task_list_screen.dart';
import 'package:swastik/presentation/view/vendor/vendor_list_screen.dart';
import 'package:swastik/presentation/widget/custom_text_style.dart';

import '../../config/Helper.dart';
import '../../config/constant.dart';
import '../../config/sharedPreferences.dart';
import '../../controller/add_invoice_controller.dart';
import '../../controller/add_task_controller.dart';
import '../../controller/add_vendor_controller.dart';
import '../../controller/challan_list_controller.dart';
import '../../controller/dashboard_controller.dart';
import '../../controller/invoice_dashboard_controller.dart';
import '../../controller/invoice_details_controller.dart';
import '../../controller/invoice_list_controller.dart';
import '../../controller/task_list_controller.dart';
import '../../controller/vendor_list_controller.dart';
import '../bloc/bloc_logic/invoice_bloc.dart';
import 'challan/Challan_list_screen.dart';
import 'home/home_screen.dart';
import 'invoice/list_invoice_screen.dart';

class DashBoardScreen extends StatefulWidget {
  final int index;

  const DashBoardScreen({super.key, required this.index});

  @override
  State<StatefulWidget> createState() {
    Get.put(InvoiceListController());
    Get.put(InvoiceDetailsController());
    Get.put(InvoiceDashboardController());
    Get.put(AddInvoiceController());
    Get.put(VendorListController());
    Get.put(AddVendorController());
    Get.put(DashboardController());
    Get.put(ProfileController());
    Get.put(ChallanListController());
    Get.put(TaskListController());
    Get.put(AddTaskController());
    return HomePageState();
  }
}

class HomePageState extends State<DashBoardScreen> {
  int selectedDrawerIndex = 0;
  final controller = Get.put(DashboardController());
  final challanController = Get.find<ChallanListController>();
  final invoiceController = Get.find<InvoiceListController>();
  bool _IsSearching = false;
  InvoiceBloc instance = InvoiceBloc();
  Helper helper = Helper();
  Color rmsColor = Colors.grey;

  @override
  void initState() {
    selectedDrawerIndex = widget.index;
    // Helper.getToastMsg(_selectedDrawerIndex.toString());
    controller.getUserInfoData();
    // invoiceController.getAllInvoiceList();
    super.initState();
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return HomeScreen();
      case 1:
        return InvoiceScreen();
      case 2:
        return ChallanListScreen();
      case 3:
        return VendorListScreen();
      case 4:
        return TaskListScreen();
      case 6:
        return TaskListScreen();
      // case 7:
      //   return ProfileScreen();
      case 8:
        return ProfileScreen();
      default:
        return Container();
    }
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  onSelectItem(int index) {
    setState(() {
      _handleSearchEnd();
      Navigator.of(context).pop();
      selectedDrawerIndex = index;
      if (index == 2) {
        rmsColor = AppColors.primaryColor;
      } else {
        rmsColor = Colors.grey;
      }
      if (index == 9) {
        Helper.deleteDialog(context, "Do you want to logout from App", () {
          Navigator.pop(context);
          Auth.clearUserData();
          Get.offAll(const LoginPage());
        });
      }
    });
  }

  Icon actionIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );

  Widget appBarTitle = const Text(
    "Challan",
    style: TextStyle(color: Colors.white),
  );

  Widget appBarTitleInvoice = const Text(
    "Invoice",
    style: TextStyle(color: Colors.white),
  );

  void _handleSearchEnd() {
    setState(() {
      actionIcon = const Icon(
        Icons.search,
        color: Colors.white,
      );
      appBarTitle = const Text(
        "Challan",
        style: TextStyle(color: Colors.white),
      );
      appBarTitleInvoice = const Text(
        "Invoice",
        style: TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }

  final TextEditingController _searchQuery = TextEditingController();

  // final TextEditingController _searchQueryInvioce = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < helper.drawerItems.length; i++) {
      var d = helper.drawerItems[i];
      drawerOptions.add(ListTile(
        selectedColor: AppColors.primaryColor,
        leading: i == 2
            ? Image(
                image: const AssetImage('assets/rms-challan.png'),
                height: 24,
                width: 24,
                color: rmsColor,
              )
            : Icon(d.icon),
        title: Text(d.title),
        selected: i == selectedDrawerIndex,
        onTap: () => onSelectItem(i),
      ));
    }

    return WillPopScope(
      onWillPop: () async {
        // if (_selectedDrawerIndex != 0) {
        //   setState(() {
        //     _selectedDrawerIndex = 0;
        //   });
        //   _getDrawerItemWidget(_selectedDrawerIndex);
        // } else {
        //   Navigator.pop(context, true);
        // }
        // exit(0);
        Helper.closeAppDialog(context);

        return true;
      },
      child: Scaffold(
        appBar: selectedDrawerIndex == 1
            ? AppBar(
                centerTitle: true,
                title: appBarTitleInvoice,
                actions: <Widget>[
                    IconButton(
                      icon: actionIcon,
                      onPressed: () {
                        setState(() {
                          if (actionIcon.icon == Icons.search) {
                            actionIcon = const Icon(
                              Icons.close,
                              color: Colors.white,
                            );
                            appBarTitleInvoice = TextField(
                              cursorColor: AppColors.white200,
                              onChanged: (value) {
                                invoiceController.onSearchVendor(value);
                              },
                              controller: _searchQuery,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.search, color: Colors.white),
                                  hintText: "Search...",
                                  hintStyle: TextStyle(color: Colors.white)),
                            );
                            _handleSearchStart();
                          } else {
                            invoiceController.onSearchVendor("");
                            _handleSearchEnd();
                          }
                        });
                      },
                    ),
                  ])
            : selectedDrawerIndex == 2
                ? AppBar(
                    centerTitle: true,
                    title: appBarTitle,
                    actions: <Widget>[
                        IconButton(
                          icon: actionIcon,
                          onPressed: () {
                            setState(() {
                              if (actionIcon.icon == Icons.search) {
                                actionIcon = const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                );
                                appBarTitle = TextField(
                                  cursorColor: AppColors.white200,
                                  onChanged: (value) {
                                    challanController.onSearchVendor(value);
                                  },
                                  controller: _searchQuery,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.search,
                                          color: Colors.white),
                                      hintText: "Search...",
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
                                );
                                _handleSearchStart();
                              } else {
                                challanController.onSearchVendor("");
                                _handleSearchEnd();
                              }
                            });
                          },
                        ),
                      ])
                : AppBar(
                    title: Text(selectedDrawerIndex == 9
                        ? helper.drawerItems[0].title
                        : helper.drawerItems[selectedDrawerIndex].title),
                  ),
        drawer: buildDrawerScreen(context, drawerOptions),
        body: _getDrawerItemWidget(selectedDrawerIndex),
      ),
    );
  }

  Drawer buildDrawerScreen(BuildContext context, List<Widget> drawerOptions) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Obx(
              () => controller.isLoading.value == true
                  ? Container(
                      color: AppColors.primaryColor,
                      height: 200,
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )))
                  : UserAccountsDrawerHeader(
                      accountEmail: Text(controller.userMobile.value),
                      accountName:
                          Text(controller.userName.value.toUpperCase()),
                      currentAccountPicture: InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()),
                            );
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(
                            controller.userName.value
                                .toUpperCase()
                                .substring(0, 1),
                            style: const TextStyle(
                                fontSize: 30.0, color: Colors.black),
                          ), //Text
                        ),
                      ),
                    ),
            ),
            Column(children: drawerOptions),
            Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerRight,
              child: CustomTextStyle.regular(text: Constant.appVersion),
            )
          ],
        ),
      ),
    );
  }
}
