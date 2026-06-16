// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HistoryReportModel _$HistoryReportModelFromJson(Map<String, dynamic> json) =>
    _HistoryReportModel(
      id: json['id'] as String,
      type: json['type'] as String,
      severity: json['severity'] as String,
      location: json['location'] as String,
      date: json['date'] as String,
      status: json['status'] as String,
      additionalInfo: json['additionalInfo'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      rescuer: json['rescuer'] as String?,
    );

Map<String, dynamic> _$HistoryReportModelToJson(_HistoryReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'severity': instance.severity,
      'location': instance.location,
      'date': instance.date,
      'status': instance.status,
      'additionalInfo': instance.additionalInfo,
      'imageUrl': instance.imageUrl,
      'rescuer': instance.rescuer,
    };

_HistoryReportListResponse _$HistoryReportListResponseFromJson(
  Map<String, dynamic> json,
) => _HistoryReportListResponse(
  data: (json['data'] as List<dynamic>)
      .map((e) => HistoryReportModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$HistoryReportListResponseToJson(
  _HistoryReportListResponse instance,
) => <String, dynamic>{
  'data': instance.data,
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'totalCount': instance.totalCount,
};
