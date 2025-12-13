import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Booking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HotelListScreen(),
    );
  }
}

class HotelListScreen extends StatefulWidget {
  const HotelListScreen({super.key});

  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> {
  final List<Hotel> hotels = [
    Hotel(
      name: 'aNhill Boutique',
      rating: 9.5,
      ratingLabel: 'Xuất sắc',
      reviewCount: 95,
      location: 'Huế',
      distance: 0.6,
      roomType: '1 suite riêng tư',
      bedCount: '1 giường',
      price: 109,
      imageUrl:
          'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
      hasBreakfast: true,
      stars: 5,
    ),
    Hotel(
      name: 'An Nam Hue Boutique',
      rating: 9.2,
      ratingLabel: 'Tuyệt hảo',
      reviewCount: 34,
      location: 'Cư Chính',
      distance: 0.9,
      roomType: '1 phòng khách sạn',
      bedCount: '1 giường',
      price: 20,
      imageUrl:
          'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800',
      hasBreakfast: true,
      stars: 5,
    ),
    Hotel(
      name: 'Huế Jade Hill Villa',
      rating: 8.0,
      ratingLabel: 'Rất tốt',
      reviewCount: 1,
      location: 'Cư Chính',
      distance: 1.3,
      roomType: '1 biệt thự nguyên căn',
      area: '1.000 m²',
      bedCount: '4 giường',
      rooms: '3 phòng ngủ • 1 phòng khách • 3 phòng tắm',
      price: 285,
      imageUrl:
          'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800',
      hasBreakfast: false,
      specialNote: 'Chỉ còn 1 căn với giá này trên Booking.com',
      requiresPayment: true,
      stars: 4,
    ),
    Hotel(
      name: 'Em Villa',
      rating: 0,
      ratingLabel: '',
      reviewCount: 0,
      location: 'Huế',
      distance: 2.1,
      roomType: 'Villa',
      bedCount: '2 giường',
      price: 150,
      imageUrl:
          'https://images.unsplash.com/photo-1602343168117-bb8ffe3e2e9f?w=800',
      hasBreakfast: true,
      specialNote: 'Được quản lý bởi một host cá nhân',
      stars: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            // Handle search tap
          },
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.grey[700]),
                  iconSize: 24,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Xung quanh vị trí hiện tại',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        '23 thg 10 – 24 thg 10',
                        style: TextStyle(color: Colors.grey[600], fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(child: _buildFilterButton(Icons.sort, 'Sắp xếp')),
                const SizedBox(width: 8),
                Expanded(child: _buildFilterButton(Icons.filter_list, 'Lọc')),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildFilterButton(Icons.map_outlined, 'Bản đồ'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '757 chỗ nghỉ',
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                return HotelCard(hotel: hotels[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(IconData icon, String label) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18, color: Colors.black87),
      label: Text(
        label,
        style: const TextStyle(color: Colors.black87, fontSize: 13),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        side: BorderSide(color: Colors.grey[300]!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final Hotel hotel;

  const HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Phần hình ảnh bên trái
            SizedBox(
              width: 140,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      hotel.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.image, size: 50),
                        );
                      },
                    ),
                  ),
                  if (hotel.hasBreakfast)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[700],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Bao bữa sáng',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Phần thông tin bên phải
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hotel.name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: List.generate(
                                  hotel.stars,
                                  (index) => Icon(
                                    Icons.star,
                                    size: 13,
                                    color: Colors.orange[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            size: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    if (hotel.rating > 0) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              hotel.rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '${hotel.ratingLabel} · ${hotel.reviewCount} đánh giá',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 13,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${hotel.location} · Cách bạn ${hotel.distance}km',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${hotel.roomType}: ${hotel.bedCount}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (hotel.area != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        '${hotel.area} · ${hotel.rooms}',
                        style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const Spacer(),
                    if (hotel.specialNote != null) ...[
                      Text(
                        hotel.specialNote!,
                        style: TextStyle(fontSize: 10, color: Colors.red[700]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                    ],
                    if (hotel.requiresPayment == true)
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 13,
                            color: Colors.green[700],
                          ),
                          const SizedBox(width: 4),
                          const Expanded(
                            child: Text(
                              'Không cần thanh toán trước',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.green,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'US\$${hotel.price}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Đã bao gồm thuế và phí',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
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

class Hotel {
  final String name;
  final double rating;
  final String ratingLabel;
  final int reviewCount;
  final String location;
  final double distance;
  final String roomType;
  final String bedCount;
  final int price;
  final String imageUrl;
  final bool hasBreakfast;
  final int stars;
  final String? area;
  final String? rooms;
  final String? specialNote;
  final bool? requiresPayment;

  Hotel({
    required this.name,
    required this.rating,
    required this.ratingLabel,
    required this.reviewCount,
    required this.location,
    required this.distance,
    required this.roomType,
    required this.bedCount,
    required this.price,
    required this.imageUrl,
    required this.hasBreakfast,
    required this.stars,
    this.area,
    this.rooms,
    this.specialNote,
    this.requiresPayment,
  });
}
