import 'package:flutter/material.dart';

class MyRegisterForm extends StatefulWidget {
  const MyRegisterForm({super.key});

  @override
  State<MyRegisterForm> createState() => MyRegisterFormState();
}

class MyRegisterFormState extends State<MyRegisterForm> {
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Trạng thái ẩn/hiện mật khẩu
  bool _anMatKhau = true;
  bool _anNhapLaiMatKhau = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  // Helper Widget để xây dựng các TextFormField với style nhất quán
  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    TextEditingController? controller,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
  }) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? obscureText : false,
      cursorColor: primaryColor,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600),
        prefixIcon: Icon(icon, color: primaryColor),
        filled: true,
        fillColor: Colors.grey.shade50, // Màu nền nhẹ cho ô nhập
        // Icon hiển thị/ẩn mật khẩu
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: onToggleVisibility,
              )
            : null,

        // Style border khi chưa focus
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15), // Bo tròn
          borderSide: BorderSide.none, // Bỏ viền mặc định
        ),
        // Style border khi focus (có viền màu xanh)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        // Style border khi có lỗi
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      // Dùng background từ theme thống nhất
      appBar: AppBar(
        title: const Text(
          "TẠO TÀI KHOẢN",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Icon lớn phía trên Form
              const SizedBox(height: 10),
              Text(
                "Đăng ký để tiếp tục",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 40),

              // KHUNG FORM MÀU TRẮNG (CARD)
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // --- Họ tên ---
                      _buildTextField(
                        context: context,
                        label: 'Họ tên',
                        icon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Vui lòng nhập họ tên";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // --- Email ---
                      _buildTextField(
                        context: context,
                        label: 'Email',
                        icon: Icons.alternate_email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Vui lòng nhập email";
                          }
                          final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(value);
                          if (!emailValid) return "Email không hợp lệ";
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // --- Mật khẩu ---
                      _buildTextField(
                        context: context,
                        label: 'Mật khẩu',
                        icon: Icons.lock_outline,
                        controller: _passwordController,
                        isPassword: true,
                        obscureText: _anMatKhau,
                        onToggleVisibility: () {
                          setState(() {
                            _anMatKhau = !_anMatKhau;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Vui lòng nhập mật khẩu";
                          }
                          if (value.length < 6) {
                            return "Mật khẩu phải có ít nhất 6 ký tự";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // --- Nhập lại mật khẩu ---
                      _buildTextField(
                        context: context,
                        label: 'Nhập lại mật khẩu',
                        icon: Icons.check_circle_outline,
                        isPassword: true,
                        obscureText: _anNhapLaiMatKhau,
                        onToggleVisibility: () {
                          setState(() {
                            _anNhapLaiMatKhau = !_anNhapLaiMatKhau;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Vui lòng nhập lại mật khẩu";
                          }
                          if (value != _passwordController.text) {
                            return "Mật khẩu không khớp";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),

                      // --- Button Đăng ký ---
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor, // Sửa: dùng màu primary thay vì trắng
                            foregroundColor: Colors.white, // Sửa: text màu trắng
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 8,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus(); // Ẩn bàn phím
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Đăng ký thành công!'),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.person_add,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "ĐĂNG KÝ TÀI KHOẢN",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              // Link Đã có tài khoản
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Đã có tài khoản? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/formlogin');
                    },
                    child: Text(
                      "Đăng nhập ngay",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
