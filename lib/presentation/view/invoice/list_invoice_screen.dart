import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:swastik/config/Helper.dart';
import 'package:swastik/config/RupeesConverter.dart';
import 'package:swastik/config/colorConstant.dart';

import '../../../model/responses/invoice_model.dart';
import '../../../model/responses/project_model.dart';
import '../../bloc/bloc_logic/invoice_bloc.dart';
import '../../bloc/state/invoice_state.dart';
import '../../widget/custom_text_style.dart';
import '../pdfexport/multipleImageScreen.dart';
import 'add_invoice_screen.dart';
import 'invoice_details_screen.dart';

class InvoiceScreen extends StatefulWidget {
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  String _selectedStatus = "0";
  String? selectedProject;
  List<String> listOfStatus = [
    "0",
    "PENDING",
    "APPROVED",
    "REJECTED",
    "VERIFIED"
  ];
  Widget appBarTitle = const Text(
    "Invoice",
    style: TextStyle(color: Colors.white),
  );
  Icon actionIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );
  bool _IsSearching = false;
  final TextEditingController _searchQuery = TextEditingController();
  final key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => InvoiceBloc(),
      child: Scaffold(
        // drawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: [
        //       DrawerHeader(
        //         decoration: BoxDecoration(
        //           color: Colors.blue,
        //         ),
        //         child: UserAccountsDrawerHeader(
        //           decoration: BoxDecoration(color: Colors.blue),
        //           accountName: Text(
        //             "Soni bind",
        //             style: TextStyle(fontSize: 18),
        //           ),
        //           accountEmail: Text("abhishekm977@gmail.com"),
        //           currentAccountPictureSize: Size.square(50),
        //           currentAccountPicture: CircleAvatar(
        //             backgroundColor: Color.fromARGB(255, 165, 255, 137),
        //             child: Text(
        //               "A",
        //               style: TextStyle(fontSize: 30.0, color: Colors.blue),
        //             ), //Text
        //           ), //circleAvatar
        //         ),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.dashboard_customize_outlined),
        //         title: Text('Dashboard'),
        //         trailing: Icon(Icons.arrow_forward_ios_outlined),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.add),
        //         title: Text('Dashboard'),
        //         trailing: Icon(Icons.arrow_forward_ios_outlined),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.ballot_outlined),
        //         title: Text('Invoice'),
        //         trailing: Icon(Icons.arrow_forward_ios_outlined),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.people_alt_rounded),
        //         title: Text('Vendors'),
        //         trailing: Icon(Icons.arrow_forward_ios_outlined),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.fire_truck),
        //         title: Text('RMS'),
        //         trailing: Icon(Icons.arrow_forward_ios_outlined),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.line_style_outlined),
        //         title: Text('Steel'),
        //         trailing: Icon(Icons.arrow_forward_ios_outlined),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.content_paste_sharp),
        //         title: Text('PO/WO'),
        //         trailing: Icon(Icons.arrow_forward_ios_outlined),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.business),
        //         title: Text('Site Report'),
        //         trailing: Icon(Icons.arrow_forward_ios_outlined),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.fingerprint),
        //         title: Text('Attendance'),
        //         trailing: Icon(Icons.arrow_forward_ios_outlined),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.settings),
        //         title: Text('Setting'),
        //         trailing: Icon(Icons.arrow_forward_ios_outlined),
        //       ),
        //       Container(
        //         margin: EdgeInsets.all(4),
        //         child: ElevatedButton(
        //             onPressed: () {},
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Icon(Icons.logout),
        //                 Text("Logout"),
        //               ],
        //             )),
        //       )
        //     ],
        //   ),
        // ),
        key: key,
        // appBar: AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
        //   IconButton(
        //     icon: actionIcon,
        //     onPressed: () {
        //       setState(() {
        //         if (actionIcon.icon == Icons.search) {
        //           actionIcon = const Icon(
        //             Icons.close,
        //             color: Colors.white,
        //           );
        //           appBarTitle = BlocBuilder<InvoiceBloc, InvoiceState>(
        //               builder: (BuildContext context, state) {
        //             return TextField(
        //               onChanged: (value) {
        //                 context
        //                     .read<InvoiceBloc>()
        //                     .onSearchInvoice(value.trim().toString());
        //               },
        //               controller: _searchQuery,
        //               style: const TextStyle(
        //                 color: Colors.white,
        //               ),
        //               decoration: const InputDecoration(
        //                   prefixIcon: Icon(Icons.search, color: Colors.white),
        //                   hintText: "Search invoice",
        //                   hintStyle: TextStyle(color: Colors.white)),
        //             );
        //           });
        //           _handleSearchStart();
        //         } else {
        //           _handleSearchEnd();
        //         }
        //       });
        //     },
        //   ),
        // ]),
        body: BlocConsumer<InvoiceBloc, InvoiceState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedState) {
              return RefreshIndicator(
                onRefresh: () async {
                  // Helper.getToastMsg("toastMessage");
                  context.read<InvoiceBloc>().getInvoiceList();
                  return;
                  // return true;
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    dropDownList(context, state.dataProject),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Wrap(
                        spacing: 8.0,
                        children: listOfStatus.map((status) {
                          return ChoiceChip(
                            labelPadding:
                                const EdgeInsets.only(left: 8, right: 8),
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            selectedColor: AppColors.worningColor,
                            label: Text(_getChipStatusText(status)),
                            selected: _selectedStatus == status,
                            onSelected: (isSelected) {
                              if (isSelected) {
                                _selectedStatus = status;
                              }
                              context
                                  .read<InvoiceBloc>()
                                  .chipChoiceCardSelected(
                                      _selectedStatus.toString());
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 32.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: CustomTextStyle.regular(
                              text:
                                  "Count: ${state.dataInvoice.data == null ? "0.0" : state.dataInvoice.data!.length}")),
                    ),
                    listBuilder(context, state.dataInvoice)
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
          listener: (context, state) {},
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // const myList = {"name": "GeeksForGeeks"};
            // FileStorage.writeCounter(myList.toString(), "geeksforgeeks.txt");

            // return;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MultiImageScreen(
                        isEdit: false,
                        onSubmit: (imageLogo, imageList) {
                          // Helper.getToastMsg("invoice");
                        },
                      )),
            );
          },
          label: const Text("New Invoice"),
          icon: const Icon(Icons.camera_alt),
        ),
      ),
    );
  }

  String _getChipStatusText(String status) {
    switch (status) {
      case "0":
        return 'All';
      case "PENDING":
        return 'Pending';
      case "VERIFIED":
        return 'Verified';
      case "APPROVED":
        return 'Approved';
      case "REJECTED":
        return 'Rejected';
      default:
        return 'NA';
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "0":
        return 'ALl';
      case "PENDING":
        return 'Pending';
      case "VERIFIED":
        return 'Verified';
      case "APPROVED":
        return 'Approved';
      case "REJECTED":
        return 'Rejected';
      default:
        return 'NA';
    }
  }

  Widget dropDownList(BuildContext context, List<ProjectData>? listProject) {
    TextEditingController searchBar = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Select project',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: listProject == null
              ? []
              : listProject!
                  .map((item) => DropdownMenuItem(
                        value: item.projectname,
                        child: Text(
                          item.projectname!,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
          value: selectedProject,
          onChanged: (value) {
            selectedProject = value;
            context.read<InvoiceBloc>().getProjectSelected(value.toString());
          },
          buttonStyleData: ButtonStyleData(
            height: 45,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            // elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.keyboard_arrow_down,
            ),
            // iconSize: 14,
            iconEnabledColor: Colors.black,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 250,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              // color: Colors.redAccent,
            ),
            // offset: const Offset(-20, 0),
            scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all<double>(10.0),
                thumbVisibility: MaterialStateProperty.all<bool>(true),
                trackVisibility: MaterialStateProperty.all(true),
                interactive: true,
                trackColor: MaterialStateProperty.all(Colors.grey)),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
          dropdownSearchData: DropdownSearchData(
            searchController: searchBar,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: searchBar,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search...',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return item.value!
                  .toLowerCase()
                  .contains(searchValue.toLowerCase());
            },
          ),
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              searchBar.clear();
              // addInvoiceController.searchTextBar.clear();
            }
          },
        ),
      ),
    );
  }

  Widget listBuilder(BuildContext context, InvoiceModel invoiceList) {
    if (invoiceList.data == null) {
      return const Expanded(child: Center(child: CircularProgressIndicator()));
    } else {
      if (invoiceList.data!.isEmpty) {
        return Expanded(
          child: Center(
            child: Container(
              child: CustomTextStyle.regular(text: "No invoice added"),
            ),
          ),
        );
      } else {
        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 8, right: 8),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: invoiceList.data == null ? 0 : invoiceList.data!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  openBottomSheet(context, (key) {
                    if (key == "edit") {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddInvoiceScreen(
                            scheduleId: invoiceList.data![index].invoiceId!,
                            imageLogo: [],
                            imageList: [],
                          ),
                        ),
                      );
                    } else if (key == "delete") {
                      Navigator.pop(context);
                      Helper.deleteDialog(context,
                          "Do you want to delete an invoice no ${invoiceList.data![index].invoiceNo!}",
                          () {
                        context.read<InvoiceBloc>().deleteInvoice(
                            invoiceList.data![index].invoiceId!.toString());
                      });
                    } else if (key == "share") {
                      Share.share(invoiceList.data![index].shareUrl!);
                    } else if (key == "approve") {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InvoiceDetailsScreen(
                            invoiceId:
                                invoiceList.data![index].invoiceId!.toString(),
                          ),
                        ),
                      );
                    }
                  });
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Center(
                              child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4))),
                                  child: Helper.getIcon(
                                      invoiceList.data![index].invoiceStatus!)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextStyle.extraBold(
                                  text: invoiceList.data![index].vendorCmpny),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: AppColors.worningColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: CustomTextStyle.regular(
                                              text: invoiceList.data![index]
                                                      .projectname ??
                                                  "NA",
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              CustomTextStyle.regular(
                                  text:
                                      "Inv Ref: ${invoiceList.data![index].invref}"),
                              CustomTextStyle.regular(
                                  text: invoiceList.data![index].invcat),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomTextStyle.extraBold(
                                  text: double.parse(invoiceList
                                          .data![index].totalamount
                                          .toString())
                                      .toInt()
                                      .inRupeesFormat()),
                              const SizedBox(height: 4),
                              CustomTextStyle.regular(
                                  text: invoiceList.data![index].invDate),
                              const SizedBox(height: 8),
                              CustomTextStyle.regular(
                                  text: _getStatusText(invoiceList
                                      .data![index].invoiceStatus
                                      .toString())),
                              SizedBox(
                                height: 40,
                                width: 40,
                                // color: Colors.green,
                                child: Stack(
                                  children: [
                                    const Positioned(
                                      top: 20,
                                      left: 4,
                                      child: Icon(
                                        Icons.messenger,
                                        size: 20,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Positioned(
                                      top: 6,
                                      right: 4,
                                      child: Container(
                                        height: 24,
                                        width: 24,
                                        decoration: const BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                        child: Center(
                                          child: CustomTextStyle.extraBold(
                                              text:
                                                  "${invoiceList.data![index].commentCount.toString().length >= 99 ? invoiceList.data![index].commentCount.toString().length : invoiceList.data![index].commentCount.toString().length}",
                                              color: Colors.white,
                                              fontSize: 8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(height: 8),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
              return Card(
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3))),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                            color: Helper.getStatusColor(
                                invoiceList.data![index].status.toString()),
                            width: 5),
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextStyle.extraBold(
                                  text: invoiceList.data![index].projectname),
                              const SizedBox(
                                height: 4,
                              ),
                              CustomTextStyle.regular(
                                  text: invoiceList.data![index].invDate),
                              const SizedBox(
                                height: 4,
                              ),
                              CustomTextStyle.regular(
                                  text: invoiceList.data![index].vendorCmpny),
                            ],
                          ),
                          // SizedBox(width: 200,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextStyle.extraBold(
                                  text: double.parse(invoiceList
                                          .data![index].totalamount
                                          .toString())
                                      .toInt()
                                      .inRupeesFormat()),
                              CustomTextStyle.regular(
                                  text: _getStatusText(invoiceList
                                      .data![index].status
                                      .toString())),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
    }
  }

  Widget? buildBar(BuildContext context) {
    return AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      IconButton(
        icon: actionIcon,
        onPressed: () {
          setState(() {
            if (actionIcon.icon == Icons.search) {
              actionIcon = const Icon(
                Icons.close,
                color: Colors.white,
              );
              this.appBarTitle = new TextField(
                controller: _searchQuery,
                style: new TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.white),
                    hintText: "Search...",
                    hintStyle: new TextStyle(color: Colors.white)),
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]);
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

  Future openBottomSheet(BuildContext context, Function(String key) onClick) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  onClick("share");
                },
                child: ListTile(
                  title: const Text("Share"),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: const Icon(
                          Icons.share,
                          color: AppColors.primaryColor,
                        )),
                  ),
                ),
              ),
              /*ListTile(
                title: const Text("Get Link"),
                leading: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: const Icon(Icons.link)),
                ),
              ),*/
              InkWell(
                onTap: () {
                  onClick("edit");
                },
                child: ListTile(
                  title: const Text("Edit"),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: const Icon(
                          Icons.edit,
                          color: AppColors.primaryColor,
                        )),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onClick("delete");
                },
                child: ListTile(
                  title: const Text("Delete"),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: const Icon(
                          Icons.delete,
                          color: AppColors.primaryColor,
                        )),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onClick("approve");
                },
                child: ListTile(
                  title: const Text("Invoice Status"),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: const Icon(
                          Icons.check_circle_outline,
                          color: AppColors.primaryColor,
                        )),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
