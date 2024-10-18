import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/features/home/presentation/widgets/current_location_marker.dart';
import 'package:mo3een/features/home/presentation/widgets/home_header.dart';
import 'package:mo3een/features/home/presentation/widgets/next_salah_container.dart';
import 'package:mo3een/features/home/presentation/widgets/picked_date_viewer.dart';
import 'package:mo3een/features/home/presentation/widgets/prayer_times_list.dart';

import 'widgets/ayah_el_youm.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 76,
              ),
              HomeHeader(),
              CurrentLocationMarker(),
              NextSalahContainer(),
              PickedDateViewer(),
              PrayerTimesList(),
              AyahElYoum(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
