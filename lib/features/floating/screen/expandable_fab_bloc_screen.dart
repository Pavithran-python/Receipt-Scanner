import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/features/floating/bloc/fab_bloc.dart';
import 'package:scanner/features/floating/bloc/fab_event.dart';
import 'package:scanner/features/floating/bloc/fab_state.dart';

class ExpandableFabBlocScreen extends StatelessWidget {
  final Function(int) getSelectedOption;
  const ExpandableFabBlocScreen({super.key,required this.getSelectedOption});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FabBloc(),
      child: BlocBuilder<FabBloc, FabState>(
        builder: (context, state) {
          bool isExpanded = state is FabExpanded;
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isExpanded) ...[
                FloatingActionButton(
                  heroTag: 'gallery',
                  onPressed: () {
                    print("Gallery selected");
                    context.read<FabBloc>().add(CollapseFab());
                    getSelectedOption(0);
                  },
                  child: const Icon(Icons.photo_library),
                ),
                SizedBox(height: 20,),
                FloatingActionButton(
                  heroTag: 'camera',
                  onPressed: () {
                    print("Camera selected");
                    context.read<FabBloc>().add(CollapseFab());
                    getSelectedOption(1);
                  },
                  child: const Icon(Icons.camera_alt),
                ),
               SizedBox(height: 20,),
              ],
              FloatingActionButton(
                heroTag: 'main',
                onPressed: () {
                  context.read<FabBloc>().add(ToggleFab());
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    isExpanded ? Icons.close : Icons.add,
                    key: ValueKey<bool>(isExpanded),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
