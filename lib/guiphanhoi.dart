import 'package:flutter/material.dart';

class GuiPhanHoi extends StatefulWidget {
  const GuiPhanHoi({super.key});

  @override
  State<GuiPhanHoi> createState() => _GuiPhanHoiState();
}

class _GuiPhanHoiState extends State<GuiPhanHoi> {
  // Biến lưu số sao người dùng chọn (0 là chưa chọn)
  int _soSao = 0;
  final TextEditingController _hoten = TextEditingController();
  final TextEditingController _noiDung = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "GỬI PHẢN HỒI",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Icon trang trí phía trên
            Icon(
              Icons.mark_chat_unread_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ),
            const SizedBox(height: 10),
            const Text(
              "Ý kiến của bạn giúp chúng tôi tốt hơn!",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 30),

            // PHẦN CARD CHỨA FORM
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20), // Bo tròn mềm mại
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), // Bóng đổ nhẹ
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. ĐÁNH GIÁ SAO (Thay thế Dropdown)
                  const Center(
                    child: Text(
                      "Bạn đánh giá trải nghiệm thế nào?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        iconSize: 40,
                        onPressed: () {
                          setState(() {
                            _soSao = index + 1;
                          });
                        },
                        // Logic đổi màu sao: Nếu index < số sao đã chọn thì màu vàng, ngược lại màu xám
                        icon: Icon(
                          index < _soSao
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          color: index < _soSao
                              ? Colors.amber
                              : Colors.grey.shade300,
                        ),
                      );
                    }),
                  ),
                  // Hiển thị chữ trạng thái dựa trên số sao
                  Center(
                    child: Text(
                      _soSao == 0
                          ? "(Chưa chọn)"
                          : _soSao == 5
                          ? "Tuyệt vời!"
                          : _soSao == 4
                          ? "Rất tốt"
                          : _soSao == 3
                          ? "Bình thường"
                          : "Cần cải thiện",
                      style: TextStyle(
                        color: Colors.amber[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                  const Divider(),
                  const SizedBox(height: 15),

                  // 2. Ô NHẬP HỌ TÊN
                  _buildCustomTextField(
                    controller: _hoten,
                    label: "Họ và tên",
                    icon: Icons.person_outline_rounded,
                  ),

                  const SizedBox(height: 20),

                  // 3. Ô NHẬP NỘI DUNG
                  _buildCustomTextField(
                    controller: _noiDung,
                    label: "Chia sẻ ý kiến của bạn...",
                    icon: Icons.edit_note_rounded,
                    maxLines: 4,
                  ),

                  const SizedBox(height: 30),

                  // 4. NÚT GỬI
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_soSao == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Vui lòng chọn số sao đánh giá!"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        var name = _hoten.text.isEmpty ? "bạn" : _hoten.text;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Cảm ơn $name đã gửi $_soSao sao!"),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            30,
                          ), // Bo tròn dạng viên thuốc
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "GỬI PHẢN HỒI",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.send_rounded),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm Helper để tạo TextField đẹp hơn
  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            bottom: 2,
          ), // Căn chỉnh icon nếu nhiều dòng
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        filled: true,
        fillColor: Colors.grey.shade50, // Màu nền nhẹ bên trong ô nhập
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none, // Bỏ viền đen mặc định
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
        ),
      ),
    );
  }
}
