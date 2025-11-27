class Place {
  final int id;
  final String name;
  final String location;
  String imageUrl;
  final String description;
  final double rating;

  Place({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.description,
    required this.rating,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    const imageBaseUrl = 'http://10.24.31.99:8080';

    String rawUrl = ((json['imageUrl'] ?? json['image_url']) ?? '')
        .toString()
        .trim();

    // if it’s a relative path like /images/halong.jpg → prepend the base
    if (!rawUrl.startsWith('http')) {
      rawUrl = '$imageBaseUrl$rawUrl';
    }

    return Place(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      imageUrl: rawUrl,
      description: json['description'] ?? '',
      rating: (json['rating'] is num)
          ? (json['rating'] as num).toDouble()
          : 0.0,
    );
  }
}
