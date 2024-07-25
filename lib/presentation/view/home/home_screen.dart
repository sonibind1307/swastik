import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swastik/config/Helper.dart';
import 'package:swastik/presentation/widget/custom_text_style.dart';

import '../../../controller/invoice_dashboard_controller.dart';
import '../../widget/app_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.find<InvoiceDashboardController>();

  @override
  void initState() {
    controller.onGetInvoiceDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Obx(
        () => controller.isLoading == false
            ? ListView(
                children: [
                  Container(
                    decoration: boxDecoration(showShadow: true),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextStyle.semiBold(
                            text: "Recent Activity", fontSize: 20),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextStyle.regular(
                            text:
                                "Below is overview of tasks & activity completed.",
                            color: Colors.grey,
                            fontSize: 16),
                        Row(
                          children: [
                            Radio(
                                value: "true",
                                groupValue: "groupValue",
                                onChanged: (value) {
                                  Helper().showServerErrorDialog(
                                      context, "Server error", () async {
                                    FocusScope.of(context).unfocus();
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  });
                                }),
                            CustomTextStyle.regular(text: "Tasks"),
                            Radio(
                                value: "true",
                                groupValue: "groupValue",
                                onChanged: (value) {}),
                            CustomTextStyle.regular(text: "Completed"),
                          ],
                        ),
                        Container(
                          height: 100,
                          color: Colors.grey[100],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => buildStatusContainer(
                              context,
                              "Pending",
                              Helper.getStatusColor("1"),
                              controller.pendingCount.toString(),
                              Icons.watch_later),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: buildStatusContainer(
                            context,
                            "Verified",
                            Helper.getStatusColor("3"),
                            controller.verifiedCount.toString(),
                            Icons.verified),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildStatusContainer(
                            context,
                            "Approved",
                            Helper.getStatusColor("2"),
                            controller.approvedCount.toString(),
                            Icons.check_circle),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: buildStatusContainer(
                            context,
                            "Rejected",
                            Helper.getStatusColor("4"),
                            controller.rejectedCount.toString(),
                            Icons.cancel),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // Generated code for this Column Widget...
                  Container(
                    decoration: boxDecoration(showShadow: true),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 12, 0, 4),
                            child: CustomTextStyle.bold(
                                text: "Tasks", fontSize: 24),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 0, 0, 0),
                            child: CustomTextStyle.regular(
                                text: "A summary of outstanding tasks.",
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 4, 0, 0),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 1),
                                  child: Container(
                                    width: 100,
                                    height: 110,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 0,
                                          color: Color(0xFFE0E3E7),
                                          offset: Offset(0, 1),
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 2),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 8, 0, 8),
                                            child: Container(
                                              width: 4,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF4B39EF),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(12, 12, 12, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 0, 0, 4),
                                                    child:
                                                        CustomTextStyle.regular(
                                                            text: "Task Type"),
                                                  ),
                                                  CustomTextStyle.regular(
                                                      text:
                                                          "Task Description here this one is really long",
                                                      fontSize: 14),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 8, 0, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 0, 4, 0),
                                                          child: CustomTextStyle
                                                              .regular(
                                                                  text: "Due",
                                                                  fontSize: 12),
                                                        ),
                                                        Expanded(
                                                          child: CustomTextStyle
                                                              .regular(
                                                                  text:
                                                                      "Plus Jakarta Sans",
                                                                  fontSize: 14),
                                                        ),
                                                        // Padding(
                                                        //   padding: EdgeInsetsDirectional
                                                        //       .fromSTEB(0, 0, 8, 0),
                                                        //   child: badges.Badge(
                                                        //     badgeContent: Text(
                                                        //       '1',
                                                        //       style: FlutterFlowTheme.of(
                                                        //               context)
                                                        //           .bodyMedium
                                                        //           .override(
                                                        //             fontFamily:
                                                        //                 'Plus Jakarta Sans',
                                                        //             color: Colors.white,
                                                        //             fontSize: 14,
                                                        //             fontWeight:
                                                        //                 FontWeight.w500,
                                                        //           ),
                                                        //     ),
                                                        //     showBadge: true,
                                                        //     shape:
                                                        //         badges.BadgeShape.circle,
                                                        //     badgeColor: Color(0xFF4B39EF),
                                                        //     elevation: 4,
                                                        //     padding: EdgeInsets.all(8),
                                                        //     position: badges.BadgePosition
                                                        //         .topStart(),
                                                        //     animationType: badges
                                                        //         .BadgeAnimationType.scale,
                                                        //     toAnimate: true,
                                                        //     child: Padding(
                                                        //       padding:
                                                        //           EdgeInsetsDirectional
                                                        //               .fromSTEB(
                                                        //                   16, 4, 0, 0),
                                                        //       child: Text(
                                                        //         'Update',
                                                        //         style: FlutterFlowTheme
                                                        //                 .of(context)
                                                        //             .bodyMedium
                                                        //             .override(
                                                        //               fontFamily:
                                                        //                   'Plus Jakarta Sans',
                                                        //               color: Color(
                                                        //                   0xFF4B39EF),
                                                        //               fontSize: 14,
                                                        //               fontWeight:
                                                        //                   FontWeight.w500,
                                                        //             ),
                                                        //       ),
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 1),
                                  child: Container(
                                    width: 100,
                                    height: 110,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 0,
                                          color: Color(0xFFE0E3E7),
                                          offset: Offset(0, 1),
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 2),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 8, 0, 8),
                                            child: Container(
                                              width: 4,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF4B39EF),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(12, 12, 12, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 0, 0, 4),
                                                    child:
                                                        CustomTextStyle.regular(
                                                            text: "Task Type"),
                                                  ),
                                                  CustomTextStyle.regular(
                                                      text:
                                                          "Task Description here this one is really long"),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 8, 0, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        CustomTextStyle.regular(
                                                            text: "Due",
                                                            fontSize: 12),
                                                        CustomTextStyle.regular(
                                                            text:
                                                                "Today, 5:30pm",
                                                            fontSize: 12),
                                                        Expanded(
                                                          child: CustomTextStyle
                                                              .regular(
                                                                  text:
                                                                      "oday, 5:30pm",
                                                                  fontSize: 14),
                                                        ),
                                                        // Padding(
                                                        //   padding: EdgeInsetsDirectional
                                                        //       .fromSTEB(0, 0, 8, 0),
                                                        //   child: badges.Badge(
                                                        //     badgeContent: Text(
                                                        //       '1',
                                                        //       style: FlutterFlowTheme.of(
                                                        //               context)
                                                        //           .bodyMedium
                                                        //           .override(
                                                        //             fontFamily:
                                                        //                 'Plus Jakarta Sans',
                                                        //             color: Colors.white,
                                                        //             fontSize: 14,
                                                        //             fontWeight:
                                                        //                 FontWeight.w500,
                                                        //           ),
                                                        //     ),
                                                        //     showBadge: true,
                                                        //     shape:
                                                        //         badges.BadgeShape.circle,
                                                        //     badgeColor: Color(0xFF4B39EF),
                                                        //     elevation: 4,
                                                        //     padding: EdgeInsets.all(8),
                                                        //     position: badges.BadgePosition
                                                        //         .topStart(),
                                                        //     animationType: badges
                                                        //         .BadgeAnimationType.scale,
                                                        //     toAnimate: true,
                                                        //     child: Padding(
                                                        //       padding:
                                                        //           EdgeInsetsDirectional
                                                        //               .fromSTEB(
                                                        //                   16, 4, 0, 0),
                                                        //       child: Text(
                                                        //         'Update',
                                                        //         style: FlutterFlowTheme
                                                        //                 .of(context)
                                                        //             .bodyMedium
                                                        //             .override(
                                                        //               fontFamily:
                                                        //                   'Plus Jakarta Sans',
                                                        //               color: Color(
                                                        //                   0xFF4B39EF),
                                                        //               fontSize: 14,
                                                        //               fontWeight:
                                                        //                   FontWeight.w500,
                                                        //             ),
                                                        //       ),
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )

                  /*Container(
              decoration: boxDecoration(showShadow: true),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextStyle.semiBold(text: "Tasks", fontSize: 20),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTextStyle.regular(
                      text: "A summary of outstanding tasks.",
                      color: Colors.grey,
                      fontSize: 16),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: 4,
                              height: double.infinity,
                              color: Colors.red,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                CustomTextStyle.regular(text: "Tasks"),
                                CustomTextStyle.regular(text: "Tasks"),
                                CustomTextStyle.regular(text: "Tasks"),
                                CustomTextStyle.regular(text: "Tasks"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 100,
                    color: Colors.grey[100],
                  )
                ],
              ),
            ),*/
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Container buildStatusContainer(BuildContext context, String title,
      Color color, String count, IconData icon) {
    return Container(
        height: 80,
        decoration: boxDecoration(showShadow: false),
        child: // Generated code for this orderCard Widget...
            Container(
          width: MediaQuery.sizeOf(context).width * 0.45,
          height: 80,
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
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child:
                              CustomTextStyle.bold(text: count, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              icon,
                              color: color,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
