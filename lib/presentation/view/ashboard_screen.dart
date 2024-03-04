import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swastik/config/colorConstant.dart';
import 'package:swastik/presentation/view/authentication/login_screen.dart';
import 'package:swastik/presentation/view/vendor/vendor_list_screen.dart';

import '../../config/Helper.dart';
import '../../config/sharedPreferences.dart';
import '../../controller/dashboard_controller.dart';
import '../../model/DraverItem.dart';
import 'invoice/list_invoice_screen.dart';

class DashBoardScreen extends StatefulWidget {
  final int index;

  DashBoardScreen({super.key, required this.index});

  final drawerItems = [
    DrawerItem("Dashboard", Icons.home),
    DrawerItem("Invoices", Icons.ballot_outlined),
    DrawerItem("Vendors", Icons.people_alt_rounded),
    DrawerItem("RMS", Icons.fire_truck),
    DrawerItem("Steel", Icons.line_style_outlined),
    DrawerItem("PO/WO", Icons.content_paste_sharp),
    DrawerItem("Site Report", Icons.business),
    DrawerItem("Attendance", Icons.fingerprint),
    DrawerItem("Settings", Icons.settings),
    DrawerItem("Logout", Icons.logout),
  ];

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<DashBoardScreen> {
  int _selectedDrawerIndex = 0;
  final controller = Get.put(DashboardController());

  @override
  void initState() {
    _selectedDrawerIndex = widget.index;
    // Helper.getToastMsg(_selectedDrawerIndex.toString());
    controller.getUserInfoData();
    super.initState();
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const Center(
          child: Text("Dashboard"),
        );
      case 1:
        return InvoiceScreen();
      case 2:
        return VendorListScreen();
      // case 5:
      //   return InformativeMediaScreen();
      // case 6:
      //   return const ContactUsScreen();
      // case 7:
      //   return ProfileScreen();
      // case 8:
      //   return AboutScreen();
      default:
        return Container();
    }
  }

  _onSelectItem(int index) {
    setState(() {
      Navigator.of(context).pop();
      _selectedDrawerIndex = index;
      if (index == 3) {
        _selectedDrawerIndex = 0;
        // Navigator.pushNamed(context, routeServiceRequest);
      } else if (index == 4) {
        _selectedDrawerIndex = 0;
        // Navigator.pushNamed(context, route194ND);
      } else if (index == 9) {
        Helper.deleteDialog(context, "Do you want to logout from App", () {
          Navigator.pop(context);
          Auth.clearUserData();
          Get.offAll(LoginPage());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(ListTile(
        selectedColor: AppColors.primaryColor,
        leading: Icon(d.icon),
        title: Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
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
        appBar: AppBar(
          title: Text(_selectedDrawerIndex == 3 ||
                  _selectedDrawerIndex == 4 ||
                  _selectedDrawerIndex == 9
              ? widget.drawerItems[0].title
              : widget.drawerItems[_selectedDrawerIndex].title),
        ),
        drawer: Drawer(
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
                          currentAccountPicture: CircleAvatar(
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
                Column(children: drawerOptions)
              ],
            ),
          ),
        ),
        // body: Obx(() => controller.isLoading.value == true
        //     ? const Center(
        //         child: CircularProgressIndicator(),
        //       )
        //     : _getDrawerItemWidget(_selectedDrawerIndex)),

        body: _getDrawerItemWidget(_selectedDrawerIndex),
      ),
    );
  }
}
