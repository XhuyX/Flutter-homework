// myclassroom.dart
import 'package:flutter/material.dart';

// 1. MODEL: Khuôn mẫu dữ liệu
class Course {
  final String title;
  final String code;
  final String studentCount;
  final Color backgroundColor;
  final String patternImagePath;

  Course({
    required this.title,
    required this.code,
    required this.studentCount,
    required this.backgroundColor,
    required this.patternImagePath,
  });
}

// 2. DATA: Dữ liệu giả lập (Sau này thay bằng API cũng sửa ở đây)
final List<Course> fakeCourseData = [
  Course(
    title: 'XML và ứng dụng - Nhóm 1',
    code: '2025-2026.1.TIN4583.001',
    studentCount: '58 học viên',
    backgroundColor: const Color(0xff3D5A80),
    patternImagePath: 'assets/norm.png',
  ),
  Course(
    title: 'Lập trình ứng dụng di động - Nhóm 6',
    code: '2025-2026.1.TIN4403.006',
    studentCount: '55 học viên',
    backgroundColor: const Color(0xffE07A5F),
    patternImagePath: 'assets/heaven.png',
  ),
  Course(
    title: 'Lập trình ứng dụng - Nhóm 5',
    code: '2025-2026.1.TIN4403.005',
    studentCount: '52 học viên',
    backgroundColor: const Color(0xffE07A5F),
    patternImagePath: 'assets/hard.png',
  ),
  Course(
    title: 'Lập trình ứng dụng - Nhóm 4',
    code: '2025-2026.1.TIN4403.004',
    studentCount: '50 học viên',
    backgroundColor: const Color(0xff2A7AB0),
    patternImagePath: 'assets/ultra.png',
  ),
  Course(
    title: 'Lập trình ứng dụng - Nhóm 3',
    code: '2025-2026.1.TIN4403.003',
    studentCount: '52 học viên',
    backgroundColor: const Color(0xff3D5A80),
    patternImagePath: 'assets/Razuluca.jpg', // Thay bằng ảnh thật của bạn
  ),
];

// 3. MAIN WIDGET: Widget hiển thị danh sách (Main sẽ gọi cái này)
class CourseListView extends StatelessWidget {
  const CourseListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      itemCount: fakeCourseData.length,
      itemBuilder: (context, index) {
        final course = fakeCourseData[index];
        return CourseCard(
          title: course.title,
          code: course.code,
          studentCount: course.studentCount,
          backgroundColor: course.backgroundColor,
          patternImagePath: course.patternImagePath,
        );
      },
    );
  }
}

// 4. SUB WIDGET: Thẻ hiển thị chi tiết (Code cũ của bạn)
class CourseCard extends StatelessWidget {
  final String title;
  final String code;
  final String studentCount;
  final Color backgroundColor;
  final String patternImagePath;

  const CourseCard({
    super.key,
    required this.title,
    required this.code,
    required this.studentCount,
    required this.backgroundColor,
    required this.patternImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
        image: DecorationImage(
          image: AssetImage(patternImagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.7), // Đã lấy theo code bạn gửi
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.more_vert, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  code,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
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
          ),
        ),
      ),
    );
  }
}
