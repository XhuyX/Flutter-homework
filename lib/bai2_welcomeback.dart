import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Nền xám nhạt hiện đại
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header bao gồm: Nút Back, Icons và chữ Welcome
              const HeaderSection(),

              const SizedBox(height: 24.0),

              // 2. Thanh tìm kiếm
              const ModernSearchBar(),

              const SizedBox(height: 24.0),

              // 3. Title Saved Places
              const SectionTitle(title: "Saved Places"),

              const SizedBox(height: 16.0),

              // 4. Grid ảnh Assets
              Expanded(child: PlaceGrid()),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Hàng trên cùng: Nút Back và Icons ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // NÚT BACK (Quay lại)
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Lệnh quay lại
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: Colors.black87,
                ),
              ),
            ),

            // Cụm Icon Notifications & Settings
            Row(
              children: [
                _buildIconBtn(Icons.notifications_outlined),
                const SizedBox(width: 12),
                _buildIconBtn(Icons.settings_outlined),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20), // Khoảng cách giữa nút và chữ Welcome
        // --- Chữ Welcome, Charlie ---
        RichText(
          text: const TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: "Welcome,\n",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28, // Chữ to
                  color: Colors.black87,
                  height: 1.2, // Khoảng cách dòng
                ),
              ),
              TextSpan(
                text: "Charlie",
                style: TextStyle(
                  fontSize: 28, // Chữ to bằng chữ trên
                  fontWeight: FontWeight.w300, // Nét mảnh hơn
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Hàm tạo nút tròn nhỏ cho gọn code
  Widget _buildIconBtn(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.grey[800], size: 22),
    );
  }
}

class PlaceGrid extends StatelessWidget {
  PlaceGrid({super.key});

  // Dữ liệu đúng như bạn yêu cầu
  final List<Map<String, String>> places = [
    {'img': 'assets/Picture1.png', 'name': 'Palace'},
    {'img': 'assets/Picture2.png', 'name': 'Sky'},
    {'img': 'assets/Picture3.png', 'name': 'Rome'},
    {'img': 'assets/Picture4.png', 'name': 'Nature'},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.85,
      ),
      itemCount: places.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: AssetImage(places[index]['img']!), // Dùng Asset
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Lớp phủ đen mờ để chữ nổi
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
              // Tên địa điểm
              Positioned(
                bottom: 12,
                left: 12,
                child: Text(
                  places[index]['name']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Các Widget phụ trợ giữ nguyên
class ModernSearchBar extends StatelessWidget {
  const ModernSearchBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search...",
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(Icons.search_rounded, color: Colors.blueAccent[200]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            "See all",
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ],
    );
  }
}
