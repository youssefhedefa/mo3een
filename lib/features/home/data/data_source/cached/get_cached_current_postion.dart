import 'package:hive/hive.dart';
import 'package:mo3een/core/components/models/current_postion.dart';
import 'package:mo3een/core/utilities/box_constants.dart';
import 'package:mo3een/core/utilities/constants.dart';

class CachedPosition{

  CachedPosition();

  static CurrentPosition getCachePosition() {
    var box = Hive.box<CurrentPosition>(AppBoxConstants.currentPositionBox);
    CurrentPosition? position = box.get(0);
    if(position == null){
      return AppConstants.cachedPosition;
    }
    return position;
  }

  static setCachePosition(CurrentPosition position) async {
    var box = Hive.box<CurrentPosition>(AppBoxConstants.currentPositionBox);
    await box.clear();
    await box.add(position);
  }
}