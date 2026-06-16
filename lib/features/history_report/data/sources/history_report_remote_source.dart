import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

import '../models/history_report_model.dart';

class HistoryReportRemoteSource {
  const HistoryReportRemoteSource({
    required this.database,
    required this.phone,
  });

  final FirebaseDatabase database;
  final String? phone;
  static const String _collection = 'incident_reports';

  String _formatCreatedAt(dynamic raw) {
    if (raw is int) {
      return DateFormat.yMMMd().add_jm().format(
        DateTime.fromMillisecondsSinceEpoch(raw),
      );
    }
    if (raw is double) {
      return DateFormat.yMMMd().add_jm().format(
        DateTime.fromMillisecondsSinceEpoch(raw.toInt()),
      );
    }
    if (raw is String) {
      final parsed = DateTime.tryParse(raw);
      if (parsed != null) {
        return DateFormat.yMMMd().add_jm().format(parsed);
      }
    }
    return '';
  }

  static const String _defaultStatus = 'Reported';

  /// Normalizes admin-style `snake_case` / `kebab-case` to spaces, then sentence case
  /// (e.g. `in_progress` → `In progress`, `IN PROGRESS` → `In progress`).
  String _toSentenceCase(String value) {
    final String spaced = value
        .trim()
        .replaceAll(RegExp(r'[_-]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    if (spaced.isEmpty) return spaced;
    return '${spaced[0].toUpperCase()}${spaced.substring(1).toLowerCase()}';
  }

  String _statusFromData(Map<String, dynamic> data) {
    final dynamic raw = data['status'];
    if (raw == null) return _defaultStatus;
    final String s = raw.toString().trim();
    if (s.isEmpty) return _defaultStatus;
    return _toSentenceCase(s);
  }

  int _createdAtMillis(dynamic raw) {
    if (raw is int) return raw;
    if (raw is double) return raw.toInt();
    if (raw is String)
      return DateTime.tryParse(raw)?.millisecondsSinceEpoch ?? 0;
    return 0;
  }

  HistoryReportModel _docToModel(String docId, Map<String, dynamic> data) {
    final double lat = (data['latitude'] as num?)?.toDouble() ?? 0;
    final double lng = (data['longitude'] as num?)?.toDouble() ?? 0;
    final String location = (lat == 0 && lng == 0)
        ? 'Location unavailable'
        : '${lat.toStringAsFixed(5)}, ${lng.toStringAsFixed(5)}';

    final String? idField = data['id'] as String?;
    return HistoryReportModel(
      id: (idField != null && idField.isNotEmpty) ? idField : docId,
      type: (data['incident_type'] as String?) ?? 'Unknown',
      severity: (data['severity'] as String?) ?? '',
      location: location,
      date: _formatCreatedAt(data['createdAt']),
      status: _statusFromData(data),
      additionalInfo: (data['details'] as String?) ?? '',
      imageUrl: data['photoUrl'] as String?,
      rescuer: data['rescuer_selection'] as String?,
    );
  }

  Stream<HistoryReportListResponse> watchHistoryReports() {
    final query = database.ref(_collection).limitToLast(200);
    return query.onValue.map((event) {
      final root = event.snapshot.value;
      if (root is! Map) {
        return const HistoryReportListResponse(data: []);
      }

      final String filterPhone = (phone ?? '').trim();
      final List<MapEntry<int, HistoryReportModel>> items = [];

      root.forEach((key, value) {
        if (value is! Map) return;
        final map = Map<String, dynamic>.from(value);
        if (filterPhone.isNotEmpty &&
            (map['phone']?.toString().trim() ?? '') != filterPhone) {
          return;
        }
        items.add(
          MapEntry(
            _createdAtMillis(map['createdAt']),
            _docToModel(key.toString(), map),
          ),
        );
      });

      items.sort((a, b) => b.key.compareTo(a.key));
      final models = items.map((e) => e.value).toList();

      return HistoryReportListResponse(
        data: models,
        currentPage: 1,
        totalPages: 1,
        totalCount: models.length,
      );
    });
  }
}
