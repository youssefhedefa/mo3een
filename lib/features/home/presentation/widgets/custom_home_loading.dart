import 'package:flutter/material.dart';
import 'package:mo3een/core/components/widgets/custom_loading.dart';
import 'package:mo3een/features/home/presentation/widgets/next_salah_container.dart';
import 'package:mo3een/features/home/presentation/widgets/picked_date_viewer.dart';

class CustomHomeLoading extends StatelessWidget {
  const CustomHomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomLoadingIndicator(),
        const NextSalahContainer(
          nextPrayer: '',
          remainHours: 0,
          remainMinutes: 0,
          isLoading: true,
        ),
        const PickedDateViewer(),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.35,
          child: const CustomLoadingIndicator(),
        ),
      ],
    );
  }
}
