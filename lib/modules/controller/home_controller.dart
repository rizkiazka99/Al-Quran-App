import 'dart:async';
import 'package:alquranapp/data/backend/repository.dart';
//import 'package:alquranapp/data/models/surah_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/models/new_api/surah_response.dart';

class HomeController extends GetxController {
  final repository = Repository();
  ScrollController scrollController = ScrollController();

  RxInt _currentTime = DateTime.now().hour.obs;
  RxString _greetingText = ''.obs;
  RxBool _surahLoading = false.obs;
  Rxn<SurahResponse> _surahData = Rxn<SurahResponse>();

  int get currentTime => _currentTime.value;
  String get greetingText => _greetingText.value;
  bool get surahLoading => _surahLoading.value;
  SurahResponse? get surahData => _surahData.value;

  set currentTime(int currentTime) =>
      this._currentTime.value = currentTime;
  set greetingText(String greetingText) =>
      this._greetingText.value = greetingText;
  set surahLoading(bool surahLoading) =>
      this._surahLoading.value = surahLoading;
  set surahData(SurahResponse? surahData) =>
      this._surahData.value = surahData;

  @override
  void onInit() {
    getSurah();
    super.onInit();
  }

  Future<SurahResponse?> getSurah() async {
    surahLoading = true;
    SurahResponse res = await repository.getSurah();
    surahData = res;
    surahLoading = false;
    return surahData;
  }
}