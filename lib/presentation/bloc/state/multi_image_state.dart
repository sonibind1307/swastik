import 'dart:io';

abstract class MultiImageState {}

class InitialState extends MultiImageState {}

class ValidState extends MultiImageState {}

class AlertState extends MultiImageState {
  final dynamic data;

  AlertState(this.data);
}

class LoadingState extends MultiImageState {}

class FormLoadingState extends MultiImageState {}

class ErrorState extends MultiImageState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}

class LoadedState extends MultiImageState {
  List<File> imageList;

  LoadedState(this.imageList);
}
