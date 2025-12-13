import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Để dùng tính năng copy
import 'dart:math';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeColorApp(),
    ),
  );
}

class ChangeColorApp extends StatefulWidget {
  const ChangeColorApp({super.key});

  @override
  State<ChangeColorApp> createState() => _ChangeColorAppState();
}

class _ChangeColorAppState extends State<ChangeColorApp> {
  // 1. Dữ liệu: Vẫn giữ nguyên danh sách tên tiếng Việt dễ hiểu
  final List<Map<String, dynamic>> colors = [
    {"color": Colors.red, "name": "Đỏ Rực Rỡ", "hex": "#F44336"},
    {"color": Colors.green, "name": "Xanh Thiên Nhiên", "hex": "#4CAF50"},
    {"color": Colors.blue, "name": "Xanh Biển Cả", "hex": "#2196F3"},
    {"color": Colors.orange, "name": "Cam Năng Động", "hex": "#FF9800"},
    {"color": Colors.purple, "name": "Tím Mộng Mơ", "hex": "#9C27B0"},
    {
      "color": Colors.yellow.shade700,
      "name": "Vàng Hướng Dương",
      "hex": "#FBC02D",
    }, // Chỉnh màu vàng đậm chút cho dễ nhìn text trắng
    {"color": Colors.pink, "name": "Hồng Ngọt Ngào", "hex": "#E91E63"},
    {"color": Colors.teal, "name": "Xanh Ngọc Bích", "hex": "#009688"},
    {
      "color": const Color(0xFF2C3E50),
      "name": "Đêm Huyền Bí",
      "hex": "#2C3E50",
    },
  ];

  // Trạng thái hiện tại
  late Map<String, dynamic> currentColorData;

  @override
  void initState() {
    super.initState();
    currentColorData = colors[4]; // Mặc định chọn màu Tím
  }

  void changeColorRandom() {
    final random = Random();
    int index = random.nextInt(colors.length);
    setState(() {
      currentColorData = colors[index];
    });
  }

  void selectColor(Map<String, dynamic> color) {
    setState(() {
      currentColorData = color;
    });
  }

  // Hàm kiểm tra xem màu nền sáng hay tối để đổi màu chữ cho dễ đọc
  Color getTextColor(Color color) {
    return color.computeLuminance() > 0.5 ? Colors.black87 : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = currentColorData['color'];
    String name = currentColorData['name'];
    String hex = currentColorData['hex'];
    Color textColor = getTextColor(bgColor);

    return Scaffold(
      // Cho phép app tràn màn hình
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Color Palette",
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        // Nền màu đơn sắc
        decoration: BoxDecoration(
          color: bgColor,
        ),
        child: Column(
          children: [
            // --- PHẦN 1: HIỂN THỊ TÊN MÀU (Chiếm 55% màn hình) ---
            Expanded(
              flex: 5, // Chiếm 5 phần
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon trang trí
                      Icon(
                        Icons.palette,
                        size: 80,
                        color: textColor.withOpacity(0.2),
                      ),
                      const SizedBox(height: 20),

                      // Tên màu (To & Đậm)
                      Text(
                        name.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                          color: textColor,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Mã Hex (Nhỏ hơn, bấm vào để copy)
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: hex));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Đã copy mã: $hex"),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: textColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: textColor.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                hex,
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(Icons.copy, size: 16, color: textColor),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --- PHẦN 2: BẢNG ĐIỀU KHIỂN (Chiếm 45% màn hình) ---
            Expanded(
              flex: 4, // Chiếm 4 phần
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 30,
                      offset: Offset(0, -10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chọn màu yêu thích",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // GridView chọn màu
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                            ),
                        itemCount: colors.length,
                        itemBuilder: (context, index) {
                          final item = colors[index];
                          final isSelected = item['name'] == name;

                          return GestureDetector(
                            onTap: () => selectColor(item),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: item['color'],
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: (item['color'] as Color).withOpacity(
                                      0.4,
                                    ),
                                    blurRadius: isSelected ? 10 : 0,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                border: isSelected
                                    ? Border.all(color: Colors.black, width: 3)
                                    : null,
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 18,
                                    )
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 10), // Giảm margin giữa grid và button

                    // Nút Random to đẹp
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom + 10, // Thêm padding để tránh thanh điều hướng
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                        onPressed: changeColorRandom,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 5,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shuffle, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              "ĐỔI MÀU NGẪU NHIÊN",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
