import 'dart:async';
import 'package:musicapp/data/responsirity/repository.dart';
import '../../data/model/song.dart';

class MusicAppViewModel {
  StreamController<List<Song>> songStream = StreamController();

  void loadSongs() {
    final repository = DefaultRepository();
    repository.loadData().then((songs) {
      songStream.add(songs!);
    });
  }
}
