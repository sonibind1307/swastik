import '../../../model/responses/invoice_model.dart';
import '../../../model/responses/project_model.dart';

abstract class InvoiceState {}

class InitialState extends InvoiceState {}

class ValidState extends InvoiceState {}

class AlertState extends InvoiceState {
  final dynamic data;

  AlertState(this.data);
}

class LoadingState extends InvoiceState {}

class FormLoadingState extends InvoiceState {}

class ErrorState extends InvoiceState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}

class LoadedState extends InvoiceState {
  final List<ProjectData> dataProject;
  final InvoiceModel dataInvoice;

  LoadedState(this.dataProject, this.dataInvoice);
}
