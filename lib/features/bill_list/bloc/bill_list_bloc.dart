import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/core/repositories/bill_repository.dart';
import 'package:scanner/features/bill_list/bloc/bill_list_state.dart';
import 'package:scanner/features/bills/models/bill_model.dart';
import 'bill_list_event.dart';

class BillListBloc extends Bloc<BillListEvent, BillListState> {
  final BillRepository repository;
  List<Bill> _cachedBills = [];

  BillListBloc(this.repository) : super(BillListInitial()) {
    on<LoadBills>((event, emit) async {
      emit(BillListLoading());
      try {
        final bills = await repository.getBills();
        _cachedBills = bills;
        emit(BillListLoaded(bills));
      } catch (e) {
        emit(BillListError(e.toString()));
      }
    });

    on<AddBillToListEvent>((event, emit) {
      _cachedBills.insert(0, event.newBill);
      emit(BillListLoaded(List.from(_cachedBills)));
    });

    on<UpdateBillToListEvent>((event, emit) {
      if (state is BillListLoaded) {
        final currentBills = List<Bill>.from((state as BillListLoaded).bills);
        final index = currentBills.indexWhere((b) => b.id == event.updateBill.id);
        if (index != -1) {
          currentBills[index] = event.updateBill;
          emit(BillListLoaded(currentBills));
        }
      }
    });

    on<DeleteBillToListEvent>((event, emit) {
      _cachedBills.removeWhere((Bill getBill)=> getBill.id==event.billId);
      emit(BillListLoaded(List.from(_cachedBills)));
    });


  }
}