import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';
import '../data/static_data.dart';


class ArticleService {
  // ──────────────────────────────────────────────────────────────
  // 🔧 REPLACE THIS with your real API URL when you have it
  // Expected JSON format:
  // [
  //   {
  //     "title": "Understanding ADHD",
  //     "body": "# Introduction\nADHD is...\n## Symptoms\n• Inattention\n• Hyperactivity",
  //     "icon": "🧠",
  //     "tag": "Mental Health",
  //     "readTime": "5 min"
  //   },
  //   ...
  // ]
  // ──────────────────────────────────────────────────────────────
  static const String _baseUrl =
      'https://your-api.com/api/articles'; // <-- replace this

  static const Duration _timeout = Duration(seconds: 10);

  /// Fetches live articles from the API.
  /// Falls back to [kArticles] from static_data.dart if the request fails.
  static Future<List<Article>> fetchArticles() async {
    try {
      final response = await http
          .get(
            Uri.parse(_baseUrl),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              // 'Authorization': 'Bearer YOUR_TOKEN', // add if needed
            },
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final articles = data
            .map((json) => Article.fromJson(json as Map<String, dynamic>))
            .toList();

        // If API returned empty list, fall back to static data
        if (articles.isEmpty) return kArticles;
        return articles;
      } else {
        // Non-200 status — fall back silently
        return kArticles;
      }
    } catch (_) {
      // Timeout, no internet, parse error — fall back silently
      return kArticles;
    }
  }
}