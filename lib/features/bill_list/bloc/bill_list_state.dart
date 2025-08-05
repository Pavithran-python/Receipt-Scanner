import 'package:scanner/features/bills/models/bill_model.dart';

abstract class BillListState {}

class BillListInitial extends BillListState {}

class BillListLoading extends BillListState {}

class BillListLoaded extends BillListState {
  final List<Bill> bills;
  BillListLoaded(this.bills);
}

class BillListError extends BillListState {
  final String message;
  BillListError(this.message);
}
