import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:my_vocabulary_app/domain/models/word_model.dart';
import 'package:my_vocabulary_app/services/auth_service.dart';
import 'package:my_vocabulary_app/services/storage_service.dart';

sealed class DatabaseService {
  static final FirebaseDatabase database = FirebaseDatabase.instance;

  static Future<bool> createWord({
    required String word,
    required String translation,
    required String definition,
    required String example,
    required File file,
  }) async {
    try {
      final DatabaseReference folder = database.ref(Folder.word);
      final DatabaseReference child = folder.push();
      final String id = child.key!;
      final String userId = AuthService.currentUser.uid;
      final String imageUrl = await StorageService.uploadFile(file);

      final WordModel wordModel = WordModel(
        id: id,
        userId: userId,
        word: word,
        translation: translation,
        definition: definition,
        example: example,
        imageUrl: imageUrl,
      );

      await Future.delayed(const Duration(seconds: 1));

      await child.set(wordModel.toJson());

      return true;
    } catch (e) {
      debugPrint('DATABASE ERROR: $e');
      return false;
    }
  }

  static Future<List<WordModel>> readAllWords() async {
    try {
      final DatabaseReference folder = database.ref(Folder.word);
      final DataSnapshot data = await folder.get();

      if (data.value == null) {
        return [];
      }

      final Map<dynamic, dynamic> json =
          jsonDecode(jsonEncode(data.value)) as Map;

      return json.values
          .map((item) => WordModel.fromJson(item as Map<String, Object?>))
          .toList();
    } catch (e) {
      debugPrint('DATABASE ERROR: $e');
      return [];
    }
  }

  static Future<bool> updatePost({
    required String wordId,
    required String word,
    required String translation,
    required String definition,
    required String example,
    required String imageUrl,
  }) async {
    try {
      final DatabaseReference word = database.ref(Folder.word).child(wordId);
      final Map<String, Object?> updatedWord = {
        'word': word,
        'translation': translation,
        'definition': definition,
        'example': example,
        'imageUrl': imageUrl,
      };

      await Future.delayed(const Duration(seconds: 1));

      await word.update(updatedWord);

      return true;
    } catch (e) {
      debugPrint("DATABASE ERROR: $e");
      return false;
    }
  }

  static Future<bool> deleteWord(String wordId) async {
    try {
      final DatabaseReference word = database.ref(Folder.word).child(wordId);

      await Future.delayed(const Duration(seconds: 1));

      await word.remove();

      return true;
    } catch (e) {
      debugPrint('DATABASE ERROR: $e');
      return false;
    }
  }

  static Future<List<WordModel>> readMyWords() async {
    try {
      final DatabaseEvent data = await database
          .ref(Folder.word)
          .orderByChild('userId')
          .equalTo(AuthService.currentUser.uid)
          .once();

      if (data.snapshot.value == null) {
        return [];
      }

      final Map<dynamic, dynamic> json =
          jsonDecode(jsonEncode(data.snapshot.value)) as Map;

      return json.values
          .map((item) => WordModel.fromJson(item as Map<String, Object?>))
          .toList();
    } catch (e) {
      debugPrint('DATABASE ERROR: $e');
      return [];
    }
  }
}

sealed class Folder {
  static const word = 'Word';
  static const wordImage = 'Word Image';
}
