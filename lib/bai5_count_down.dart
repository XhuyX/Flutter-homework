import 'dart:async';
import 'package:flutter/material.dart';

class MyCountDownApp extends StatefulWidget {
  const MyCountDownApp({super.key});

  @override
  State<MyCountDownApp> createState() => _MyCountDownAppState();
}

class _MyCountDownAppState extends State<MyCountDownApp> {
  final TextEditingController _secondsController = TextEditingController();

  Timer? _timer; // Sử dụng Timer thay vì AnimationController
  int _remainingSeconds = 0; // Số giây còn lại
  int _totalSeconds = 0; // Tổng số giây ban đầu
  bool _isRunning = false;
  String? _message;

  @override
  void dispose() {
    _timer?.cancel(); // Hủy timer khi dispose
    _secondsController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    final rawInput = _secondsController.text.trim();
    final seconds = int.tryParse(rawInput);

    if (seconds == null || seconds <= 0) {
      setState(() {
        _message = 'Vui lòng nhập số giây hợp lệ (> 0).';
      });
      return;
    }

    setState(() {
      _totalSeconds = seconds;
      _remainingSeconds = seconds;
      _isRunning = true;
      _message = null;
    });

    // Tạo Timer.periodic chạy mỗi 1 giây
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          // Đếm xong
          _timer?.cancel();
          _isRunning = false;
          _message = '⏰ Đã đếm xong!';
        }
      });
    });
  }

  void _togglePause() {
    if (_isRunning) {
      // Đang chạy -> Tạm dừng
      _timer?.cancel();
      setState(() {
        _isRunning = false;
      });
    } else if (_remainingSeconds > 0) {
      // Đang dừng và còn thời gian -> Tiếp tục
      setState(() {
        _isRunning = true;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_remainingSeconds > 0) {
            _remainingSeconds--;
          } else {
            _timer?.cancel();
            _isRunning = false;
            _message = '⏰ Đã đếm xong!';
          }
        });
      });
    }
  }

  void _resetCountdown() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _remainingSeconds = 0;
      _totalSeconds = 0;
      _message = null;
      _secondsController.clear();
    });
  }

  // Hàm format thời gian hiển thị
  String get _timerString {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Tính phần trăm cho progress indicator
  double get _progressValue {
    if (_totalSeconds == 0) return 0.0;
    return _remainingSeconds / _totalSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Ứng dụng đếm ngược",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // === Nhập liệu ===
                const Text(
                  "Nhập số giây cần đếm ngược:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _secondsController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  enabled: !_isRunning && _remainingSeconds == 0,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: "Nhập giây (ví dụ: 60)",
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.timer, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // === Hiển thị đồng hồ đếm ngược ===
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: CircularProgressIndicator(
                        value: _progressValue,
                        strokeWidth: 15,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _progressValue < 0.1 ? Colors.red : Colors.blue,
                        ),
                      ),
                    ),
                    Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _timerString,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: _progressValue < 0.1
                                ? Colors.red
                                : Colors.blue.shade800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                if (_message != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Text(
                      _message!,
                      style: TextStyle(
                        color: Colors.orange.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                // === Nút bấm ===
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: (_isRunning || _remainingSeconds > 0)
                            ? null
                            : _startCountdown,
                        icon: const Icon(Icons.play_arrow, color: Colors.white),
                        label: const Text(
                          "Bắt đầu",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: _remainingSeconds > 0 ? _togglePause : null,
                        icon: Icon(
                          _isRunning ? Icons.pause : Icons.play_arrow_outlined,
                          color: Colors.white,
                        ),
                        iconSize: 30,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: _resetCountdown,
                        icon: const Icon(Icons.refresh, color: Colors.white),
                        iconSize: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
