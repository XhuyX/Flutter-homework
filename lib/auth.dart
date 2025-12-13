// File: lib/auth.dart
import 'package:d12m12y2025/Model/User.dart';
import 'package:dio/dio.dart';

// SỬA: Trả về String? (Token hoặc null) thay vì bool
Future<String?> login(String username, String password) async {
  final dio = Dio();
  const url = 'https://dummyjson.com/auth/login';

  try {
    final response = await dio.post(
      url,
      data: {'username': username, 'password': password, 'expiresInMins': 30},
      options: Options(contentType: Headers.jsonContentType),
    );

    if (response.statusCode == 200) {
      // SỬA: Dio lưu dữ liệu trả về trong .data
      // Lấy token từ response.data
      final token = response.data['accessToken'];

      print('Token nhận được: $token');
      return token.toString(); // Trả về token cho bên UI dùng
    }
  } on DioException catch (e) {
    if (e.response != null) {
      print('Lỗi server: ${e.response?.data}');
    } else {
      print('Lỗi kết nối: ${e.message}');
    }
  }
  return null; // Trả về null nếu đăng nhập thất bại
}

Future<UserProfile?> getUserProfile(String token) async {
  final dio = Dio();
  const url = 'https://dummyjson.com/auth/me';

  try {
    final response = await dio.get(
      url,
      options: Options(
        headers: {
          // QUAN TRỌNG: Gửi token lên server để xác thực
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      print('Lấy thông tin User thành công!');
      // Chuyển JSON thành Object UserProfile
      return UserProfile.fromJson(response.data);
    }
  } on DioException catch (e) {
    print('Lỗi lấy profile: ${e.response?.data}');
  }
  return null;
}
