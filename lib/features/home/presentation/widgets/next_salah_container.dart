import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/components/widgets/custom_loading.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/core/helpers/image_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/home/data/models/prayer_model.dart';
import 'package:mo3een/features/home/presentation/cubits/get_current_location_cubit/get_current_location_cubit.dart';
import 'package:mo3een/features/home/presentation/cubits/get_current_location_cubit/get_current_location_states.dart';
import 'package:mo3een/features/home/presentation/cubits/get_prayers_times_cubit/get_prayers_times_cubit.dart';
import 'package:mo3een/features/home/presentation/cubits/get_prayers_times_cubit/get_prayers_times_states.dart';
import 'package:mo3een/features/home/presentation/widgets/next_salah_text.dart';

class NextSalahContainer extends StatelessWidget {
  const NextSalahContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColorHelper.coffeeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 60,
            child: BlocBuilder<GetCurrentLocationCubit,GetCurrentLocationState>(
              builder: (context,locationState) {
                if(locationState is GetCurrentLocationLoading){
                  return const Center(
                    child: CustomLoadingIndicator(),
                  );
                }
                if(locationState is GetCurrentLocationFailed){
                  return Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColorHelper.primaryColor,
                        size: 24,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'موقعك الحالي : غير متوفر',
                        style: AppTextStyleHelper.font14RegularPrimary,
                      ),
                    ],
                  );
                }
                else if(locationState is GetCurrentLocationSuccess){
                  return BlocBuilder<GetPrayersTimesCubit,GetPrayersTimesState>(
                      builder: (context,state) {
                        if (state is GetPrayersTimesLoadingState) {
                          return const Center(
                            child: CustomLoadingIndicator(),
                          );
                        }
                        if(state is GetPrayersTimesErrorState) {
                          return const Center(
                            child: Text('حدث خطأ ما'),
                          );
                        }
                        if(state is GetPrayersTimesSuccessState){
                          PrayerModel prayerModel = state.prayers.firstWhere((element) => element.hisTurn == true);
                          String nextPrayer = prayerModel.prayer;
                          DateTime now = DateTime.now();
                          Duration duration = now.difference(timeParser(prayerModel.time));
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              NextSalahText(
                                title: 'الصلاة القادمة هي صلاة ',
                                subTitle: nextPrayer,
                                svgIcon: AppIconHelper.mosqueIcon,
                              ),
                              const SizedBox(height: 16),
                              NextSalahText(
                                title: 'باقي على صلاة $nextPrayer',
                                subTitle: '${duration.inHours.abs()} ساعة و ${duration.inMinutes.abs() % 60} دقيقة ',
                                svgIcon: AppIconHelper.timeIcon,
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
                      }
                  );
                }
                return const SizedBox();
              }
            ),
          ),
          Center(
            child: Image.asset(
              AppImageHelper.prayerImage,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  timeParser(String time){
    List<String> timeParts = time.split(":");

    // Parse hours and minutes from the string
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    // Create a DateTime object with today's date and the parsed time
    DateTime parsedTime = DateTime.now();
    parsedTime = DateTime(parsedTime.year, parsedTime.month, parsedTime.day, hours, minutes);

    return parsedTime;

  }
}
