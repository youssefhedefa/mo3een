import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/azkar/data/model/azkar_model.dart';
import 'package:mo3een/features/azkar/presentation/cubits/get_all_azkar_cubit/get_all_azkar_cubit.dart';
import 'package:mo3een/features/azkar/presentation/cubits/get_all_azkar_cubit/get_all_azkar_states.dart';
import 'package:mo3een/features/quran/presentation/widgets/custom_container.dart';

class AllAzkarList extends StatelessWidget {
  const AllAzkarList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllAzkarCubit,GetAllAzkarState>(
      builder: (context,state) {
        if(state is GetAllAzkarSuccessState){
          return Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => ZekrItem(
                zekr: state.azkar[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemCount: state.azkar.length,
            ),
          );
        }
        return const SizedBox();
      }
    );
  }
}

class ZekrItem extends StatelessWidget {
  const ZekrItem({super.key, required this.zekr});

  final AzkarModel zekr;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                  zekr.category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyleHelper.font16BoldPrimary,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.bookmark_border,
                color: AppColorHelper.primaryColor,
                size: 30.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
