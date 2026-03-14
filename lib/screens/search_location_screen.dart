import 'package:auth_profile_app/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:auth_profile_app/services/weather_service.dart';
import 'package:auth_profile_app/models/weather_model.dart';
import 'package:diacritic/diacritic.dart';
import 'package:provider/provider.dart';
import 'package:auth_profile_app/providers/languague_provider.dart';
import 'package:auth_profile_app/localization/app_localizations.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});
  @override
  State<SearchLocationScreen> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocationScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> suggestions = [];
  bool showDuplicateMessage = false;
  bool isLoading = false;
  WeatherModel? weather;

  final List<String> allCities = [
    "Tuyên Quang",
    "Lào Cai",
    "Thái Nguyên",
    "Phú Thọ",
    "Bắc Ninh",
    "Hưng Yên",
    "Hải Phòng",
    "Ninh Bình",
    "Hà Nội",
    "Lai Châu",
    "Điện Biên",
    "Sơn La",
    "Lạng Sơn",
    "Quảng Ninh",
    "Cao Bằng",
    "Thanh Hóa",
    "Nghệ An",
    "Hà Tĩnh",
    "Quảng Trị",
    "Đà Nẵng",
    "Quảng Ngãi",
    "Gia Lai",
    "Khánh Hòa",
    "Lâm Đồng",
    "Đắk Lắk",
    "Thừa Thiên Huế",
    "TP. Hồ Chí Minh",
    "Đồng Nai",
    "Tây Ninh",
    "Cần Thơ",
    "Vĩnh Long",
    "Đồng Tháp",
    "Cà Mau",
    "An Giang",
  ];

  void _onSearchChanged(String value) {
    if (value.trim().isEmpty) {
      setState(() {
        suggestions = [];
      });
      return;
    }

    final normalizedQuery = removeDiacritics(value.toLowerCase());

    final filtered = allCities.where((city) {
      final normalizedCity = removeDiacritics(city.toLowerCase());

      return normalizedCity.startsWith(normalizedQuery);
    }).toList();

    setState(() {
      suggestions = filtered;
    });
  }

  void _selectCity(String city) async {
    if (isLoading) return;

    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);

    final isDuplicate = weatherProvider.cities.any(
      (w) =>
          removeDiacritics(w.location.city.toLowerCase().trim()) ==
          removeDiacritics(city.toLowerCase().trim()),
    );

    if (isDuplicate) {
      setState(() {
        showDuplicateMessage = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            showDuplicateMessage = false;
          });
        }
      });

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final weather = await WeatherService().fetchWeatherByAddress(city);

      weatherProvider.addCity(weather);

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _clearSearch() {
    _controller.clear();
    setState(() {
      suggestions = [];
    });
  }

  Widget _buildHighlightedText(String text, String query) {
    if (query.isEmpty) {
      return _normalText(text);
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();

    if (!lowerText.startsWith(lowerQuery)) {
      return _normalText(text);
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: text.substring(0, query.length),
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: text.substring(query.length),
          ),
        ],
      ),
    );
  }

  Widget _normalText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _controller.text.trim();
    final languageProvider = context.watch<LanguageProvider>();

    final loc = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.black,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          onChanged: _onSearchChanged,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: loc.tr('search'),
                            hintStyle: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (query.isNotEmpty)
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 26,
                            color: Colors.grey,
                          ),
                          onPressed: _clearSearch,
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: query.isEmpty
                      ? Center(
                          child: Text(
                            loc.tr('enter_location_name'),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : suggestions.isEmpty
                          ? Center(
                              child: Text(
                                loc.tr('no_results_found'),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  constraints: const BoxConstraints(
                                    maxHeight: 300,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: ScrollConfiguration(
                                    behavior: const ScrollBehavior()
                                        .copyWith(scrollbars: false),
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: suggestions.length,
                                      separatorBuilder: (_, __) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Divider(
                                          height: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      itemBuilder: (context, index) {
                                        final city = suggestions[index];

                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          hoverColor: Colors.grey.shade200,
                                          onTap: () => _selectCity(city),
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            child: _buildHighlightedText(
                                              city,
                                              query,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                ),
              ],
            ),
            if (showDuplicateMessage)
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    loc.tr('added_location'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
