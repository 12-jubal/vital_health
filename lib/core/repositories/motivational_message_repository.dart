import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart' show rootBundle;

/// A repository class responsible for fetching motivational messages from a JSON file.
///
/// This class provides a method to load and parse a JSON file containing motivational messages
/// from the assets folder. The messages are then returned as a list of strings.
class MotivationalMessageRepository {
  /// Fetches motivational messages from a JSON file located in the assets folder.
  ///
  /// The method reads the JSON file `assets/api/motivational_messages.json` and decodes its content.
  /// It then extracts the list of messages and returns them as a list of strings.
  ///
  /// Returns a [Future] that completes with a list of motivational messages.
  Future<List<String>> fetchMessages() async {
    final String jsonString =
        await rootBundle.loadString('assets/api/motivational_messages.json');
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return List<String>.from(jsonData['onboarding']);
  }

  /// Fetches a motivational message from a JSON file located in the assets folder.
  /// The method reads the JSON file `assets/api/motivational_messages.json` and decodes its content.
  /// It then extracts a random message and returns it as a string.
  /// Returns a [Future] that completes with a motivational message.
  Future<String> fetchRandomMessage() async {
    final String jsonString =
        await rootBundle.loadString('assets/api/motivational_messages.json');
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    final List<String> messages = List<String>.from(jsonData['messages']);
    // log("$messages");
    if (messages.isEmpty) {
      // throw Exception('No messages found in the JSON file.');
      return 'Default data.';
    } else {
      final randomIndex = (messages.length *
              (DateTime.now().millisecondsSinceEpoch % 1000) /
              1000)
          .floor();
      final text = messages[randomIndex];
      log(text);
      return text;
    }
  }
}
