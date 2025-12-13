// 1. Model Rating
class Rating {
  double rate;
  int count;

  Rating({this.rate = 0.0, this.count = 0});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      count: json['count'] ?? 0,
    );
  }
}
