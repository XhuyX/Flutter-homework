// course_card.dart

import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String code;
  final String studentCount;
  final Color backgroundColor;
  final String patternImagePath;

  const CourseCard({
    Key? key,
    required this.title,
    required this.code,
    required this.studentCount,
    required this.backgroundColor,
    required this.patternImagePath,
  }) : super(key: key);

 // Cập nhật hàm build() trong file course_card.dart

@override
Widget build(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    height: 120,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
      image: DecorationImage(
        image: AssetImage(patternImagePath),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.1),
          BlendMode.dstATop,
        ),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Thêm khoảng đệm cho nội dung
        child: Stack(
          children: [
            // Cụm văn bản bên trái 📝
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Căn lề trái cho văn bản
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4), // Khoảng cách nhỏ
                Text(
                  code,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const Spacer(), // Đẩy nội dung bên dưới xuống đáy
                Text(
                  studentCount,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            // Icon ba chấm ở góc trên bên phải 🔧
            Positioned(
              top: -8, // Điều chỉnh vị trí để căn icon đẹp hơn
              right: -8,
              child: IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {
                  // Xử lý khi nhấn vào icon
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}