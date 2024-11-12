import 'package:flutter_test/flutter_test.dart';
import 'package:mo3een/core/helpers/get_current_position_helper.dart';
import 'package:mo3een/features/home/data/data_source/api/home_api_services.dart';
import 'package:mo3een/features/home/data/data_source/cached/cached_home_data.dart';
import 'package:mo3een/features/home/data/repo/home_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeApiServices extends Mock implements HomeApiServices {}

class MockCachedHomeData extends Mock implements CachedHomeData {}

class MockLocationHelper extends Mock implements LocationHelper {}

void main() {
  late HomeRepo sut;
  late MockHomeApiServices mockService;
  late MockCachedHomeData mockCachedHomeDataInstance;
  late MockLocationHelper mockLocationHelper;
  setUp(() {
    mockService = MockHomeApiServices();
    mockCachedHomeDataInstance = MockCachedHomeData();
    mockLocationHelper = MockLocationHelper();

    sut = HomeRepo(
      service: mockService,
      cachedHomeDataInstance: mockCachedHomeDataInstance,
      locationHelper: mockLocationHelper,
    );
  });

  test(
    "initial values are correct",
    () {
      expect(sut.getPrayersTimesFlag, true);
    },
  );
}


