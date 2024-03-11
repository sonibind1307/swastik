import 'package:flutter/material.dart';
import 'package:swastik/presentation/widget/custom_text_style.dart';

import '../../widget/app_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: ListView(
        children: [
          Container(
            decoration: boxDecoration(showShadow: true),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextStyle.semiBold(text: "Recent Activity", fontSize: 20),
                const SizedBox(
                  height: 8,
                ),
                CustomTextStyle.regular(
                    text: "Below is overview of tasks & activity completed.",
                    color: Colors.grey,
                    fontSize: 16),
                Row(
                  children: [
                    Radio(
                        value: "true",
                        groupValue: "groupValue",
                        onChanged: (value) {}),
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
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 80,
                    decoration: boxDecoration(showShadow: true),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    height: 80,
                    decoration: boxDecoration(showShadow: true),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          // Generated code for this Column Widget...
          Container(
            decoration: boxDecoration(showShadow: true),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 4),
                    child: CustomTextStyle.bold(text: "Tasks", fontSize: 24),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                    child: CustomTextStyle.regular(
                        text: "A summary of outstanding tasks.",
                        fontSize: 14,
                        color: Colors.grey),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                          child: Container(
                            width: 100,
                            height: 110,
                            decoration: BoxDecoration(
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
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 8, 0, 8),
                                    child: Container(
                                      width: 4,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF4B39EF),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 12, 12, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 4),
                                            child: CustomTextStyle.regular(
                                                text: "Task Type"),
                                          ),
                                          CustomTextStyle.regular(
                                              text:
                                                  "Task Description here this one is really long",
                                              fontSize: 14),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 8, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 4, 0),
                                                  child:
                                                      CustomTextStyle.regular(
                                                          text: "Due",
                                                          fontSize: 12),
                                                ),
                                                Expanded(
                                                  child: CustomTextStyle.regular(
                                                      text: "Plus Jakarta Sans",
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                          child: Container(
                            width: 100,
                            height: 110,
                            decoration: BoxDecoration(
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
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 8, 0, 8),
                                    child: Container(
                                      width: 4,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF4B39EF),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 12, 12, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 0, 4),
                                            child: CustomTextStyle.regular(
                                                text: "Task Type"),
                                          ),
                                          CustomTextStyle.regular(
                                              text:
                                                  "Task Description here this one is really long"),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 8, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                CustomTextStyle.regular(
                                                    text: "Due", fontSize: 12),
                                                CustomTextStyle.regular(
                                                    text: "Today, 5:30pm",
                                                    fontSize: 12),
                                                Expanded(
                                                  child:
                                                      CustomTextStyle.regular(
                                                          text: "oday, 5:30pm",
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
      ),
    );
  }
}
