import 'package:alquranapp/data/backend/repository.dart';
import 'package:alquranapp/data/models/new_api/surah_content_response.dart';
import 'package:get/get.dart';

class SurahContentController extends GetxController {
  final repository = Repository();

  RxString _currentSurahNumber = ''.obs;
  RxBool _surahContentLoading = false.obs;
  Rxn<SurahContentResponse> _surahContentData = Rxn<SurahContentResponse>();

  String get currentSurahNumber => _currentSurahNumber.value;
  bool get surahContentLoading => _surahContentLoading.value;
  SurahContentResponse? get surahContentData => _surahContentData.value;

  set currentSurahNumber(String currentSurahNumber) =>
      this._currentSurahNumber.value = currentSurahNumber;
  set surahContentLoading(bool surahContentLoading) =>
      this._surahContentLoading.value = surahContentLoading;
  set surahContentData(SurahContentResponse? surahContentData) =>
      this._surahContentData.value = surahContentData;

  Future<SurahContentResponse?> getSurahContent() async {
    surahContentLoading = true;
    SurahContentResponse res = await repository.getSurahContent(currentSurahNumber);
    surahContentData = res;
    surahContentLoading = false;
    return surahContentData;
  }
}