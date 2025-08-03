import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/core/repositories/bill_repository.dart';
import 'bills_event.dart';
import 'bills_state.dart';

class BillBloc extends Bloc<BillEvent, BillState> {
  final BillRepository repository;

  BillBloc(this.repository) : super(BillInitial()) {
    on<LoadBills>((event, emit) async {
      emit(BillLoading());
      try {
        final bills = await repository.getBills();
        emit(BillLoaded(bills));
      } catch (e) {
        emit(BillError(e.toString()));
      }
    });

    on<AddBill>((event, emit) async {
      emit(BillLoading());
      try {
        final bill = await repository.createBill(event.bill);
        emit(BillOperationSuccess(bill));
        add(LoadBills());
      } catch (e) {
        emit(BillError(e.toString()));
      }
    });

    on<UpdateBill>((event, emit) async {
      emit(BillLoading());
      try {
        final updated = await repository.updateBill(event.id, event.updates);
        emit(BillOperationSuccess(updated));
      } catch (e) {
        emit(BillError(e.toString()));
      }
    });

    on<DeleteBill>((event, emit) async {
      emit(BillLoading());
      try {
        final delete =await repository.deleteBill(event.id);
        emit(DeleteBillSuccess(delete));
        add(LoadBills());
      } catch (e) {
        emit(BillError(e.toString()));
      }
    });

    on<UploadImageEvent>((event, emit) async {
      emit(BillLoading());
      try {
        final response = await repository.uploadImage(event.base64);
        emit(ImageUploadSuccess(response));
      } catch (e) {
        emit(BillError(e.toString()));
      }
    });

    // bills_bloc.dart
    /*on<AddBillToListEvent>((event, emit) {
      if (state is BillLoaded) {
        final currentBills = List<Bill>.from((state as BillLoaded).bills);
        currentBills.insert(0, event.newBill); // add to top
        emit(BillLoaded(currentBills));
      }
    });*/

  }

}
