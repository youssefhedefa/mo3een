import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:mo3een/features/home/data/data_source/api/dio_factory.dart';
import 'package:mo3een/features/home/data/models/prayer_from_api.dart';

class HomeApiServices {
  final Dio dio;
  HomeApiServices({required this.dio});

  Future<PrayerDataFromApiModel> getPrayerTimes(
      {required num latitude, required num longitude}) async {
    var headers = {'Authorization': 'Bearer token'};
    var response = await DioFactory.dio!.request(
      'http://api.aladhan.com/v1/timings?latitude=$latitude&longitude=$longitude',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
    PrayerDataFromApiModel prayerDataFromApiModel =
        PrayerDataFromApiModel.fromJson(response.data);
    return prayerDataFromApiModel;
  }
}
