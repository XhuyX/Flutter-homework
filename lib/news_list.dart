import 'package:d12m12y2025/news_api.dart';
import 'package:d12m12y2025/newsdetail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import để format ngày tháng
// Import các file model và api của bạn
import 'package:d12m12y2025/Model/news.dart';

class Mypage extends StatefulWidget {
  const Mypage({super.key});

  @override
  State<Mypage> createState() => _MypageState();
}
// Mypage.dart (Phần _MypageState)

class _MypageState extends State<Mypage> {
  final Api newsApi = Api();
  late Future<List<News>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = newsApi.getAll();
  }

  // Hàm để làm mới danh sách khi kéo xuống
  Future<void> _refreshData() async {
    setState(() {
      futureNews = newsApi.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tin tức nóng hổi"),
        centerTitle: true, // Căn giữa tiêu đề cho đẹp
      ),
      body: FutureBuilder<List<News>>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            // Hiển thị nút thử lại khi có lỗi
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Lỗi: ${snapshot.error}", textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _refreshData,
                    child: const Text("Thử lại"),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Không có tin tức nào"));
          }

          List<News> listNews = snapshot.data!;

          // Bọc ListView trong RefreshIndicator
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView.builder(
              physics:
                  const AlwaysScrollableScrollPhysics(), // Đảm bảo kéo được ngay cả khi ít tin
              itemCount: listNews.length,
              itemBuilder: (context, index) {
                final item = listNews[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ), // Căn lề đẹp hơn
                  elevation: 3, // Tạo bóng đổ nhẹ
                  child: InkWell(
                    // Hiệu ứng gợn sóng khi bấm
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetail(newsItem: item),
                        ),
                      );
                    },
                    child: Column(
                      // Dùng Column để hiển thị ảnh to hơn (giống các app báo hiện đại)
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ảnh bìa to
                        if (item.urlToImage.isNotEmpty)
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                            child: Image.network(
                              item.urlToImage,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const SizedBox.shrink(),
                            ),
                          ),

                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    DateFormat(
                                      'dd/MM/yyyy HH:mm',
                                    ).format(item.publishedAt),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
