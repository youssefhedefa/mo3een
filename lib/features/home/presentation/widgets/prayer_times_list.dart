import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/components/widgets/custom_loading.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/features/home/presentation/cubits/get_current_location_cubit/get_current_location_cubit.dart';
import 'package:mo3een/features/home/presentation/cubits/get_current_location_cubit/get_current_location_states.dart';
import 'package:mo3een/features/home/presentation/cubits/get_prayers_times_cubit/get_prayers_times_cubit.dart';
import 'package:mo3een/features/home/presentation/cubits/get_prayers_times_cubit/get_prayers_times_states.dart';
import 'package:mo3een/features/home/presentation/widgets/prayer_container.dart';

class PrayerTimesList extends StatelessWidget {
  const PrayerTimesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCurrentLocationCubit,GetCurrentLocationState>(
      builder: (context,locationState) {
        if(locationState is GetCurrentLocationLoading){
          return const Center(
            child: CustomLoadingIndicator(),
          );
        }
        if(locationState is GetCurrentLocationSuccess){
          return BlocBuilder<GetPrayersTimesCubit,GetPrayersTimesState>(
              bloc: context.read<GetPrayersTimesCubit>()..getTimes(
                lat: locationState.position.latitude,
                lon: locationState.position.longitude,
              ),
              builder: (context,state) {
                if(state is GetPrayersTimesLoadingState){
                  return const Center(
                    child: CustomLoadingIndicator(),
                  );
                }
                if(state is GetPrayersTimesErrorState){
                  return Center(
                    child: Text(state.error),
                  );
                }
                if(state is GetPrayersTimesSuccessState){
                  return ListView.separated(
                    shrinkWrap: true,
                    padding: REdgeInsets.only(bottom: 14.h),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => PrayerContainer(
                      icon: state.prayers[index].icon,
                      prayer: state.prayers[index].prayer,
                      time: state.prayers[index].time,
                      hisTurn: state.prayers[index].hisTurn,
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 16,
                    ),
                    itemCount: state.prayers.length,
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  padding: REdgeInsets.only(bottom: 14.h),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => PrayerContainer(
                    icon: AppConstants.testPrayersList[index].icon,
                    prayer: AppConstants.testPrayersList[index].prayer,
                    time: AppConstants.testPrayersList[index].time,
                    hisTurn: AppConstants.testPrayersList[index].hisTurn,
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  itemCount: AppConstants.testPrayersList.length,
                );
              }
          );

        }
        return BlocBuilder<GetPrayersTimesCubit,GetPrayersTimesState>(
          bloc: context.read<GetPrayersTimesCubit>()..getTimes(
              lat: 30,
            lon: 30,
          ),
            builder: (context,state) {
            if(state is GetPrayersTimesLoadingState){
              return const Center(
                child: CustomLoadingIndicator(),
              );
            }
            if(state is GetPrayersTimesErrorState){
              return Center(
                child: Text(state.error),
              );
            }
            if(state is GetPrayersTimesSuccessState){
              return ListView.separated(
                shrinkWrap: true,
                padding: REdgeInsets.only(bottom: 14.h),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => PrayerContainer(
                  icon: state.prayers[index].icon,
                  prayer: state.prayers[index].prayer,
                  time: state.prayers[index].time,
                  hisTurn: state.prayers[index].hisTurn,
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                itemCount: state.prayers.length,
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              padding: REdgeInsets.only(bottom: 14.h),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => PrayerContainer(
                icon: AppConstants.testPrayersList[index].icon,
                prayer: AppConstants.testPrayersList[index].prayer,
                time: AppConstants.testPrayersList[index].time,
                hisTurn: AppConstants.testPrayersList[index].hisTurn,
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemCount: AppConstants.testPrayersList.length,
            );
          }
        );
      }
    );
  }
}
