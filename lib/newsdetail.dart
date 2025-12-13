import 'package:d12m12y2025/Model/news.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsDetail extends StatelessWidget {
  // Biến chứa dữ liệu được truyền từ màn hình danh sách
  final News newsItem;

  const NewsDetail({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chi tiết tin tức")),
      body: SingleChildScrollView(
        // Cho phép cuộn nếu nội dung dài
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh bài báo
            if (newsItem.urlToImage.isNotEmpty)
              Image.network(newsItem.urlToImage),

            const SizedBox(height: 16),

            // Tiêu đề
            Text(
              newsItem.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // Tác giả và ngày đăng
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tác giả: ${newsItem.author}",
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(newsItem.publishedAt),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),

            const Divider(height: 30),

            // Nội dung mô tả
            Text(
              newsItem.description,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),

            const SizedBox(height: 16),

            // Nội dung chính
            Text(newsItem.content, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
