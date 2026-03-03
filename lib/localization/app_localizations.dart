import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'manage_cities': 'Manage cities',
      'enter_location': 'Enter location',
      'current_location': 'Current location',
      'added_locations': 'Added locations',
      'no_added_locations': 'No added locations yet',
      'cancel': 'Cancel',
      'add': 'Add',
      'today': 'Today',
      'tomorrow': 'Tomorrow',
      'thu': 'Thu',
      'fri': 'Fri',
      'sat': 'Sat',
      'sun': 'Sun',
      'mon': 'Mon',
      'tue': 'Tue',
      'wed': 'Wed',
      'uv': 'UV',
      'humidity': 'Humidity',
      'real_feel': 'Real feel',
      'wind': 'Wind',
      'sunset': 'Sunset',
      'pressure': 'Pressure',
      'moderate': 'Moderate',
      'northeast': 'Northeast',
      'force': 'Force',
      'settings': 'Settings',
      'theme': 'Theme',
      'language': 'Language',
      'light': 'Light',
      'dark': 'Dark',
      'vietnamese': 'Vietnamese',
      'english': 'English',
      '5_day_forecast': '5-day forecast',
      '24_hour_forecast': '24-hour forecast',
      'cloudy': 'Cloudy',
      'sunny': 'Sunny',
      'rainy': 'Rainy',
      'partly_cloudy': 'Partly Cloudy',
      'app_name': 'Weather App',
      'loading_app': 'Starting application...',
      'group': 'Group',
      'course': 'Course: Mobile Programming',
      'class': 'Class',
      'date': 'Date',
      'member': 'Member',
      'student_id': 'Student ID',
      'major': 'Major',
      '27': '27',
      'N04': 'N04',
      '1-1-2025': '1-1-2025',
      'Trịnh Như Nhất': 'Trinh Nhu Nhat',
      '23010600': '23010600',
      'Khoa Học Máy Tính & Trí Tuệ Nhân Tạo': 'Computer Science & AI',
    },
    'vi': {
      'manage_cities': 'Quản lý thành phố',
      'enter_location': 'Nhập địa điểm',
      'current_location': 'Vị trí hiện tại',
      'added_locations': 'Địa điểm đã thêm',
      'no_added_locations': 'Chưa có địa điểm nào',
      'cancel': 'Hủy',
      'add': 'Thêm',
      'today': 'Hôm nay',
      'tomorrow': 'Ngày mai',
      'thu': 'Thứ 5',
      'fri': 'Thứ 6',
      'sat': 'Thứ 7',
      'sun': 'Chủ nhật',
      'mon': 'Thứ 2',
      'tue': 'Thứ 3',
      'wed': 'Thứ 4',
      'uv': 'UV',
      'humidity': 'Độ ẩm',
      'real_feel': 'Cảm giác thực',
      'wind': 'Gió',
      'sunset': 'Hoàng hôn',
      'pressure': 'Áp suất',
      'moderate': 'Vừa phải',
      'northeast': 'Đông Bắc',
      'force': 'Cấp',
      'settings': 'Cài đặt',
      'theme': 'Chủ đề',
      'language': 'Ngôn ngữ',
      'light': 'Sáng',
      'dark': 'Tối',
      'vietnamese': 'Tiếng Việt',
      'english': 'Tiếng Anh',
      '5_day_forecast': 'Dự báo 5 ngày',
      '24_hour_forecast': 'Dự báo 24 giờ',
      'cloudy': 'Nhiều mây',
      'sunny': 'Nắng',
      'rainy': 'Mưa',
      'partly_cloudy': 'Có mây',
      'app_name': 'Ứng dụng Thời tiết',
      'loading_app': 'Đang khởi động ứng dụng...',
      'group': 'Nhóm',
      'course': 'Môn: Lập Trình Thiết Bị Di Động',
      'class': 'Lớp',
      'date': 'Ngày',
      'member': 'Thành viên',
      'student_id': 'Mã SV',
      'major': 'Ngành',
      '27': '27',
      'N04': 'N04',
      '1-1-2025': '1-1-2025',
      'Trịnh Như Nhất': 'Nguyễn Tuấn Huy',
      '23010499': '23010499',
      'Công Nghệ Thông Tin': 'Công Nghệ Thông Tin',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  String tr(String key) => translate(key);

  }

  class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;

}