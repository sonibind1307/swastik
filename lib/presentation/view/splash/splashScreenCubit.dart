import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swastik/config/Helper.dart';

import '../../../config/sharedPreferences.dart';
import '../../../repository/api_call.dart';

enum SplashScreenState { Initial, Loding, Dashboard, Login, Intro, Welcome }

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenState.Initial) {
    ///request location permission

    emit(SplashScreenState.Loding);

    /// if intro check is 1 then intro is viewed by user
    Auth.getUserID().then((value) {
      Timer(const Duration(seconds: 1), () {
        if (value == "") {
          emit(SplashScreenState.Login);
        } else {
          getToken();
          emit(SplashScreenState.Dashboard);
        }
      });
    });
  }

  Future<void> onUpdateToken({required String token}) async {
    String userId = await Auth.getUserID() ?? "0";
    final responseData = await ApiRepo.onUpdateToken(userId, token);
    if (responseData.status == "true") {
      Helper.getToastMsg(responseData.message!);
    }
  }

  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    String? dbFcm = await Auth.getFcmToken();
    if (token != dbFcm) {
      onUpdateToken(token: token!);
    }
  }
}
