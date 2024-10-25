import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:mo3een/features/home/presentation/cubits/get_date_cubit/get_date_states.dart';

class GetDateCubit extends Cubit<GetDateStates> {
  GetDateCubit() : super(GetDateInitialState());

  getInitialDate(){
    emit(GetDateLoadingState());
    try{
      final pickedDate = DateTime.now();
      String formattedDate = dateFormatter(hijriDate: getCurrentHijriDate(), gregorianDate: pickedDate);
      emit(GetDateSuccessState(pickedDate: formattedDate));
    }catch(e){
      emit(GetDateErrorState(error: e.toString()));
    }
  }

  getCurrentHijriDate(){
    var today = HijriCalendar.now();
    HijriCalendar.setLocal('ar');
    return today.toFormat("dd MMMM yyyy");
  }

  getNextDate(String date){
    List<String> parts = date.split(' / ');
    String gregorianDate = parts[1];
    DateTime gregorian = DateFormat('d MMMM y', 'ar').parse(gregorianDate);
    gregorian = gregorian.add(const Duration(days: 1));
    HijriCalendar hijri = HijriCalendar.fromDate(gregorian);
    HijriCalendar.setLocal('ar');
    String formattedDate = dateFormatter(hijriDate: hijri.toFormat("dd MMMM yyyy"), gregorianDate: gregorian);
    emit(GetDateSuccessState(pickedDate: formattedDate));
  }

  getPreviousDate(String date){
    List<String> parts = date.split(' / ');
    String gregorianDate = parts[1];
    DateTime gregorian = DateFormat('d MMMM y', 'ar').parse(gregorianDate);
    gregorian = gregorian.subtract(const Duration(days: 1));
    HijriCalendar hijri = HijriCalendar.fromDate(gregorian);
    HijriCalendar.setLocal('ar');
    String formattedDate = dateFormatter(hijriDate: hijri.toFormat("dd MMMM yyyy"), gregorianDate: gregorian);
    emit(GetDateSuccessState(pickedDate: formattedDate));
  }

  getDateFromPicker(DateTime date){
    HijriCalendar hijri = HijriCalendar.fromDate(date);
    HijriCalendar.setLocal('ar');
    String formattedDate = dateFormatter(hijriDate: hijri.toFormat("dd MMMM yyyy"), gregorianDate: date);
    emit(GetDateSuccessState(pickedDate: formattedDate));
  }

  dateFormatter({required String hijriDate, required DateTime gregorianDate}){
    String monthInArabic = DateFormat.MMMM('ar').format(gregorianDate);
    String dayInArabic = DateFormat.EEEE('ar').format(gregorianDate);
    String day = DateFormat.d('ar').format(gregorianDate);
    String year = DateFormat.y('ar').format(gregorianDate);
    String formattedDate = '$dayInArabic, $hijriDate / $day $monthInArabic $year';
    return formattedDate;
  }


}