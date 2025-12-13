// --- MODELS & API ---
import 'package:d12m12y2025/models/product.dart';
import 'package:dio/dio.dart';

// 2. Model Product

// 3. API Service
class ApiService {
  Future<List<Product>> getAll() async {
    var dio = Dio();
    try {
      var response = await dio.get('https://fakestoreapi.com/products');
      if (response.statusCode == 200) {
        List data = response.data;
        return data.map((x) => Product.fromJson(x)).toList();
      }
    } catch (e) {
      print("Lỗi kết nối: $e");
    }
    return [];
  }
}
