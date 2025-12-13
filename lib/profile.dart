import 'package:d12m12y2025/Model/User.dart';
import 'package:d12m12y2025/login.dart';
import 'package:d12m12y2025/main.dart'; // Import file chứa trang Login (hoặc sửa đường dẫn đúng file login của bạn)
import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {
  final UserProfile user;

  const MyProfilePage({super.key, required this.user});

  // Hàm xử lý đăng xuất
  void _handleLogout(BuildContext context) {
    // 1. Xóa token trong SharedPreferences (nếu bạn có lưu)
    // await prefs.remove('user_token');

    // 2. Quay về màn hình Home, xóa tất cả các trang trước đó
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Ngăn nút back vật lý thoát app
      onPopInvoked: (didPop) async {
        if (!didPop) {
          // Nếu có thể pop thì pop, không thì về Home
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Thông tin cá nhân"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pushReplacementNamed('/home');
              }
            },
          ),
          actions: [
            // Nút logout nhỏ trên thanh Appbar
            IconButton(
              onPressed: () => _handleLogout(context),
              icon: const Icon(Icons.logout),
              tooltip: "Đăng xuất",
            ),
          ],
        ),
      body: SingleChildScrollView(
        // Giúp cuộn được nếu màn hình nhỏ
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- PHẦN AVATAR ---
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blueAccent, width: 3),
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(user.image),
                  backgroundColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 15),

              // --- TÊN & USERNAME ---
              Text(
                "${user.firstName} ${user.lastName}",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                "@${user.username}",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),

              // --- DANH SÁCH THÔNG TIN CHI TIẾT ---
              // Bạn có thể tách cái này ra thành widget riêng cho gọn
              _buildInfoCard(
                Icons.perm_identity,
                "ID người dùng",
                user.id.toString(),
              ),
              _buildInfoCard(Icons.email, "Email", user.email),
              _buildInfoCard(Icons.person, "Giới tính", user.gender),

              // Nếu UserProfile có thêm field khác (phone, address...) thì thêm ở đây
              const SizedBox(height: 10),

              // --- NÚT ĐĂNG XUẤT TO ---
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => _handleLogout(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent, // Màu đỏ cảnh báo
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    "Đăng xuất",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      ),
    );
  }

  // Widget con dùng để hiển thị từng dòng thông tin cho đẹp và gọn code
  Widget _buildInfoCard(IconData icon, String title, String content) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(
          content,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        subtitle: Text(title),
      ),
    );
  }
}
