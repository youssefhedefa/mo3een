import 'package:bloc/bloc.dart';

abstract class ZekrCounterState {}

class ZekrCounterInitial extends ZekrCounterState {}

class ZekrCounterIncrement extends ZekrCounterState {
  final int count;
  final int index;
  ZekrCounterIncrement({required this.count,required this.index});
}

class ZekrCounterCubit extends Cubit<ZekrCounterState> {
  ZekrCounterCubit() : super(ZekrCounterInitial());

  //List<int> zekrCounterList = [];

  final Map<int, int> _counts = {};

  void increment({required int index}) {
    final currentCount = _counts[index] ?? 0;
    final newCount = currentCount + 1;
    _counts[index] = newCount;
    emit(ZekrCounterIncrement(index: index, count: newCount));
  }

  int getCount(int index) {
    return _counts[index] ?? 0;
  }

  // zekrListBuilder({required int azkarLength}) {
  //   zekrCounterList.clear();
  //   zekrCounterList = List.generate(azkarLength, (index) => 0);
  // }
  //
  // void increment({required int index}) {
  //   zekrCounterList[index]++;
  //   emit(
  //     ZekrCounterIncrement(
  //       count: zekrCounterList[index],
  //     ),
  //   );
  // }
}
