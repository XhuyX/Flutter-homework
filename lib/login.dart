import 'package:d12m12y2025/Model/User.dart';
import 'package:d12m12y2025/auth.dart';
import 'package:d12m12y2025/profile.dart';
import 'package:d12m12y2025/app_theme.dart';
import 'package:flutter/material.dart';

class MyLoginFormPage extends StatefulWidget {
  const MyLoginFormPage({super.key});

  @override
  State<MyLoginFormPage> createState() => _MyLoginFormPageState();
}

class _MyLoginFormPageState extends State<MyLoginFormPage> {
  TextEditingController _user = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  bool _obscurePassword = true; // Biến để quản lý ẩn/hiện mật khẩu
  
  @override
  void dispose() {
    _user.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Ngăn pop mặc định
      onPopInvoked: (didPop) async {
        if (!didPop) {
          // Luôn về Home khi nhấn back vật lý
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          // Luôn hiển thị nút back để về Home
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Luôn về Home khi nhấn back
              Navigator.of(context).pushReplacementNamed('/home');
            },
          ),
        ),
        body: LoginBody(),
      ),
    );
  }

  Widget LoginBody() {
    return AppBackground(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
              hintText: "Nhập tài khoản",
            ),
            controller: _user,
          ),
          SizedBox(height: 30),
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword 
                    ? Icons.visibility_off 
                    : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: OutlineInputBorder(),
              hintText: "Nhập mật khẩu",
            ),
            obscureText: _obscurePassword,
            controller: _pass,
          ),
          SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () async {
              String user = _user.text;
              String pass = _pass.text;

              // 1. Hiện Loading
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );

              // 2. Gọi API Login
              String? token = await login(user, pass);

              // 3. Xử lý kết quả Login
              if (token != null) {
                // --- Đăng nhập thành công ---

                // Gọi tiếp API lấy thông tin Profile (vẫn giữ loading quay)
                UserProfile? userProfile = await getUserProfile(token);

                // 4. TẮT LOADING (Dù thành công hay thất bại bước này cũng phải tắt)
                if (!mounted) return;
                Navigator.pop(context);

                // 5. Kiểm tra Profile có lấy được không rồi mới chuyển trang
                if (userProfile != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyProfilePage(user: userProfile),
                    ),
                  );
                } else {
                  // Có token nhưng không lấy được thông tin user
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Lỗi lấy thông tin cá nhân"),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              } else {
                // --- Đăng nhập thất bại ---

                // QUAN TRỌNG: Phải tắt loading ở đây nữa
                if (!mounted) return;
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Sai tài khoản hoặc mật khẩu"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            label: const Text("Đăng nhập"),
            icon: const Icon(Icons.login),
          ),
        ],
      ),
      ),
    );
  }
}
