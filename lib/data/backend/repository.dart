import 'package:alquranapp/data/backend/api_provider.dart';
import 'package:alquranapp/data/models/surah_response.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<SurahResponse> getSurah() async {
    final response = await apiProvider.getSurah();
    print(response);
    return SurahResponse.fromJson(response);
  }
}