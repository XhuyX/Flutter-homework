import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCountNumberApp(),
    ),
  );
}

class MyCountNumberApp extends StatefulWidget {
  const MyCountNumberApp({super.key});

  @override
  State<MyCountNumberApp> createState() => _MyCountNumberAppState();
}

class _MyCountNumberAppState extends State<MyCountNumberApp> {
  int current_value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ứng dụng đếm số",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        // Nền màu theme
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCounterDisplay(),
              const SizedBox(height: 50), // Khoảng cách giữa số và nút
              _buildButtonControls(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget hiển thị số đếm
  Widget _buildCounterDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // Màu trắng mờ
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Giá trị hiện tại",
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
          const SizedBox(height: 10),
          // Hiệu ứng animation khi số thay đổi
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Text(
              '$current_value',
              key: ValueKey<int>(current_value), // Key để nhận biết sự thay đổi
              style: const TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget chứa các nút bấm
  Widget _buildButtonControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Nút Giảm
        _buildCustomButton(
          label: "Giảm",
          icon: Icons.remove,
          color: Colors.orangeAccent,
          onPressed: () {
            setState(() {
              current_value--;
            });
          },
        ),
        const SizedBox(width: 20),

        // Nút Reset (Nhỏ hơn một chút hoặc khác kiểu)
        ElevatedButton(
          onPressed: () {
            setState(() {
              current_value = 0;
            });
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: Colors.white24, // Màu tối hơn
            foregroundColor: Colors.white,
          ),
          child: const Icon(Icons.refresh, size: 30),
        ),

        const SizedBox(width: 20),

        // Nút Tăng
        _buildCustomButton(
          label: "Tăng",
          icon: Icons.add,
          color: Colors.greenAccent.shade400,
          onPressed: () {
            setState(() {
              current_value++;
            });
          },
        ),
      ],
    );
  }

  // Hàm tạo nút bấm dùng chung để code gọn hơn
  Widget _buildCustomButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.black87),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
      ),
    );
  }
}
