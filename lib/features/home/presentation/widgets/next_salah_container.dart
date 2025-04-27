import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/components/widgets/custom_loading.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/core/helpers/image_helper.dart';
import 'package:mo3een/features/home/presentation/widgets/next_salah_text.dart';

class NextSalahContainer extends StatefulWidget {
  const NextSalahContainer({
    super.key,
    required this.nextPrayer,
    required this.remainHours,
    required this.remainMinutes,
    this.isLoading,
  });

  final String nextPrayer;
  final int remainHours;
  final int remainMinutes;
  final bool? isLoading;

  @override
  State<NextSalahContainer> createState() => _NextSalahContainerState();
}

class _NextSalahContainerState extends State<NextSalahContainer> {
  Duration _remainingTime = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeRemainingTime();
    _startTimer();
  }

  @override
  void didUpdateWidget(NextSalahContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.nextPrayer != widget.nextPrayer ||
        oldWidget.remainHours != widget.remainHours ||
        oldWidget.remainMinutes != widget.remainMinutes) {
      _timer?.cancel();
      _initializeRemainingTime();
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initializeRemainingTime() {
    _remainingTime = Duration(
      hours: widget.remainHours,
      minutes: widget.remainMinutes,
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_remainingTime.inSeconds > 0) {
          _remainingTime -= const Duration(seconds: 1);
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  String _buildRemainingTimeText(int hours, int minutes) {
    if (hours > 0) {
      return '$hours ساعة و $minutes دقيقة';
    } else if (minutes > 0) {
      return '$minutes دقيقة';
    } else {
      final seconds = _remainingTime.inSeconds.remainder(60);
      return '$seconds ثانية';
    }
  }

  @override
  Widget build(BuildContext context) {
    final hours = _remainingTime.inHours;
    final minutes = _remainingTime.inMinutes.remainder(60);
    return Container(
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: AppColorHelper.coffeeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          widget.isLoading ?? false
              ? const CustomLoadingIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NextSalahText(
                      title: 'الصلاة القادمة هي صلاة ',
                      subTitle: widget.nextPrayer,
                      svgIcon: AppIconHelper.mosqueIcon,
                    ),
                    const SizedBox(height: 16),
                    NextSalahText(
                      title: 'باقي على صلاة ${widget.nextPrayer}',
                      subTitle: _buildRemainingTimeText(hours, minutes),
                      svgIcon: AppIconHelper.timeIcon,
                    ),
                  ],
                ),
          Expanded(
            child: Center(
              child: Image.asset(
                AppImageHelper.prayerImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
