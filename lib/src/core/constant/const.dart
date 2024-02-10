import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:ramadan/utils/utils.dart';

const methodChannel = MethodChannel('ramadan_method_chanall');
const kDefaultPadding = 16.0;
const kDefaultSpacing = 12.0;
const kDefaultTextSpacing = 4.0;
const kDefaultBorderRadius = 13.0;
const kDefaultDuration = 300;
const kSplashDuration = 500;
const curveType = Curves.decelerate;
const curveType1 = Curves.bounceIn;
const priceFilterScale = 250;
const kFigmaScale = 1.3;
var headrHttp = {
  "Content-Type": 'application/json; charset=UTF-8',
  "language": "en",
  "platform": "2",
  "currencysymbol": "IQD",
  "currencycode": "IQD",
  'accept': 'application/json; charset=UTF-8',
};
const double pi = 3.1415926535897932;
const apiKey = "AIzaSyCtNORVIkruxEFxKL6nWlKjf7xiEo5hJjw";
const userKeyStorage = "jop_me_local_user";
const addressKeyStorage = "jop_me_local_address";
const dayName = [
  "السبت",
  "الاحد",
  "الاثنين",
  "الثلاثاء",
  "الاربعاء",
  "الخميس",
  "الجمعة"
];
final juzuArray = [
  "الاول",
  "الثاني",
  "الثالث",
  "الرابع",
  "الخامس",
  "السادس",
  "السابع",
  "الثامن",
  "التاسع",
  "العاشر",
  "الحادي عشر",
  "الثاني عشر",
  "الثالث عشر",
  "الرابع عشر",
  "الخامس عشر",
  "السادس عشر",
  "السابع عشر",
  " الثامن عشر",
  "التاسع عشر",
  "العشرون",
  "الحادي و العشرون",
  "الثاني و العشرون",
  "الثالث و العشرون",
  "الرابع و العشرون",
  "الخامس و العشرون",
  "السادس و العشرون",
  "السابع و العشرون",
  "الثامن و العشرون",
  "التاسع و العشرون",
  "الثلاثون",
];

final prayerArray = [
  "",
  "صلاة الصباح",
  "صلاة الظهر",
  "صلاة العصر",
  "صلاة المغرب",
  "صلاة العشاء",
  "انتهى اليوم"
];

const hijreeMonthArray = [
  "محرم",
  "صفر",
  "ربيع الأول",
  "ربيع الآخر",
  "جمادي الأولى",
  "جمادي الآخرة",
  "رجب",
  "شعبان",
  "رمضان",
  "شوال ",
  "ذو القعدة",
  "ذو الحجة",
];
const List<String> arabicMonthNames = [
  'يناير',
  'فبراير',
  'مارس',
  'إبريل',
  'مايو',
  'يونيو',
  'يوليو',
  'أغسطس',
  'سبتمبر',
  'أكتوبر',
  'نوفمبر',
  'ديسمبر',
];

const List<String> arabic24HourNames = [
  'منتصف الليل',
  'الواحدة صباحًا',
  'الثانية صباحًا',
  'الثالثة صباحًا',
  'الرابعة صباحًا',
  'الخامسة صباحًا',
  'السادسة صباحًا',
  'السابعة صباحًا',
  'الثامنة صباحًا',
  'التاسعة صباحًا',
  'العاشرة صباحًا',
  'الحادية عشر صباحًا',
  'الثانية عشر ظهرًا',
  'الواحدة ظهرًا',
  'الثانية ظهرًا',
  'الثالثة عصرًا',
  'الرابعة عصرًا',
  'الخامسة عصرًا',
  'السادسة مساءً',
  'السابعة مساءً',
  'الثامنة مساءً',
  'التاسعة مساءً',
  'العاشرة مساءً',
  'الحادية عشر مساءً',
];
final navigatorKey = GlobalKey<NavigatorState>();

enum AppMode { admin, user }

const appMode = AppMode.admin;
