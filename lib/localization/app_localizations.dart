import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      '14': '14',
      '2025-2026': '2025 - 2026',
      '23010499': '23010499',
      'acadamy_year': 'Acadamy year',
      'add_current_location': 'Add current location',
      'add_location': 'Add location',
      'added_location': 'Added location',
      'all': 'All',
      'app_name': 'Weather App',
      'at': 'At',
      'cancel': 'Cancel',
      'class': 'Class',
      'course': 'Mobile Programming',
      'current_location': 'Current location',
      'date': 'Date',
      'delete': 'Delete',
      'delete_all': 'Delete all',
      'description': 'Description',
      'english': 'English',
      'enter_location_name': 'Enter Location',
      'feelLikes': 'Feel likes',
      'final_term_project': 'FINAL TEARM',
      'hour_forecast': 'Hour forecast',
      'humidity': 'Humidity',
      'information_technology': 'Infomation Technology',
      'instructors': 'Instructor',
      'language': 'Language',
      'major': 'Major',
      'member': 'Member',
      'mobile_programming-1-2-25(no2)': 'Mobile Programming - 1-2-25 (N02)',
      'nguyen_tuan_huy': 'Nguyen Tuan Huy',
      'nguyen_xuan_que': 'Nguyen Xuan Que',
      'no_results_found': 'No results found',
      'no2': 'N02',
      'pressure': 'Pressure',
      'project_title': 'Project Title',
      'search': 'Search',
      'select': 'Select',
      'selected': 'Selected',
      'setting': 'Setting',
      'seven_day_forecast': 'Seven day forecast',
      'student_id': 'Student ID',
      'sunset': 'Sunset',
      'team': 'Team',
      'team_introduction': 'Team Introducion',
      'temperature': 'Temperature',
      'uv': 'UV',
      'vietnamese': 'Vietnamese',
      'weather': 'Weather',
      'weather_app_for_provinces_and_cities':
          'Weather App for Provinces and Cities',
      'weather_setting': 'Weather setting',
      'wind': 'Wind',
    },
    'vi': {
      '14': '14',
      '2025-2026': '2025 - 2026',
      '23010499': '23010499',
      'acadamy_year': 'Năm học',
      'add_current_location': 'Thêm vị trí hiện tại',
      'add_location': 'Chọn vị trí',
      'added_location': 'Vị trí đã thêm',
      'all': 'Tất cả',
      'app_name': 'Ứng dụng Thời tiết',
      'at': 'lúc',
      'cancel': 'Hủy',
      'class': 'Lớp',
      'course': 'Lập Trình Thiết Bị Di Động',
      'delete': 'Xóa',
      'delete_all': 'Xóa tất cả',
      'description': 'Mô tả',
      'english': 'Tiếng Anh',
      'enter_location_name': 'Hãy nhập tên vị trí',
      'feelLikes': 'Cảm giác như',
      'final_term_project': 'BÀI TẬP LỚN CUỐI KÌ',
      'hour_forecast': 'Dự báo theo giờ',
      'humidity': 'Độ ẩm',
      'information_technology': 'Công Nghệ Thông Tin',
      'instructors': 'Giáo viên hướng dẫn',
      'language': 'Ngôn ngữ',
      'major': 'Ngành',
      'member': 'Thành viên',
      'mobile_programming-1-2-25(no2)':
          'Lập trình cho thiết bị di động - 1-2-25 (N02)',
      'nguyen_tuan_huy': 'Nguyễn Tuấn Huy',
      'nguyen_xuan_que': 'Nguyễn Xuân Quế',
      'no_results_found': 'Không tìm thấy kết quả',
      'no2': 'N02',
      'pressure': 'Áp suất',
      'project_title': 'Tên đề tài',
      'search': 'Tìm kiếm',
      'select': 'Chọn',
      'selected': 'Đã chọn',
      'setting': 'Cài đặt',
      'seven_day_forecast': 'Dự báo trong 7 ngày tới',
      'student_id': 'Mã sinh viên',
      'sunset': 'Hoàng hôn',
      'team': 'Nhóm',
      'team_introduction': 'Giới thiệu nhóm',
      'temperature': 'Nhiệt độ',
      'uv': 'UV',
      'vietnamese': 'Tiếng Việt',
      'weather': 'Thời tiết',
      'weather_setting': 'Cài đặt thời tiết',
      'wind': 'Gió',
      'subnet': 'Môn học',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  String tr(String key) => translate(key);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
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