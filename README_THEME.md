# 🎨 Hướng dẫn sử dụng Theme & Background thống nhất

## 📋 Tổng quan

Đã tạo theme thống nhất cho toàn bộ ứng dụng với:
- ✅ Màu sắc nhất quán (Deep Purple gradient)
- ✅ Background gradient đẹp mắt
- ✅ Button, Card, Input styles chuẩn
- ✅ Typography thống nhất

## 🎯 Cách áp dụng cho các file còn lại

### Bước 1: Import AppTheme

Thêm import vào đầu file:

```dart
import 'package:d12m12y2025/app_theme.dart';
```

### Bước 2: Áp dụng Background

#### Option 1: Background với gradient (Đẹp, nổi bật)

Thay thế body của Scaffold:

```dart
// CŨ:
body: Container(
  color: Colors.grey[50],
  child: YourWidget(),
),

// MỚI:
body: AppBackground(
  child: YourWidget(),
),
```

#### Option 2: Background màu trơn (Đơn giản, sáng)

```dart
body: AppBackground(
  useGradient: false,  // Sử dụng màu trơn thay vì gradient
  child: YourWidget(),
),
```

### Bước 3: Sử dụng màu từ AppColors

Thay thế các màu cứng bằng AppColors:

```dart
// CŨ:
color: Colors.deepPurple
color: Colors.grey[50]

// MỚI:
color: AppColors.primary
color: AppColors.background
```

## 📚 AppColors - Bảng màu

```dart
AppColors.primary          // Màu chính (Deep Purple)
AppColors.primaryLight     // Màu chính sáng
AppColors.primaryDark      // Màu chính tối

AppColors.gradientStart    // Màu bắt đầu gradient
AppColors.gradientEnd      // Màu kết thúc gradient

AppColors.accent           // Màu nhấn (Pink)
AppColors.success          // Màu thành công (Green)
AppColors.warning          // Màu cảnh báo (Orange)
AppColors.error            // Màu lỗi (Red)

AppColors.background       // Màu nền
AppColors.surface          // Màu bề mặt (White)
AppColors.cardBackground   // Màu nền card (White)

AppColors.textPrimary      // Màu text chính
AppColors.textSecondary    // Màu text phụ
AppColors.textLight        // Màu text nhạt
```

## 🔧 Ví dụ cụ thể

### Ví dụ 1: Màn hình đơn giản

```dart
import 'package:flutter/material.dart';
import 'package:d12m12y2025/app_theme.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tiêu đề'),
      ),
      body: AppBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Nội dung',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Nút bấm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### Ví dụ 2: Màn hình với Card trên gradient

```dart
body: AppBackground(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Nội dung trong card'),
            // ... các widget khác
          ],
        ),
      ),
    ),
  ),
),
```

### Ví dụ 3: Form trên gradient

```dart
body: AppBackground(
  child: SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Form(
            // ... form fields
          ),
        ),
      ],
    ),
  ),
),
```

## 📝 Danh sách files cần cập nhật

### ✅ Đã cập nhật
- [x] main.dart (Home screen)
- [x] bai5_count_down.dart
- [x] form_register.dart

### ⏳ Cần cập nhật
- [ ] login.dart
- [ ] profile.dart
- [ ] bai1_myhomepage.dart
- [ ] bai2_welcomeback.dart
- [ ] bai3_lophoc.dart
- [ ] bai3_myplace.dart
- [ ] bai4_hotel.dart
- [ ] bai5_change_color.dart
- [ ] bai5_count_number.dart
- [ ] formlogin.dart
- [ ] guiphanhoi.dart
- [ ] BMI_calculator.dart
- [ ] product.dart
- [ ] product_detail.dart
- [ ] news_list.dart
- [ ] newsdetail.dart

## 🚀 Tips

1. **Luôn test sau khi thay đổi**: Chạy `flutter run` để xem kết quả
2. **Sử dụng hot reload**: Nhấn `r` trong terminal để reload nhanh
3. **Text trên gradient**: Nếu text khó đọc trên gradient, thêm shadow:
   ```dart
   style: TextStyle(
     color: Colors.white,
     shadows: [
       Shadow(
         offset: Offset(0, 2),
         blurRadius: 4,
         color: Colors.black26,
       ),
     ],
   ),
   ```
4. **Container trắng trên gradient**: Để làm nổi bật nội dung:
   ```dart
   Container(
     padding: const EdgeInsets.all(20),
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.circular(16),
       boxShadow: [
         BoxShadow(
           color: Colors.black12,
           blurRadius: 10,
           offset: Offset(0, 4),
         ),
       ],
     ),
     child: YourContent(),
   )
   ```

## 🎨 Theme tự động áp dụng

Các widget sau sẽ tự động có style đúng (KHÔNG cần thay đổi code):
- ✅ AppBar (màu primary, text trắng)
- ✅ ElevatedButton (màu primary, text trắng)
- ✅ Card (bo góc 16, shadow nhẹ)
- ✅ TextField (viền khi focus màu primary)
- ✅ Text (màu text chuẩn theo Material 3)

Chỉ cần thay đổi background và màu custom!
