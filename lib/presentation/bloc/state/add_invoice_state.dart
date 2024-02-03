import 'package:swastik/model/responses/vendor_model.dart';

import '../../../model/responses/invoice_model.dart';
import '../../../model/responses/project_model.dart';

abstract class AddInvoiceState {}

class InitialState extends AddInvoiceState {}

class ValidState extends AddInvoiceState {}

class AlertState extends AddInvoiceState {
  final dynamic data;

  AlertState(this.data);
}

class LoadingState extends AddInvoiceState {}

class FormLoadingState extends AddInvoiceState {}

class ErrorState extends AddInvoiceState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}

class LoadedState extends AddInvoiceState {
  final ProjectModel dataProject;
  final InvoiceModel dataInvoice;

  LoadedState(this.dataProject, this.dataInvoice);
}

class LoadedVendorState extends AddInvoiceState {
  final VendorModel dataVendor;

  LoadedVendorState(this.dataVendor);
}

class VendorSelectedState extends AddInvoiceState {
  final VendorData dataVendor;

  VendorSelectedState(this.dataVendor);
}

class SecondVendorState extends AddInvoiceState {
  final ProjectModel projectModel;
  SecondVendorState(this.projectModel);
}
