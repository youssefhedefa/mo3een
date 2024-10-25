import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/features/home/presentation/cubits/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:mo3een/features/home/presentation/cubits/get_home_data_cubit/get_home_data_state.dart';
import 'package:mo3een/features/home/presentation/widgets/current_location_marker.dart';
import 'package:mo3een/features/home/presentation/widgets/custom_home_loading.dart';
import 'package:mo3een/features/home/presentation/widgets/next_salah_container.dart';
import 'package:mo3een/features/home/presentation/widgets/picked_date_viewer.dart';
import 'package:mo3een/features/home/presentation/widgets/prayer_times_list.dart';

class HomeDataView extends StatelessWidget {
  const HomeDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHomeDataCubit, GetHomeDataState>(
      builder: (context, state) {
        if (state is GetHomeDataLoadingState) {
          return const CustomHomeLoading();
        }
        if (state is GetHomeDataErrorState) {
          return Center(
            child: Text(
              state.error,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }
        if (state is GetHomeDataSuccessState) {
          return Column(
            children: [
              CurrentLocationMarker(
                address: state.data.location ?? "",
              ),
              NextSalahContainer(
                nextPrayer: state.data.nextPrayer ?? "",
                remainHours: state.data.nextPrayerTimeHoursLeft ?? 0,
                remainMinutes: state.data.nextPrayerTimeMinutesLeft ?? 0,
              ),
              const PickedDateViewer(),
              PrayerTimesList(
                prayers: state.data.prayers ?? [],
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
