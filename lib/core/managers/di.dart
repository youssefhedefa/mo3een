import 'package:get_it/get_it.dart';
import 'package:mo3een/features/quran/data/repo_imple/quran_repo_imple.dart';
import 'package:mo3een/features/quran/domain/repo/quran_repo.dart';
import 'package:mo3een/features/quran/presentation/cubits/get_all_surahs_cubit/get_all_surahs_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/search_cubit/search_cubit.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerLazySingleton<QuranRepo>(() => QuranRepoImple());
  getIt.registerFactory<GetAllSurahsCubit>(() => GetAllSurahsCubit(repo: getIt<QuranRepo>()));
  getIt.registerFactory<SearchCubit>(() => SearchCubit(repo: getIt<QuranRepo>()));
}