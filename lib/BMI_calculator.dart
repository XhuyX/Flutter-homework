import 'package:flutter/material.dart';

class MyBMICalculator extends StatefulWidget {
  const MyBMICalculator({super.key});

  @override
  State<MyBMICalculator> createState() => _MyBMICalculatorState();
}

class _MyBMICalculatorState extends State<MyBMICalculator> {
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();

  // Biến lưu kết quả
  double _bmiResult = 0;
  String _message = "Nhập thông tin để tính";
  Color _statusColor = Colors.grey; // Màu sắc thay đổi theo kết quả

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BMI HEALTH CHECK",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // 1. PHẦN HIỂN THỊ KẾT QUẢ (Card to nhất)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "CHỈ SỐ BMI CỦA BẠN",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _bmiResult == 0 ? "--.-" : _bmiResult.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: _statusColor, // Màu số thay đổi
                      ),
                    ),
                    Text(
                      _message,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: _statusColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 2. CARD NHẬP CHIỀU CAO
              _buildInputCard(
                label: "CHIỀU CAO",
                unit: "cm",
                controller: _height,
                icon: Icons.height,
              ),

              const SizedBox(height: 20),

              // 3. CARD NHẬP CÂN NẶNG
              _buildInputCard(
                label: "CÂN NẶNG",
                unit: "kg",
                controller: _weight,
                icon: Icons.monitor_weight_outlined,
              ),

              const SizedBox(height: 40),

              // 4. NÚT BẤM (Dùng màu từ theme thống nhất)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: calculateBMI,
                  style: ElevatedButton.styleFrom(
                    // Dùng màu primary từ theme thống nhất
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "TÍNH TOÁN NGAY",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget con để tạo ô nhập liệu giống nhau cho đẹp
  Widget _buildInputCard({
    required String label,
    required String unit,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number, // Chỉ hiện bàn phím số
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A0E21),
            ),
            decoration: InputDecoration(
              border: InputBorder.none, // Bỏ viền mặc định của TextField
              hintText: "0",
              icon: Icon(icon, color: Theme.of(context).colorScheme.primary),
              suffixText: unit, // Chữ cm/kg ở cuối
              suffixStyle: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  void calculateBMI() {
    if (_height.text.isEmpty || _weight.text.isEmpty) {
      setState(() {
        _message = "Thiếu thông tin!";
        _statusColor = Colors.grey;
        _bmiResult = 0;
      });
      return;
    }

    try {
      double heightCm = double.parse(_height.text);
      double weightKg = double.parse(_weight.text);

      double heightM = heightCm / 100;
      double bmi = weightKg / (heightM * heightM);

      String msg = "";
      Color colorStatus;

      // Logic xếp loại và đổi màu
      if (bmi < 18.5) {
        msg = "Thiếu cân";
        colorStatus = Colors.blue; // Màu xanh dương cho thiếu cân
      } else if (bmi < 25) {
        msg = "Bình thường";
        colorStatus = Colors.green; // Màu xanh lá cho bình thường
      } else if (bmi < 30) {
        msg = "Thừa cân";
        colorStatus = Colors.orange; // Màu cam cảnh báo
      } else {
        msg = "Béo phì";
        colorStatus = Colors.red; // Màu đỏ nguy hiểm
      }

      setState(() {
        _bmiResult = bmi;
        _message = msg;
        _statusColor = colorStatus;
      });

      // Ẩn bàn phím sau khi tính
      FocusScope.of(context).unfocus();
    } catch (e) {
      setState(() {
        _message = "Số liệu không hợp lệ";
        _statusColor = Colors.grey;
      });
    }
  }
}
