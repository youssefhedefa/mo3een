import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/components/custom_bottom_nav_bar/cubit/nav_bar_cubit.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/more/presentation/cubit/more_settings_cubit.dart';
import 'package:mo3een/features/more/presentation/cubit/more_settings_state.dart';
import 'package:mo3een/features/more/presentation/ui/widgets/more_option_tile.dart';
import 'package:mo3een/features/more/presentation/ui/widgets/notification_option_tile.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MoreSettingsCubit(),
      child: const _MoreViewBody(),
    );
  }
}

class _MoreViewBody extends StatelessWidget {
  const _MoreViewBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorHelper.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: REdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Ø§Ù„Ù…Ø²ÙŠØ¯',
                textAlign: TextAlign.center,
                style: AppTextStyleHelper.font16BoldPrimary,
              ),
              SizedBox(height: 31.h),
              Text(
                'Ø§Ù„Ø®Ø¯Ù…Ø§Øª',
                textAlign: TextAlign.right,
                style: AppTextStyleHelper.font14BoldPrimary,
              ),
              SizedBox(height: 12.h),
              MoreOptionTile(
                title: 'Ø§ØªØ¬Ø§Ù‡ Ø§Ù„Ù‚Ø¨Ù„Ø©',
                icon: AppIconHelper.compassIcon,
                onTap: () =>
                    context.read<BottomNavBarCubit>().showQiblaFromMore(),
              ),
              SizedBox(height: 20.h),
              Text(
                'Ø§Ù„Ø¥Ø´Ø¹Ø§Ø±Ø§Øª',
                textAlign: TextAlign.right,
                style: AppTextStyleHelper.font14BoldPrimary,
              ),
              SizedBox(height: 8.h),
              Text(
                'Ø§Ø®ØªØ± Ø§Ù„ØªÙ†Ø¨ÙŠÙ‡Ø§Øª Ø§Ù„ØªÙŠ ØªØ±ØºØ¨ ÙÙŠ Ø§Ø³ØªÙ„Ø§Ù…Ù‡Ø§',
                textAlign: TextAlign.right,
                style: AppTextStyleHelper.font12RegularPrimary.copyWith(
                  fontSize: 11.sp,
                  color: AppColorHelper.primaryColor.withValues(alpha: 0.65),
                ),
              ),
              SizedBox(height: 12.h),
              BlocBuilder<MoreSettingsCubit, MoreSettingsState>(
                builder: (context, state) {
                  final cubit = context.read<MoreSettingsCubit>();
                  return Column(
                    children: [
                      NotificationOptionTile(
                        title: 'Ø¥Ø´Ø¹Ø§Ø±Ø§Øª Ø£ÙˆÙ‚Ø§Øª Ø§Ù„ØµÙ„Ø§Ø©',
                        value: state.prayerNotificationsEnabled,
                        onChanged: cubit.setPrayerNotifications,
                      ),
                      SizedBox(height: 12.h),
                      NotificationOptionTile(
                        title: 'ØªØ°ÙƒÙŠØ± Ø£Ø°ÙƒØ§Ø± Ø§Ù„ØµØ¨Ø§Ø­',
                        value: state.morningAzkarEnabled,
                        onChanged: cubit.setMorningAzkarNotifications,
                      ),
                      SizedBox(height: 12.h),
                      NotificationOptionTile(
                        title: 'ØªØ°ÙƒÙŠØ± Ø£Ø°ÙƒØ§Ø± Ø§Ù„Ù…Ø³Ø§Ø¡',
                        value: state.eveningAzkarEnabled,
                        onChanged: cubit.setEveningAzkarNotifications,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
