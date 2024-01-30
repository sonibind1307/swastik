import '../../../model/responses/invoice_model.dart';
import '../../../model/responses/project_model.dart';

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
  final ProjectModel dataProject;
  final InvoiceModel dataInvoice;

  LoadedState(this.dataProject, this.dataInvoice);
}
