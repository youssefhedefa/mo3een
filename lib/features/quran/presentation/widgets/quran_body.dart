import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/sa3dy.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/quran/data/models/quran_mark_model.dart';
import 'package:mo3een/features/quran/domain/entities/sura_entity.dart';
import 'package:mo3een/features/quran/presentation/cubits/add_mark_cubit/add_mark_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/add_mark_cubit/add_mark_states.dart';
import 'package:mo3een/features/quran/presentation/cubits/get_mark_cubit/get_mark_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/get_mark_cubit/get_mark_states.dart';
import 'package:mo3een/features/quran/presentation/surah_header.dart';
import 'package:mo3een/features/quran/presentation/widgets/basmallah.dart';
import 'package:quran/quran.dart';

class QuranBody extends StatefulWidget {
  const QuranBody({
    super.key,
    required this.page,
    this.changeCurrentPage,
    this.ayahNumber,
    this.surahNumber,
  });

  final int page;
  final dynamic changeCurrentPage;
  final int? ayahNumber;
  final int? surahNumber;

  @override
  State<QuranBody> createState() => _QuranBodyState();
}

class _QuranBodyState extends State<QuranBody> {
  // var highlightVerse;
  // var shouldHighlightText;
  List<GlobalKey> richTextKeys = List.generate(
    604, // Replace with the number of pages in your PageView
    (_) => GlobalKey(),
  );
  setIndex() {
    setState(() {
      index = widget.page;
      selectedSpan =
          " ${widget.surahNumber.toString()}${widget.ayahNumber.toString()}";
    });
  }

  int index = 0;
  late PageController _pageController;
  String selectedSpan = "";

  @override
  void initState() {
    setIndex();
    _pageController = PageController(initialPage: index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        itemBuilder: (context, index) {
          if (index < 1 || index > 604) {
            return const SizedBox(); // return an empty container if the page number is invalid
          }
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: RichText(
                key: richTextKeys[index - 1],
                textAlign: TextAlign.center,
                softWrap: true,
                locale: const Locale("ar"),
                text: TextSpan(
                  children: getPageData(index).expand(
                    (e) {
                      List<InlineSpan> spans = [];
                      log(e.toString());
                      for (var i = e["start"]; i <= e["end"]; i++) {
                        if (i == 1) {
                          spans.add(
                            WidgetSpan(
                              child: SurahHeader(
                                surah: SuraEntity(
                                  name: e['surah'].toString(),
                                  number: e['surah'],
                                  ayahsNumber: getVerseCount(e['surah']),
                                  revelationType: '',
                                ),
                              ),
                            ),
                          );
                          if (index != 187 && index != 1) {
                            spans.add(
                              const WidgetSpan(
                                child: Basmallah(),
                              ),
                            );
                          }
                        }
                        spans.add(
                          TextSpan(
                            recognizer: LongPressGestureRecognizer()
                              ..onLongPress = () {
                                showModalBottomSheet(
                                  context: context,
                                  useSafeArea: true,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (context) => AddMarkCubit(),
                                        ),
                                        BlocProvider(
                                          create: (context) =>
                                              GetMarkCubit()..getMark(),
                                        ),
                                      ],
                                      child: Builder(builder: (context) {
                                        return Padding(
                                          padding: const EdgeInsets.all(24.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'تفسير السعدي للآية رقم $i',
                                                      style: AppTextStyleHelper
                                                          .font16BoldPrimary,
                                                    ),
                                                    BlocBuilder<GetMarkCubit,
                                                            GetMarkStates>(
                                                        builder:
                                                            (context, state) {
                                                      if (state
                                                          is GetMarkSuccessState) {
                                                        if (state.mark.surah ==
                                                                e["surah"] &&
                                                            state.mark.ayah ==
                                                                i &&
                                                            state.mark.page ==
                                                                index) {
                                                          return IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              Icons.bookmark,
                                                              color: AppColorHelper
                                                                  .primaryColor,
                                                              size: 30.sp,
                                                            ),
                                                          );
                                                        }
                                                        return BlocConsumer<AddMarkCubit,AddMarkState>(
                                                          builder: (context,addState) {
                                                            return IconButton(
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        AddMarkCubit>()
                                                                    .addMark(
                                                                      mark:
                                                                          QuranMarkModel(
                                                                        id: 0,
                                                                        surah: e[
                                                                            "surah"],
                                                                        ayah: i,
                                                                        page: index,
                                                                      ),
                                                                    );
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .bookmark_border_outlined,
                                                                color: AppColorHelper
                                                                    .primaryColor,
                                                                size: 30.sp,
                                                              ),
                                                            );
                                                          },
                                                          listener: (context,addState){
                                                            if(addState is AddMarkSuccessState){
                                                              context.read<GetMarkCubit>().getMark();
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                const SnackBar(
                                                                  content: Text('تم تحديد العلامة بنجاح'),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        );
                                                      }
                                                      return const SizedBox();
                                                    }),
                                                  ],
                                                ),
                                                Text(
                                                  getVerseElsa3dyTranslation(
                                                    e["surah"],
                                                    i,
                                                    verseEndSymbol: true,
                                                  ),
                                                  style: AppTextStyleHelper
                                                      .font16RegularPrimary
                                                      .copyWith(
                                                    height: 1.5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                                  },
                                ).then((value){
                                  if(context.mounted){
                                    context.read<GetMarkCubit>().getMark();
                                  }
                                });
                              }
                              ..onLongPressDown = (details) {
                                setState(() {
                                  selectedSpan = " ${e["surah"]}$i";
                                });
                              }
                              ..onLongPressUp = () {
                                setState(() {
                                  selectedSpan = "";
                                });
                                //print("finished long press");
                              }
                              ..onLongPressCancel = () => setState(() {
                                    selectedSpan = "";
                                  }),
                            text: i == e["start"]
                                ? "${getVerseQCF(e["surah"], i).replaceAll(' ', '').substring(0, 1)}\u200A${getVerseQCF(e["surah"], i).replaceAll(' ', '').substring(1)}"
                                : getVerseQCF(e["surah"], i)
                                    .replaceAll(' ', ''),
                            style: TextStyle(
                              color: AppColorHelper.quranTextColor,
                              fontFamily:
                                  "QCF_P${index.toString().padLeft(3, "0")}",
                              fontSize: 22.sp,
                              backgroundColor:
                                  selectedSpan == " ${e["surah"]}$i"
                                      ? AppColorHelper.coffeeColor
                                      : Colors.transparent,
                            ),
                          ),
                        );
                      }
                      return spans;
                    },
                  ).toList(),
                ),
              ),
            ),
          );
        },
        onPageChanged: (a) {
          if (a < 1 || a > 604) {
            _pageController.jumpToPage(index);
          } else {
            setState(() {
              selectedSpan = "";
              index = a;
            });
            widget.changeCurrentPage(a);
          }
        },
        itemCount: totalPagesCount + 1,
      ),
    );
  }
}

String getVerseElsa3dyTranslation(int surahNumber, int verseNumber,
    {bool verseEndSymbol = false}) {
  List<dynamic> translationDataList = elSa3dy;
  String verse = "";
  for (var item in translationDataList) {
    if (item['sura'].toString() == surahNumber.toString() &&
        item['aya'].toString() == verseNumber.toString()) {
      verse = item['text'];
      break;
    }
  }

  if (verse == "") {
    return "";
  }
  return verse +
      (verseEndSymbol
          ? getVerseEndSymbol(verseNumber, arabicNumeral: false)
          : "");
}
