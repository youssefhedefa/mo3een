import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/image_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'متابعة القراءة من حيث توقفت ',
            style: AppTextStyleHelper.font12BoldWhite,
          ),
          const SizedBox(height: 8),
          const SoraHighLightText(),
          const PageAndAyahNumber(),
          const SizedBox(height: 12),
          const ContinueButton(),
        ],
      ),
    );
  }
}
