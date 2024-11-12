import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/connectivity_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/home/presentation/cubits/get_home_data_cubit/get_home_data_cubit.dart';

class CurrentLocationMarker extends StatefulWidget {
  const CurrentLocationMarker({super.key, required this.address});

  final String address;

  @override
  State<CurrentLocationMarker> createState() => _CurrentLocationMarkerState();
}

class _CurrentLocationMarkerState extends State<CurrentLocationMarker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      checkTheAddressToShowSnackBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            color: AppColorHelper.primaryColor,
            size: 24,
          ),
          const SizedBox(width: 4),
          Text(
            widget.address,
            style: AppTextStyleHelper.font14RegularPrimary,
          ),
          const Spacer(),
          IconButton(
            onPressed: () async {
              bool isConnected = await ConnectivityHelper.isConnected();
              if (!isConnected) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text('لا يوجد اتصال بالإنترنت'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  return;
                }
              } else {
                if (context.mounted) {
                  context.read<GetHomeDataCubit>().getHomeData(
                        refresh: true,
                      );
                }
              }
            },
            icon: const Icon(
              Icons.refresh,
              color: AppColorHelper.primaryColor,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  checkTheAddressToShowSnackBar() async {
    if (widget.address == 'غير متوفر') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
              'لا يمكن الحصول على العنوان الحالي من فضلك تأكد من تفعيل خدمة الموقع'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
