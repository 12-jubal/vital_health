import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class HealthRepository {
  /// Fetches health metrics from a JSON file located in the assets folder.
  /// The method reads the JSON file `assets/api/health_metrics.json` and decodes its content.
  /// It then extracts the health metrics and returns them as a map of key-value pairs.
  Future<Map<String, dynamic>> getHealthMetrics() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/api/health_metrics.json');
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      return jsonData;
    } catch (e) {
      // print('Error reading health metrics: $e');
      return {};
    }
  }
}
