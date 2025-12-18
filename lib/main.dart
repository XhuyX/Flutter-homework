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
import 'package:d12m12y2025/app_theme.dart'; // Import theme mới
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
      theme: AppTheme.lightTheme, // Sử dụng theme mới
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
      canPop: false, // Ngăn nút back vật lý thoát app khi ềEHome
      onPopInvoked: (didPop) async {
        if (!didPop) {
          // Hiển thềEdialog xác nhận khi muốn thoát app
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.gradientStart, AppColors.gradientEnd],
                ),
              ),
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
              leading: Icon(Icons.looks_one, color: AppColors.primary),
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
              leading: Icon(Icons.looks_two, color: AppColors.primary),
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
              leading: Icon(Icons.looks_3, color: AppColors.primary),
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
              leading: Icon(Icons.looks_4, color: AppColors.primary),
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
              leading: Icon(Icons.looks_5, color: AppColors.primary),
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
              title: const Text('Bài 5: Đếm sềE),
              onTap: () {
                Navigator.pushNamed(context, '/bai5_count');
              },
            ),
            const Divider(),
            // Bài 6
            const ListTile(
              leading: Icon(Icons.looks_6, color: AppColors.primary),
              title: Text(
                'BÀI 6: FORM ĐāEG NHẬP & ĐāEG KÁE,
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
              leading: Icon(Icons.calculate_outlined, color: AppColors.primary),
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
                color: AppColors.primary,
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
              leading: Icon(Icons.newspaper_outlined, color: AppColors.primary),
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
              leading: Icon(Icons.login, color: AppColors.primary),
              title: Text(
                'BÀI 10: LOGIN CÁEDÙNG API',
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
              leading: const Icon(Icons.code, color: AppColors.primary),
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
                      mode: LaunchMode.platformDefault, // Tự động chọn cách mềEphù hợp
                    );
                  } else {
                    // Thử mềEbằng external browser nếu platformDefault không hoạt động
                    await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Không thềEmềElink GitHub: $e'),
                        backgroundColor: Colors.red,
                        action: SnackBarAction(
                          label: 'Sao chép link',
                          onPressed: () {
                            // Có thềEthêm chức năng copy link nếu cần
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
            // Thêm khoảng trống đềEtránh thanh điều hướng ảo (80-100px)
            // Sử dụng MediaQuery đềElấy chiều cao thực tế của bottom padding
            SizedBox(
              height: MediaQuery.of(context).padding.bottom + 80,
            ),
          ],
        ),
      ),
      body: AppBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.home,
                  size: 80,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Chào mừng đến với ứng dụng!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'MềEmenu đềEđiều hướng đến các bài tập',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
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

