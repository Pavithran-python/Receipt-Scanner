import 'package:flutter_bloc/flutter_bloc.dart';
import 'fab_event.dart';
import 'fab_state.dart';

class FabBloc extends Bloc<FabEvent, FabState> {
  FabBloc() : super(FabInitial()) {
    on<ToggleFab>((event, emit) {
      if (state is FabExpanded) {
        emit(FabCollapsed());
      } else {
        emit(FabExpanded());
      }
    });

    on<CollapseFab>((event, emit) {
      emit(FabCollapsed());
    });
  }
}
