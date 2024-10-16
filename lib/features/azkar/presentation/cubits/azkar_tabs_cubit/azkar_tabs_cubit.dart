import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/features/azkar/presentation/cubits/azkar_tabs_cubit/azkar_tabs_states.dart';

class AzkarTabsCubit extends Cubit<AzkarTabsState> {
  AzkarTabsCubit() : super(AllAzkarTab());

  void selectAllAzkarTab() {
    emit(AllAzkarTab());
  }

  void selectMemorizedAzkarTab() {
    emit(MemorizedAzkarTab());
  }
}