import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/Repository/ReceiptRepository.dart';
import 'receipt_event.dart';
import 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  final ReceiptRepository repository;
  ReceiptBloc(this.repository) : super(ReceiptLoading()) {
    on<LoadReceipts>((event, emit) async {
      final receipts = await repository.getReceipts();
      emit(ReceiptLoaded(receipts));
    });

    on<AddReceipt>((event, emit) async {
      await repository.insertReceipt(event.receipt);
      final receipts = await repository.getReceipts();
      emit(ReceiptLoaded(receipts));
    });

    on<DeleteReceipt>((event, emit) async {
      await repository.deleteReceipt(event.receiptId);
      final receipts = await repository.getReceipts();
      emit(ReceiptLoaded(receipts));
    });
  }
}