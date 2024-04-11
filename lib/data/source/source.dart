import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/song.dart';
import 'package:http/http.dart' as http;

abstract interface class DataSource {
  Future<List<Song>?> loadData();
}

class RemoteDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/post'));
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body) as List;
      List<Song> songs = jsonBody.map((song) => Song.fromJson(song)).toList();
      return songs;
    } else {
      return null;
    }
  }
}


class LocalDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async{
    final  String response = await rootBundle.loadString('assets/songs.json');
    final jsonBody = jsonDecode(response) as Map;
    final songList = jsonBody['songs'] as List;
    List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
    return songs;
  }
}
