import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swastik/config/Helper.dart';
import 'package:swastik/presentation/widget/custom_text_style.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../config/colorConstant.dart';
import '../../../controller/task_list_controller.dart';
import '../../../model/responses/vendor_model.dart';
import 'add_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  TaskListScreen({super.key});

  static var kToday = DateTime.now();
  static var kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
  static var kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.week;

  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  final reasonController = TextEditingController();

  final controller = Get.find<TaskListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTaskScreen()),
            );
          },
          label: const Text("Create Task")),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            TableCalendar(
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              firstDay: TaskListScreen.kFirstDay,
              lastDay: TaskListScreen.kLastDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  setState(() {});
                  // context
                  //     .read<DocHomeScreenBloc>()

                  
                  //     .dateWiseAppointments(_focusedDay);
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  _calendarFormat = format;
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Card(
            //     child: TextField(
            //       onChanged: (value) {
            //         controller.onSearchVendor(value.toString());
            //       },
            //       controller: TextEditingController(),
            //       decoration: const InputDecoration(
            //           labelText: "Search",
            //           hintText: "Search",
            //           prefixIcon: Icon(Icons.search),
            //           border: OutlineInputBorder(
            //               borderRadius:
            //                   BorderRadius.all(Radius.circular(8.0)))),
            //     ),
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () => CustomTextStyle.regular(
                      text: "Count : ${controller.vendorList.length}"),
                ),
                const SizedBox(
                  width: 16,
                )
              ],
            ),
            Obx(
              () => controller.isLoading.value == false
                  ? Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          controller.getAllVendorList();
                        },
                        child: controller.vendorList.isNotEmpty
                            ? ListView.separated(
                                itemCount: controller.vendorList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  VendorData data =
                                      controller.vendorList[index];

                                  return Card(
                                    child: InkWell(
                                      onTap: () {
                                        openBottomSheet(context, (key) async {
                                          if (key == "edit") {
                                            Navigator.of(context).pop();

                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           AddVendorScreen(
                                            //             vendorData: data,
                                            //           )),
                                            // );
                                          } else if (key == "call") {
                                            if (data.contactNo != null &&
                                                data.contactNo! != "") {
                                              Helper.makePhoneCall(
                                                  data.contactNo!);
                                            }
                                          } else if (key == "email") {
                                            if (data.email != null &&
                                                data.email! != "" &&
                                                data.email!.toLowerCase() !=
                                                    "na") {
                                              Helper.sendEmail(data.email!);
                                            } else {
                                              Helper.getToastMsg(
                                                  "Email not found");
                                            }
                                          }
                                        }, data);
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 0, 0, 0),
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF1F4F8),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xFFE5E7EB),
                                                ),
                                              ),
                                              child: Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        0, 0),
                                                child: Icon(Icons.task_alt),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(12, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            -1, -1),
                                                    child: CustomTextStyle.bold(
                                                        text: "Task Title"),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: CustomTextStyle
                                                            .regular(
                                                                text:
                                                                    "Projet Name",
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            -1, 0),
                                                    child:
                                                        CustomTextStyle.regular(
                                                            text: "Description",
                                                            color: Colors.grey),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            -1, 0),
                                                    child:
                                                        CustomTextStyle.regular(
                                                            text:
                                                                "Date : 20-07-24",
                                                            color: Colors.grey),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        0, -1),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              1, 0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: CustomTextStyle
                                                            .regular(
                                                                text: "High",
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            1, 0),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: CustomTextStyle
                                                            .regular(
                                                                text: "",
                                                                color: Colors
                                                                    .black)),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Helper
                                                              .getStatusColor(
                                                                  "2"),
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          4))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: CustomTextStyle
                                                            .regular(
                                                                text: "Status",
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                  ),
                                                  /* Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            1, 0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: CustomTextStyle
                                                          .regular(
                                                        text:
                                                            "${data.chlStatus}",
                                                        color: Helper
                                                            .getStatusColor(
                                                                "${data.chlStatus}"),
                                                      ),
                                                    ),
                                                  ),*/
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 4,
                                  );
                                },
                              )
                            : SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Center(
                                    child: CustomTextStyle.regular(
                                        text: "No data found")),
                              ),
                      ),
                    )
                  : const Expanded(
                      child: Center(child: CircularProgressIndicator())),
            ),
          ],
        ),
      ),
    );
  }

  Future openBottomSheet(BuildContext context, Function(String key) onClick,
      VendorData vendorData) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: CustomTextStyle.bold(
                    text: "Vendor: ${vendorData.companyName}",
                    color: Colors.white,
                    fontSize: 16),
              ),
              // Row(
              //   children: [
              //     const Spacer(),
              //     CustomTextStyle.regular(text: "Total amount :"),
              //     const SizedBox(
              //       width: 8,
              //     ),
              //     CustomTextStyle.bold(
              //         text: double.parse("0").toInt().inRupeesFormat(),
              //         fontSize: 14),
              //     const SizedBox(
              //       width: 8,
              //     ),
              //   ],
              // ),
              InkWell(
                onTap: () {
                  onClick("edit");
                },
                child: ListTile(
                  title: const Text("Edit Vendor"),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: const Icon(Icons.edit)),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onClick("email");
                },
                child: ListTile(
                  title: const Text("Email"),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: const Icon(Icons.email)),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onClick("call");
                },
                child: ListTile(
                  title: const Text("Call"),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: const Icon(Icons.call)),
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
