import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swastik/config/Helper.dart';
import 'package:swastik/presentation/widget/custom_text_style.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../config/colorConstant.dart';
import '../../../controller/task_list_controller.dart';
import '../../../model/responses/task_list_model.dart';
import '../../widget/app_widget.dart';
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
  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime? _selectedDay;

  final reasonController = TextEditingController();

  final controller = Get.find<TaskListController>();

  Widget _buildEventsMarker(DateTime date, List value) {
    List<Event> events = value as List<Event>;
    return true
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: events.map((item) {
              return Container(
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.color,
                ),
                width: 8.0,
                height: 8.0,
              );
            }).toList(),
          )
        : Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            width: 16.0,
            height: 16.0,
            child: Center(
              child: Text(
                '${events.length}',
                style: const TextStyle()
                    .copyWith(color: Colors.white, fontSize: 12.0),
              ),
            ),
          );
  }

  @override
  void initState() {
    super.initState();

    _selectedDay = controller.focusedDay;
    controller.getTaskBasedOnDate(controller.focusedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddTaskScreen()),
            );
          },
          label: const Text("Create Task")),
      body: Container(
        color: Colors.grey.withOpacity(0.01),
        child: Column(
          children: [
            Obx(
              () => controller.isCalendar.value == true
                  ? TableCalendar(
                      weekendDays: const [DateTime.saturday, DateTime.sunday],
                      calendarFormat: _calendarFormat,
                      focusedDay: controller.focusedDay,
                      firstDay: TaskListScreen.kFirstDay,
                      lastDay: TaskListScreen.kLastDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_selectedDay, selectedDay)) {
                          // Call `setState()` when updating the selected day
                          _selectedDay = selectedDay;
                          controller.focusedDay = focusedDay;
                          setState(() {
                            controller
                                .getTaskBasedOnDate(controller.focusedDay);
                          });
                        }
                      },
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          // Call `setState()` when updating calendar format

                          setState(() {
                            _calendarFormat = format;
                            print("onPageChanges --- ");
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        // No need to call `setState()` here

                        setState(() {
                          controller.focusedDay = focusedDay;
                          print("onPageChanges1 --- ");
                          controller.getAllVendorList(controller.focusedDay);
                        });
                      },
                      eventLoader: controller.getEventsForDay,
                      calendarBuilders: CalendarBuilders(
                        markerBuilder: (context, date, events) {
                          if (events.isNotEmpty) {
                            return Positioned(
                              right: 1,
                              bottom: 1,
                              child: _buildEventsMarker(date, events),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          // Change this color to your desired color
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: AppColors.bsWarning,
                          // Change this color to your desired color
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : const CircularProgressIndicator(),
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

            SizedBox(
              height: 4,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 16,
                ),
                CustomTextStyle.bold(
                    text: Helper.convertDate(controller.focusedDay!),
                    fontSize: 18),
                Spacer(),
                Obx(
                  () => CustomTextStyle.regular(
                      text: "Count : ${controller.taskList.length}"),
                ),
                const SizedBox(
                  width: 16,
                )
              ],
            ),
            Obx(
              () => controller.isLoading.value == false
                  ? controller.taskList.isNotEmpty
                      ? Expanded(
                          child: ListView.separated(
                            itemCount: controller.taskList.length,
                            itemBuilder: (BuildContext context, int index) {
                              TaskData data = controller.taskList[index];
                              return InkWell(
                                onTap: () {
                                  openBottomSheet(context, (key) {}, data);
                                },
                                child: Container(
                                    margin: const EdgeInsets.all(8),
                                    decoration:
                                        boxDecoration(showShadow: false),
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(1),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: controller
                                                      .getTaskCardColor(
                                                          data.priority!,
                                                          data.status!)),
                                              width: 8.0,
                                              height: 8.0,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            CustomTextStyle.regular(
                                                text: data.priority!
                                                    .toUpperCase(),
                                                color:
                                                    controller.getTaskCardColor(
                                                        data.priority!,
                                                        data.status!),
                                                fontSize: 16),
                                            const Spacer(),
                                            Container(
                                                decoration: BoxDecoration(
                                                    color: controller
                                                        .getTaskCardColor(
                                                            data.priority!,
                                                            data.status!),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                4))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child:
                                                      CustomTextStyle.regular(
                                                          text: data.status!
                                                              .toUpperCase(),
                                                          color: Colors.white),
                                                )),
                                          ],
                                        ),
                                        const Divider(
                                          thickness: 1.5,
                                        ),
                                        buildStatusContainer(
                                            context,
                                            data.taskTitle!,
                                            controller.getTaskCardColor(
                                                data.priority!, data.status!),
                                            data.projectname!,
                                            data.assignedByNames!,
                                            Icons.watch_later),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            const Icon(
                                              Icons.watch_later_outlined,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            CustomTextStyle.regular(
                                                text: Helper.getConvertTime(
                                                    "1",
                                                    data.targetDate!
                                                        .substring(11, 19))),
                                            const SizedBox(
                                              width: 32,
                                            ),
                                            const Icon(
                                              Icons.people_alt_outlined,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            CustomTextStyle.regular(
                                                text:
                                                    "${data.assignedTo!.split(',').length} Person"),
                                            const SizedBox(
                                              width: 32,
                                            ),
                                            const Icon(
                                              Icons.attach_file,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            CustomTextStyle.regular(
                                                text: "Attachment"),
                                          ],
                                        )
                                      ],
                                    )),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 2,
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: CustomTextStyle.regular(
                              text: "No task available for selected date"),
                        ))
                  : const Expanded(
                      child: Center(child: CircularProgressIndicator())),
            ),
          ],
        ),
      ),
    );
  }

  Future openBottomSheet(
      BuildContext context, Function(String key) onClick, TaskData rowData) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                    text: "Title: ${rowData.taskTitle}",
                    color: Colors.white,
                    fontSize: 16),
              ),
              Container(
                  padding: const EdgeInsets.all(8),
                  child: CustomTextStyle.regular(text: rowData.taskDesc))
            ],
          ),
        );
      },
    );
  }

  Container buildStatusContainer(BuildContext context, String title,
      Color color, String pName, String assignBy, IconData icon) {
    return Container(
      // width: MediaQuery.sizeOf(context).width * 0.45,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        // boxShadow: const [
        //   BoxShadow(
        //     blurRadius: 12,
        //     color: Color(0x34000000),
        //     offset: Offset(-2, 5),
        //   )
        // ],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 12, 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 5,
              height: double.infinity,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: CustomTextStyle.bold(text: title, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextStyle.regular(text: pName),
                    const SizedBox(
                      height: 4,
                    ),
                    CustomTextStyle.regular(
                        text: "Assign by: $assignBy", color: Colors.grey),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Icon(
                        //   icon,
                        //   color: color,
                        //   size: 24,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
