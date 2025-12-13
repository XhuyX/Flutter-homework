// api.dart
import 'package:dio/dio.dart';
import 'package:d12m12y2025/Model/news.dart';

class Api {
  final Dio _dio = Dio();
  final String _apiKey =
      'dd848f24ee3045b2b38e7ede23fd309b'; // Nên đưa vào file const riêng

  Future<List<News>> getAll() async {
    try {
      var response = await _dio.get(
        'https://newsapi.org/v2/top-headlines',
        queryParameters: {'country': 'us', 'apiKey': _apiKey},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = response.data;
        List listData = jsonResponse['articles'];
        return listData.map((x) => News.fromJson(x)).toList();
      } else {
        throw Exception("Lỗi kết nối: ${response.statusCode}");
      }
    } catch (e) {
      // Re-throw để FutureBuilder bên UI bắt được lỗi này
      throw Exception("Không thể tải tin tức: $e");
    }
  }
}
