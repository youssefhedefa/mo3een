import 'package:flutter/material.dart';
import 'package:mo3een/features/quran/data/models/quran_page_model.dart';
import 'package:mo3een/features/quran/presentation/widgets/quran_body.dart';
import 'package:mo3een/features/quran/presentation/widgets/quran_page_header.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key, required this.page});

  final QuranPageModel page;

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {

  @override
  void initState() {
    currentPage = widget.page.pageNumber;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int currentPage = 0;

  changeCurrentPage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
            width: double.infinity,
          ),
          QuranPageHeader(
            page: currentPage,
          ),
          QuranBody(
            page: currentPage,
            changeCurrentPage: changeCurrentPage,
            ayahNumber: widget.page.ayahNumber,
            surahNumber: widget.page.suraNumber,
          ),
        ],
      ),
    );
  }
}


