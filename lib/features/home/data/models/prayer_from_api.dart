class PrayerDataFromApiModel {
  PrayerDataFromApiModel({
    required this.code,
    required this.status,
    required this.data,
  });

  final num? code;
  final String? status;
  final Datum data;

  factory PrayerDataFromApiModel.fromJson(Map<String, dynamic> json){
    return PrayerDataFromApiModel(
      code: json["code"],
      status: json["status"],
      data: Datum.fromJson(json["data"]),
      // data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.timings,
  });

  final Timings? timings;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      timings: json["timings"] == null ? null : Timings.fromJson(json["timings"]),
    );
  }

}

class Timings {
  Timings({
    required this.imsak,
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.sunset,
    required this.isha,
    required this.midnight,
  });

  final String? imsak;
  final String? fajr;
  final String? sunrise;
  final String? dhuhr;
  final String? asr;
  final String? maghrib;
  final String? sunset;
  final String? isha;
  final String? midnight;

  factory Timings.fromJson(Map<String, dynamic> json){
    return Timings(
      imsak: json["Imsak"],
      fajr: json["Fajr"],
      sunrise: json["Sunrise"],
      dhuhr: json["Dhuhr"],
      asr: json["Asr"],
      maghrib: json["Maghrib"],
      sunset: json["Sunset"],
      isha: json["Isha"],
      midnight: json["Midnight"],
    );
  }

}
