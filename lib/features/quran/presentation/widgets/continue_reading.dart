import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/core/helpers/image_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/quran/data/models/quran_page_model.dart';
import 'package:mo3een/features/quran/presentation/cubits/get_mark_cubit/get_mark_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/get_mark_cubit/get_mark_states.dart';
import 'package:mo3een/features/quran/presentation/widgets/continue_button.dart';
import 'package:mo3een/features/quran/presentation/widgets/page_and_ayah_number.dart';
import 'package:mo3een/features/quran/presentation/widgets/sora_highlight_text.dart';

class ContinueReading extends StatelessWidget {
  const ContinueReading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage(
            AppImageHelper.quranImage,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: BlocBuilder<GetMarkCubit, GetMarkStates>(
        builder: (context, state) {
          if (state is GetMarkSuccessState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'متابعة القراءة من حيث توقفت ',
                  style: AppTextStyleHelper.font12BoldWhite,
                ),
                const SizedBox(height: 8),
                SoraHighLightText(surah: state.mark.surah ?? 1),
                PageAndAyahNumber(
                  page: state.mark.page ?? 1,
                  ayah: state.mark.ayah ?? 1,
                ),
                const SizedBox(height: 12),
                ContinueButton(
                  page: QuranPageModel(
                      pageNumber: state.mark.page ?? 1,
                      suraNumber: state.mark.surah ?? 1,
                      ayahNumber: state.mark.ayah ?? 1,
                  ),
                ),
              ],
            );
          }
          return const SizedBox(
            height: 100,
          );
        },
      ),
    );
  }
}
