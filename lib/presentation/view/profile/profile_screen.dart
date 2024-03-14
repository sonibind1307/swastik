import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swastik/config/colorConstant.dart';
import 'package:swastik/presentation/view/profile/profile_controller.dart';

import '../../../model/responses/project_model.dart';
import '../../widget/app_widget.dart';
import '../../widget/custom_text_style.dart';

class ProfileScreen extends StatefulWidget {
  static var tag = "/profile_one";

  final bool isDirect;

  ProfileScreen({this.isDirect = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Get.find<ProfileController>();

  Widget counter(String counter, String counterName) {
    return Column(
      children: <Widget>[
        CustomTextStyle.bold(text: counter, color: AppColors.primaryColor),
        CustomTextStyle.regular(text: counterName),
      ],
    );
  }

  @override
  void initState() {
    controller.init();
    controller.getAllProject();
    controller.myProjectLsi();
  }

  @override
  Widget build(BuildContext context) {
    final profileImg = Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: FractionalOffset.center,
        child: CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.primaryColor,
          child: Obx(
            () => CustomTextStyle.bold(
                text: controller.userName.value.toUpperCase().substring(0, 1),
                color: Colors.white,
                fontSize: 40),
          ),
        ));
    final profileContent = Container(
      margin: const EdgeInsets.only(top: 55.0),
      decoration:
          boxDecoration(bgColor: Colors.white, radius: 10, showShadow: true),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
            Obx(
              () => CustomTextStyle.bold(
                  text: controller.name.value == ""
                      ? "NA"
                      : controller.name.value),
            ),
            const SizedBox(height: 8),
            CustomTextStyle.regular(
                text: controller.email.value == ""
                    ? "NA"
                    : controller.email.value),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Divider(color: Colors.grey, height: 0.5),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: <Widget>[
            //     counter("100", "label 1"),
            //     counter("50", "label 2"),
            //     counter("60", "Videos 3"),
            //   ],
            // ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 0, left: 2, right: 2),
        physics: const ScrollPhysics(),
        child: Container(
          // height: MediaQuery.of(context).size.height * 1.5,
          color: Colors.white,
          child: Obx(
            () => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      const SizedBox(height: 50),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Stack(
                          children: <Widget>[profileContent, profileImg],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        decoration: boxDecoration(
                            bgColor: Colors.white,
                            radius: 10,
                            showShadow: true),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 8),
                              rowHeading("Personal"),
                              const SizedBox(height: 16),
                              Obx(
                                () => profileText(
                                    controller.userName.value == ""
                                        ? "NA"
                                        : controller.userName.value),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 10, 16, 10),
                                child: view(),
                              ),
                              const SizedBox(height: 8),
                              Obx(
                                () => profileText(controller.phone.value == ""
                                    ? "NA"
                                    : controller.phone.value),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 10, 16, 10),
                                child: view(),
                              ),
                              const SizedBox(height: 8),
                              Obx(
                                () => profileText(
                                    controller.designation.value == ""
                                        ? "NA"
                                        : controller.designation.value),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        decoration: boxDecoration(
                            bgColor: AppColors.white200,
                            radius: 10,
                            showShadow: true),
                        child: expansionTile(context),
                      ),
                      Obx(
                        () => controller.isOpen.value
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      controller.onUpdateProfile(context);
                                    },
                                    child: const Text("Update"),
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget expansionTile(BuildContext context) {
    return ExpansionTile(
        collapsedBackgroundColor: Colors.white,
        onExpansionChanged: (bool expanding) {
          controller.onExpansionChanged();
        },
        title: const Text("My Projects"),
        children: [
          SizedBox(
            height: 200,
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.vertical,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.allProjectList.length,
                itemBuilder: (BuildContext context, int index) {
                  // if (index == controller.allProjectList.length) {
                  //   return Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Align(
                  //       alignment: Alignment.centerRight,
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           controller.onUpdateProfile();
                  //         },
                  //         child: const Text("Update"),
                  //       ),
                  //     ),
                  //   );
                  // } else {
                  ProjectData data = controller.allProjectList[index];
                  return ListTile(
                    leading: Obx(
                      () => Checkbox(
                        value: controller.myProjectList.any((element) =>
                            element.projectcode ==
                            controller.allProjectList[index].projectcode),
                        onChanged: (isChecked) {
                          if (isChecked!) {
                            controller.myProjectList.add(data);
                          } else {
                            controller.myProjectList.removeWhere(
                                (obj) => obj.projectcode == data.projectcode);
                          }
                        },
                      ),
                    ),
                    title: Text(data.projectname!),
                  );
                  //}
                },
              ),
            ),
          )
        ]);
  }
}
