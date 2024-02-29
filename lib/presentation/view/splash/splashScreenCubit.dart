import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/sharedPreferences.dart';

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
          emit(SplashScreenState.Dashboard);
        }
      });
    });
  }
}
