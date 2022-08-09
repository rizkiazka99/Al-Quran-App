import 'package:alquranapp/data/backend/api_provider.dart';
import 'package:alquranapp/data/models/new_api/surah_response.dart';
import 'package:alquranapp/data/models/new_api/surah_content_response.dart';
//import 'package:alquranapp/data/models/surah_content_response.dart';
//import 'package:alquranapp/data/models/surah_response.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<SurahResponse> getSurah() async {
    final response = await apiProvider.getSurah();
    print(response);
    return SurahResponse.fromJson(response);
  }

  Future<SurahContentResponse> getSurahContent(String surahNumber) async {
    final response = await apiProvider.getSurahContent(surahNumber);
    print(response);
    return SurahContentResponse.fromJson(response);
  }
}