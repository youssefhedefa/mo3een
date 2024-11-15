import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/features/home/data/models/home_data_model.dart';
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
    return BlocConsumer<GetHomeDataCubit, GetHomeDataState>(
      builder: (context, state) {
        if (state is GetHomeDataLoadingState) {
          return const CustomHomeLoading();
        }
        if (state is GetHomeDataErrorState) {
          return HomeDataRepresentative(
            data: HomeDataModel(
              location: 'غير متوفر',
              nextPrayer: 'غير متوفر',
              prayers: AppConstants.testPrayersList,
              nextPrayerTimeHoursLeft: 0,
              nextPrayerTimeMinutesLeft: 0,
            ),
          );
        }
        if (state is GetHomeDataSuccessState) {
          return HomeDataRepresentative(
            data: state.data,
          );
        }
        return const SizedBox();
      },
      listener: (context, state) {
        if (state is GetHomeDataErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('من فضلك تاكد من تفعيل الانترنت والموقع الخاص بك وحاول مرة اخري'),
            ),
          );
        }
      },
    );
  }
}

class HomeDataRepresentative extends StatelessWidget {
  const HomeDataRepresentative({super.key, required this.data});

  final HomeDataModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CurrentLocationMarker(
          address: data.location ?? "",
        ),
        NextSalahContainer(
          nextPrayer: data.nextPrayer ?? "",
          remainHours: data.nextPrayerTimeHoursLeft ?? 0,
          remainMinutes: data.nextPrayerTimeMinutesLeft ?? 0,
        ),
        const PickedDateViewer(),
        PrayerTimesList(
          prayers: data.prayers ?? [],
        ),
      ],
    );
  }
}
