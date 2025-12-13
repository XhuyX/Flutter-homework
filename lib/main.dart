import 'package:d12m12y2025/login.dart';
import 'package:d12m12y2025/product.dart';
import 'package:d12m12y2025/news_list.dart';
import 'package:d12m12y2025/myclassroom.dart';
import 'package:d12m12y2025/BMI_calculator.dart';
import 'package:d12m12y2025/bai1_myhomepage.dart';
import 'package:d12m12y2025/bai2_welcomeback.dart';
import 'package:d12m12y2025/bai3_lophoc.dart';
import 'package:d12m12y2025/bai3_myplace.dart';
import 'package:d12m12y2025/bai4_hotel.dart';
import 'package:d12m12y2025/bai5_change_color.dart';
import 'package:d12m12y2025/bai5_count_down.dart';
import 'package:d12m12y2025/bai5_count_number.dart';
import 'package:d12m12y2025/form_register.dart';
import 'package:d12m12y2025/formlogin.dart';
import 'package:d12m12y2025/guiphanhoi.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter homework',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
        ),
      ),
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const MyLoginFormPage(),
        '/product': (context) => const MyProduct(),
        '/news': (context) => const Mypage(),
        '/classroom': (context) => const MyClassroomPage(),
        '/bmi': (context) => const MyBMICalculator(),
        '/bai1': (context) => const MyHomePage(),
        '/bai2': (context) => const MyWidget(),
        '/bai3_lophoc': (context) => const LopHocScreen(),
        '/bai3_myplace': (context) => const SaharaPage(),
        '/bai4': (context) => const HotelListScreen(),
        '/bai5_color': (context) => const ChangeColorApp(),
        '/bai5_countdown': (context) => const MyCountDownApp(),
        '/bai5_count': (context) => const MyCountNumberApp(),
        '/register': (context) => const MyRegisterForm(),
        '/formlogin': (context) => const MyLoginForm(),
        '/feedback': (context) => const GuiPhanHoi(),
      },
    );
  }
}

// Wrapper Screen cho Lớp học
class LopHocScreen extends StatelessWidget {
  const LopHocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lớp học')),
      body: const CourseListView(),
    );
  }
}

// Wrapper Screen cho My Classroom
class MyClassroomPage extends StatelessWidget {
  const MyClassroomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lớp học của tôi')),
      body: const CourseListView(),
    );
  }
}

// Màn hình Home với Navigation Drawer
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Ngăn nút back vật lý thoát app khi ở Home
      onPopInvoked: (didPop) async {
        if (!didPop) {
          // Hiển thị dialog xác nhận khi muốn thoát app
          final shouldExit = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Thoát ứng dụng?'),
              content: const Text('Bạn có chắc chắn muốn thoát ứng dụng không?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Hủy'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Thoát'),
                ),
              ],
            ),
          );
          if (shouldExit == true && context.mounted) {
            // Thoát app
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('22T1020625 - Huỳnh Huy'),
        ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.menu_book, size: 48, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Danh Sách Bài Tập',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Bài 1
            const ListTile(
              leading: Icon(Icons.looks_one, color: Colors.deepPurple),
              title: Text(
                'BÀI 1',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Bài 1: Home Page'),
              onTap: () {
                Navigator.pushNamed(context, '/bai1');
              },
            ),
            const Divider(),
            // Bài 2
            const ListTile(
              leading: Icon(Icons.looks_two, color: Colors.deepPurple),
              title: Text(
                'BÀI 2',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.waving_hand_rounded),
              title: const Text('Bài 2: Welcome Back'),
              onTap: () {
                Navigator.pushNamed(context, '/bai2');
              },
            ),
            const Divider(),
            // Bài 3
            const ListTile(
              leading: Icon(Icons.looks_3, color: Colors.deepPurple),
              title: Text(
                'BÀI 3',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.class_),
              title: const Text('Bài 3: Lớp học'),
              onTap: () {
                Navigator.pushNamed(context, '/bai3_lophoc');
              },
            ),
            ListTile(
              leading: const Icon(Icons.place),
              title: const Text('Bài 3: My Place'),
              onTap: () {
                Navigator.pushNamed(context, '/bai3_myplace');
              },
            ),
            const Divider(),
            // Bài 4
            const ListTile(
              leading: Icon(Icons.looks_4, color: Colors.deepPurple),
              title: Text(
                'BÀI 4',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.hotel),
              title: const Text('Bài 4: Hotel'),
              onTap: () {
                Navigator.pushNamed(context, '/bai4');
              },
            ),
            const Divider(),
            // Bài 5
            const ListTile(
              leading: Icon(Icons.looks_5, color: Colors.deepPurple),
              title: Text(
                'BÀI 5',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: const Text('Bài 5: Đổi màu'),
              onTap: () {
                Navigator.pushNamed(context, '/bai5_color');
              },
            ),
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('Bài 5: Đếm ngược'),
              onTap: () {
                Navigator.pushNamed(context, '/bai5_countdown');
              },
            ),
            ListTile(
              leading: const Icon(Icons.numbers),
              title: const Text('Bài 5: Đếm số'),
              onTap: () {
                Navigator.pushNamed(context, '/bai5_count');
              },
            ),
            const Divider(),
            // Bài 6
            const ListTile(
              leading: Icon(Icons.looks_6, color: Colors.deepPurple),
              title: Text(
                'BÀI 6: FORM ĐĂNG NHẬP & ĐĂNG KÝ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Form Login'),
              onTap: () {
                Navigator.pushNamed(context, '/formlogin');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Form Register'),
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
            ),
            const Divider(),
            // Bài 7
            const ListTile(
              leading: Icon(Icons.calculate_outlined, color: Colors.deepPurple),
              title: Text(
                'BÀI 7: BMI & FEEDBACK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Máy tính BMI'),
              onTap: () {
                Navigator.pushNamed(context, '/bmi');
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Gửi phản hồi'),
              onTap: () {
                Navigator.pushNamed(context, '/feedback');
              },
            ),
            const Divider(),
            // Bài 8
            const ListTile(
              leading: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.deepPurple,
              ),
              title: Text(
                'BÀI 8: FAKE API PRODUCT',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Danh sách sản phẩm'),
              onTap: () {
                Navigator.pushNamed(context, '/product');
              },
            ),
            const Divider(),
            // Bài 9
            const ListTile(
              leading: Icon(Icons.newspaper_outlined, color: Colors.deepPurple),
              title: Text(
                'BÀI 9: NEWS API',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.newspaper),
              title: const Text('Danh sách tin tức'),
              onTap: () {
                Navigator.pushNamed(context, '/news');
              },
            ),
            const Divider(),
            // Bài 10
            const ListTile(
              leading: Icon(Icons.login, color: Colors.deepPurple),
              title: Text(
                'BÀI 10: LOGIN CÓ DÙNG API',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Đăng nhập với API'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            const Divider(),
            // GitHub Link
            ListTile(
              leading: const Icon(Icons.code, color: Colors.deepPurple),
              title: const Text('GitHub Repository'),
              subtitle: const Text(
                'Xem mã nguồn trên GitHub',
                style: TextStyle(fontSize: 12),
              ),
              onTap: () async {
                try {
                  final Uri url = Uri.parse('https://github.com/XhuyX/Flutter-homework');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(
                      url,
                      mode: LaunchMode.platformDefault, // Tự động chọn cách mở phù hợp
                    );
                  } else {
                    // Thử mở bằng external browser nếu platformDefault không hoạt động
                    await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Không thể mở link GitHub: $e'),
                        backgroundColor: Colors.red,
                        action: SnackBarAction(
                          label: 'Sao chép link',
                          onPressed: () {
                            // Có thể thêm chức năng copy link nếu cần
                          },
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
              ),
            // Thêm khoảng trống để tránh thanh điều hướng ảo (80-100px)
            // Sử dụng MediaQuery để lấy chiều cao thực tế của bottom padding
            SizedBox(
              height: MediaQuery.of(context).padding.bottom + 80,
            ),
          ],
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 80, color: Colors.deepPurple),
            SizedBox(height: 20),
            Text(
              'Chào mừng đến với ứng dụng!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Mở menu để điều hướng đến các bài tập',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
