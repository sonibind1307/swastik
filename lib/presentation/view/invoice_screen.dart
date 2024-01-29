import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swastik/config/RupeesConverter.dart';

import '../../model/responses/invoice_model.dart';
import '../../model/responses/project_model.dart';
import '../bloc/bloc_logic/invoice_bloc.dart';
import '../bloc/state/invoice_state.dart';
import '../widget/custom_text_style.dart';
import 'multipleImageScreen.dart';

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
        key: key,
        appBar: AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
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
                    controller: _searchQuery,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.white),
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
        body: BlocConsumer<InvoiceBloc, InvoiceState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedState) {
              return InkWell(
                onTap: () {
                  openBottomSheet(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    dropDownList(context, state.dataProject.data),
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
                            selectedColor: Colors.blue,
                            label: Text(_getChipStatusText(status)),
                            selected: _selectedStatus == status,
                            onSelected: (isSelected) {
                              if (isSelected) {
                                _selectedStatus = status;
                              }
                              print(_selectedStatus);
                              context
                                  .read<InvoiceBloc>()
                                  .chipChoiceCardSelected(
                                      _selectedStatus.toString());
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MultiImageScreen()),
            );
          },
          child: const Icon(Icons.camera_alt),
        ),
      ),
    );
  }

  String _getChipStatusText(String status) {
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "0":
        return Colors.grey;
      case "1":
        return Colors.orange;
      case "2":
        return Colors.green;
      case "3":
        return Colors.blueAccent;
      case "4":
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  Widget dropDownList(BuildContext context, List<ProjectData>? listProject) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Select Item',
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
        ),
      ),
    );
  }

  Widget listBuilder(BuildContext context, InvoiceModel invoiceList) {
    if (invoiceList.data == null) {
      return Expanded(child: Center(child: CircularProgressIndicator()));
    } else {
      return Expanded(
        child: ListView.builder(
          padding: EdgeInsets.only(left: 8, right: 8),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: invoiceList.data == null ? 0 : invoiceList.data!.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4))),
                          child:
                              getIcon(invoiceList.data![index].invoiceStatus!)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextStyle.extraBold(
                            text: invoiceList.data![index].vendorCmpny),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CustomTextStyle.regular(
                                    text: invoiceList.data![index].projectname,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            CustomTextStyle.regular(
                                text: invoiceList.data![index].invDate),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        CustomTextStyle.regular(
                            text:
                                "Inv.no: ${invoiceList.data![index].invoiceNo}"),
                        CustomTextStyle.regular(
                            text: invoiceList.data![index].invcat),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextStyle.extraBold(
                            text: double.parse(invoiceList
                                    .data![index].totalamount
                                    .toString())
                                .toInt()
                                .inRupeesFormat()),
                        const SizedBox(height: 50),
                        CustomTextStyle.regular(
                            text: _getStatusText(invoiceList
                                .data![index].invoiceStatus
                                .toString())),
                      ],
                    )
                  ],
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
                          color: _getStatusColor(
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

  Widget? getIcon(String status) {
    switch (status) {
      case "PENDING":
        return Icon(
          Icons.watch_later,
          color: Colors.orange,
        );
      case "APPROVED":
        return Icon(
          Icons.check_circle,
          color: Colors.green,
        );
      case "VERIFIED":
        return Icon(
          Icons.check_circle,
          color: Colors.blueAccent,
        );
      case "REJECTED":
        return Icon(
          Icons.cancel,
          color: Colors.red,
        );
      case "4":
        return Icon(
          Icons.watch_later,
          color: Colors.red,
        );
      default:
        return Icon(
          Icons.watch_later,
          color: Colors.red,
        );
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
      this.appBarTitle = new Text(
        "Search Sample",
        style: new TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }

  Future openBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text("Share"),
                leading: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Icon(Icons.share)),
                ),
              ),
              ListTile(
                title: Text("Get Link"),
                leading: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Icon(Icons.link)),
                ),
              ),
              ListTile(
                title: Text("Edit"),
                leading: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Icon(Icons.edit)),
                ),
              ),
              ListTile(
                title: Text("Delete"),
                leading: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: const Icon(Icons.delete)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
