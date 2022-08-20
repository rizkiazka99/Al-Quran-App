import 'package:alquranapp/data/backend/repository.dart';
import 'package:alquranapp/data/models/new_api/surah_content_response.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SurahContentController extends GetxController {
  final repository = Repository();
  final audioPlayer = AudioPlayer();
  ScrollController scrollController = ScrollController();

  RxInt _currentSurahNumber = 1.obs;
  RxBool _surahContentLoading = false.obs;
  Rxn<SurahContentResponse> _surahContentData = Rxn<SurahContentResponse>();
  RxBool _isPlaying = false.obs;
  Rx<Duration> _duration = Duration.zero.obs;
  Rx<Duration> _position = Duration.zero.obs;

  int get currentSurahNumber => _currentSurahNumber.value;
  bool get surahContentLoading => _surahContentLoading.value;
  SurahContentResponse? get surahContentData => _surahContentData.value;
  bool get isPlaying => _isPlaying.value;
  Duration get duration => _duration.value;
  Duration get position => _position.value;

  set currentSurahNumber(int currentSurahNumber) =>
      this._currentSurahNumber.value = currentSurahNumber;
  set surahContentLoading(bool surahContentLoading) =>
      this._surahContentLoading.value = surahContentLoading;
  set surahContentData(SurahContentResponse? surahContentData) =>
      this._surahContentData.value = surahContentData;
  set isPlaying(bool isPlaying) =>
      this._isPlaying.value = isPlaying;
  set duration(Duration duration) =>
      this._duration.value = duration;
  set position(Duration position) =>
      this._position.value = position;

  @override
  void onInit() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.PLAYING;
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      duration = newDuration;
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) { 
      position = newPosition;
    });
    super.onInit();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<SurahContentResponse?> getSurahContent() async {
    surahContentLoading = true;
    SurahContentResponse res = await repository.getSurahContent(currentSurahNumber.toString());
    surahContentData = res;
    surahContentLoading = false;
    return surahContentData;
  }

  String formatAudioTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds
    ].join(':');
  }
}