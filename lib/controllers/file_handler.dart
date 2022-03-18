import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AuthStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/auth.txt');
  }

  Future<String> readAuth() async {
    try {
      final file = await _localFile;

      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      return '';
    }
  }

  Future<File> writeAuth(String? email, String? password) async {
    final file = await _localFile;

    return file.writeAsString('$email\n$password');
  }

   signOut() async {
      try {
        final file = await _localFile;

        await file.delete();
      } catch (e) {
        // do nothing
      }
  }
}
