import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bài 1"),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Center(
        // Center everything on screen
        child: Padding(
          padding: const EdgeInsets.all(24.0), // More breathing room
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wrap content height
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center horizontally
            children: [
              const Icon(
                Icons.heart_broken_rounded,
                size: 80,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 20), // Spacing
              const Text(
                "Xin chào mọi người",
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold, // Make it pop
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Lập trình di động nhóm 3",
                style: TextStyle(
                  color: Colors.green[700], // Darker green for readability
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              const Divider(), // Visual separator
              const SizedBox(height: 10),
              const Text(
                "Đây là bài đầu tiên của môn",
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
