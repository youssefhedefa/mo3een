import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/core/routing/routing_constances.dart';
import 'package:mo3een/features/quran/data/models/quran_page_model.dart';
import 'package:mo3een/features/quran/presentation/cubits/get_mark_cubit/get_mark_cubit.dart';
import 'package:mo3een/features/quran/presentation/widgets/custom_container.dart';

class QuranPagesList extends StatelessWidget {
  const QuranPagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) => CustomContainer(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                AppIconHelper.numberIcon,
                width: 44.w,
                height: 44.h,
              ),
              Text(
                (index + 1).toString(),
                style: AppTextStyleHelper.font16RegularPrimary,
              ),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutingConstances.quranPage,
              arguments: QuranPageModel(pageNumber: index + 1),
            ).then((_){
              if(context.mounted){
                context.read<GetMarkCubit>().getMark();
              }
            });
          },
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 12,
        ),
        itemCount: 604,
      ),
    );
  }
}
