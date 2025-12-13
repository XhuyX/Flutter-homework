class Source {
  String id;
  String name;

  Source({this.id = "", this.name = ""});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json['id'] ?? "", name: json['name'] ?? "");
  }
}

class News {
  Source src;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt; // <--- Dùng DateTime ở đây
  String content; // Content là String

  News({
    required this.src,
    this.author = "",
    this.title = "",
    this.description = "",
    this.url = "",
    this.urlToImage = "",
    required this.publishedAt,
    this.content = "",
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      // Parse object lồng nhau
      src: Source.fromJson(json['source'] ?? {}),

      author: json['author'] ?? "Unknown",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'] ?? "",

      // PARSE NGÀY THÁNG TẠI ĐÂY
      // Nếu dữ liệu null, lấy thời điểm hiện tại làm mặc định
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : DateTime.now(),

      content: json['content'] ?? "",
    );
  }
}
