import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swastik/config/colorConstant.dart';
import 'package:swastik/presentation/view/vendor/vendor_list_screen.dart';

import '../../controller/dashboard_controller.dart';
import '../../model/DraverItem.dart';
import 'invoice/list_invoice_screen.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({super.key});

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

  String currentProfilePic =
      "https://avatars3.githubusercontent.com/u/16825392?s=460&v=4";

  Icon actionIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );
  bool _IsSearching = false;

  final avController = Get.put(DashboardController());

  final TextEditingController _searchQuery = TextEditingController();
  Widget appBarTitle = const Text(
    "Invoice",
    style: TextStyle(color: Colors.white),
  );

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return Container(
          child: Center(
            child: Text("Dashboard"),
          ),
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
        // CustomPopups.getInstance().showOkCancelDialog(
        //     context, Constant.logout, Constant.logoutMsg, onYesTab: () {
        //   Auth.clearUserData();
        //   Navigator.of(context).pop();
        //   Navigator.pushNamed(context, routeLogin);
        // }, onNoTap: () {
        //   Navigator.of(context).pop();
        // });
        // _selectedDrawerIndex = 0;
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
        if (_selectedDrawerIndex != 0) {
          setState(() {
            _selectedDrawerIndex = 0;
          });
          _getDrawerItemWidget(_selectedDrawerIndex);
        } else {
          Navigator.pop(context, true);
        }

        // exit(0);
        return true;
      },
      child: Scaffold(
        appBar: true
            ? AppBar(
                title: Text(_selectedDrawerIndex == 3 ||
                        _selectedDrawerIndex == 4 ||
                        _selectedDrawerIndex == 9
                    ? widget.drawerItems[0].title
                    : widget.drawerItems[_selectedDrawerIndex].title),
              )
            : AppBar(
                centerTitle: true,
                title: Text(widget.drawerItems[0].title),
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
                              onChanged: (value) {
                                // context
                                //     .read<InvoiceBloc>()
                                //     .onSearchInvoice(value.trim().toString());
                              },
                              controller: _searchQuery,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.search, color: Colors.white),
                                  hintText: "Search invoice",
                                  hintStyle: TextStyle(color: Colors.white)),
                            );
                            _handleSearchStart();
                          } else {
                            _handleSearchEnd();
                          }
                        });
                      },
                    ),
                  ]),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountEmail: const Text("bindsoni1998@gmail.com"),
                  accountName: const Text("SONI BIND"),
                  currentAccountPicture: GestureDetector(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(currentProfilePic),
                    ),
                    onTap: () => print("This is your current account."),
                  ),
                ),
                Column(children: drawerOptions)
              ],
            ),
          ),
        ),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
      ),
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = Text(
        "Search Sample",
        style: new TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}
