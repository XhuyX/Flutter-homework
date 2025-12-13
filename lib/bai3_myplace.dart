import 'package:flutter/material.dart';

class SaharaPage extends StatelessWidget {
  const SaharaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sahara Detail")),
      body: myBody(),
    );
  }

  // Đưa hàm myBody vào trong class
  Widget myBody() {
    return ListView(
      // Dùng ListView để cuộn được nếu màn hình nhỏ
      children: [block1(), block2(), block3(), block4()],
    );
  }

  // BLOCK 1: HÌNH ẢNH
  Widget block1() {
    var src =
        "https://images.unsplash.com/photo-1755918909925-f62b86d93c2a?q=80&w=1170&auto=format&fit=crop";
    return Image.network(
      src,
      width: double.infinity, // Để ảnh tràn chiều ngang màn hình
      height: 240, // Chiều cao cố định cho đẹp
      fit: BoxFit.cover, // Cắt ảnh để lấp đầy khung mà không bị méo
    );
  }

  // BLOCK 2: TIÊU ĐỀ VÀ ĐÁNH GIÁ
  Widget block2() {
    var name = "Hoang mạc Sahara";
    var address = "Bắc Phi";
    var voteRate = "41";

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8), // Khoảng cách nhỏ giữa tên và địa chỉ
              Text(address, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.red),
              Text(voteRate),
            ],
          ),
        ],
      ),
    );
  }

  // BLOCK 3: CÁC NÚT CHỨC NĂNG
  Widget block3() {
    var colorBlue = Colors.blueAccent;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(colorBlue, Icons.call, "CALL"),
          _buildButtonColumn(colorBlue, Icons.near_me, "ROUTE"),
          _buildButtonColumn(colorBlue, Icons.share, "SHARE"),
        ],
      ),
    );
  }

  // Hàm phụ để tạo nút bấm cho gọn code (giống Flutter docs)
  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  // BLOCK 4: MÔ TẢ (Đã sửa lại nội dung text)
  Widget block4() {
    // Sửa lại nội dung text thay vì để link ảnh
    var data =
        "Sahara là hoang mạc nóng lớn nhất thế giới và là hoang mạc lớn thứ ba trên Trái Đất (sau Nam Cực và Bắc Cực). "
        "Với diện tích hơn 9 triệu km², nó bao phủ hầu hết Bắc Phi. "
        "Sahara có những cồn cát cao ngất ngưởng, những ốc đảo xanh tươi và khí hậu vô cùng khắc nghiệt.";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        data,
        softWrap: true,
        textAlign: TextAlign.justify, // Căn đều 2 bên cho đẹp
      ),
    );
  }
}
