class Report {
  final String id;
  final String title;
  final String description;
  final String category;
  final String region;
  final List<String> tags;
  final DateTime date;
  final String status;
  final List<String> photos;
  final List<String> videos;
  double? rating;
  String? feedback;

  Report({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.region,
    required this.tags,
    required this.date,
    required this.status,
    required this.photos,
    required this.videos,
    this.rating,
    this.feedback,
  });
}

extension DateTimeExtension on DateTime {
  String toPersianDate() {
    // Simple mock Persian date formatting
    return '${year}/${month.toString().padLeft(2, '0')}/${day.toString().padLeft(2, '0')}';
  }
}