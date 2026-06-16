class HistoryReport {
  final String id;
  final String type;
  final String severity;
  final String location;
  final String date;
  final String status;
  final String additionalInfo;
  final String? imageUrl;
  final String? rescuer;

  const HistoryReport({
    required this.id,
    required this.type,
    required this.severity,
    required this.location,
    required this.date,
    required this.status,
    required this.additionalInfo,
    this.imageUrl,
    this.rescuer,
  });
}
