import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/core/repositories/bill_repository.dart';
import 'bill_detail_event.dart';
import 'bill_detail_state.dart';

class BillDetailBloc extends Bloc<BillDetailEvent, BillDetailState> {
  final BillRepository repository;

  BillDetailBloc(this.repository) : super(BillDetailInitial()) {
    on<GetBill>((event, emit) async {
      emit(BillGetDetailLoading());
      try {
        final bill = await repository.getBillDetail(event.id);
        emit(BillOperationSuccess(bill));
      } catch (e) {
        emit(BillDetailError(e.toString()));
      }
    });

    on<AddBill>((event, emit) async {
      emit(BillDetailLoading());
      try {
        final bill = await repository.createBill(event.bill);
        emit(BillOperationSuccess(bill));
      } catch (e) {
        emit(BillDetailError(e.toString()));
      }
    });

    on<UpdateBill>((event, emit) async {
      emit(BillDetailLoading());
      try {
        final updated = await repository.updateBill(event.id, event.updates);
        emit(BillOperationSuccess(updated));
      } catch (e) {
        emit(BillDetailError(e.toString()));
      }
    });

    on<DeleteBill>((event, emit) async {
      emit(BillDeleteLoading());
      try {
        final result = await repository.deleteBill(event.id);
        emit(DeleteBillSuccess(result));
      } catch (e) {
        emit(BillDetailError(e.toString()));
      }
    });

    on<UploadImageEvent>((event, emit) async {
      emit(BillDetailLoading());
      try {
        final res = await repository.uploadImage(event.base64);
        emit(ImageUploadSuccess(res));
      } catch (e) {
        emit(BillDetailError(e.toString()));
      }
    });
  }
}