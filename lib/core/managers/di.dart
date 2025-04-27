import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:mo3een/core/helpers/get_current_position_helper.dart';
import 'package:mo3een/features/home/data/data_source/api/dio_factory.dart';
import 'package:mo3een/features/home/data/data_source/api/home_api_services.dart';
import 'package:mo3een/features/home/data/data_source/cached/cached_home_data.dart';
import 'package:mo3een/features/home/data/repo/home_repo.dart';
import 'package:mo3een/features/home/data/services/notification_service_contract.dart';
import 'package:mo3een/features/home/presentation/cubits/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:mo3een/features/quran/data/repo_imple/quran_repo_imple.dart';
import 'package:mo3een/features/quran/domain/repo/quran_repo.dart';
import 'package:mo3een/features/quran/presentation/cubits/get_all_surahs_cubit/get_all_surahs_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/search_cubit/search_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  getIt.registerLazySingleton<QuranRepo>(() => QuranRepoImple());
  getIt.registerFactory<GetAllSurahsCubit>(
      () => GetAllSurahsCubit(repo: getIt<QuranRepo>()));
  getIt.registerFactory<SearchCubit>(
      () => SearchCubit(repo: getIt<QuranRepo>()));

  Dio dio = await DioFactory.getDio();

  getIt.registerLazySingleton<HomeApiServices>(() => HomeApiServices(dio: dio));

  getIt.registerLazySingleton<CachedHomeData>(() => CachedHomeData());

  getIt.registerLazySingleton<LocationHelper>(() => LocationHelper());

  getIt.registerLazySingleton<NotificationServiceContract>(
      () => NotificationService(
            flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
          ));

  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(
        service: getIt<HomeApiServices>(),
        cachedHomeDataInstance: getIt<CachedHomeData>(),
        locationHelper: getIt<LocationHelper>(),
        notificationService: getIt<NotificationServiceContract>(),
      ));

  getIt.registerFactory<GetHomeDataCubit>(
      () => GetHomeDataCubit(repo: getIt<HomeRepo>()));
}
