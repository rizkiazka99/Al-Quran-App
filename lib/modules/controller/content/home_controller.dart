import 'dart:async';
import 'package:alquranapp/data/backend/repository.dart';
import 'package:alquranapp/data/models/new_api/surah_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final repository = Repository();
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  RxInt _currentTime = DateTime.now().hour.obs;
  RxString _greetingText = ''.obs;
  RxBool _surahLoading = false.obs;
  Rxn<SurahResponse> _surahData = Rxn<SurahResponse>();
  RxList<Data> _surahList = <Data>[].obs;
  RxList<Data> _searchResult = <Data>[].obs;
  Rx<bool> _enableSearchBar = false.obs;

  int get currentTime => _currentTime.value;
  String get greetingText => _greetingText.value;
  bool get surahLoading => _surahLoading.value;
  SurahResponse? get surahData => _surahData.value;
  List<Data> get surahList => _surahList.value;
  List<Data> get searchResult => _searchResult.value;
  bool get enableSearchBar => _enableSearchBar.value;

  set currentTime(int currentTime) =>
      this._currentTime.value = currentTime;
  set greetingText(String greetingText) =>
      this._greetingText.value = greetingText;
  set surahLoading(bool surahLoading) =>
      this._surahLoading.value = surahLoading;
  set surahData(SurahResponse? surahData) =>
      this._surahData.value = surahData;
  set surahList(List<Data> surahList) =>
      this._surahList.value = surahList;
  set searchResult(List<Data> searchResult) =>
      this._searchResult.value = searchResult;
  set enableSearchBar(bool enableSearchBar) =>
      this._enableSearchBar.value = enableSearchBar;

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

  void runFilter(String searchQuery) {
    searchQuery = searchController.text;
    
    if (searchQuery.isEmpty) {
      searchResult = surahData!.data;
    } else {
      surahLoading = true;
      searchResult = surahData!.data.where((surah) => 
        surah.namaLatin.toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
      surahList = searchResult;
      surahLoading = false;
    }
  }
}