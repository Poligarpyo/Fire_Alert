import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/storage/auth_local_datasource_provider.dart';
import '../../data/repositories/history_report_repository_impl.dart';
import '../../data/sources/history_report_remote_source.dart';
import '../../domain/repositories/history_report_repository.dart';
import '../../domain/usecases/get_history_reports_usecase.dart';
import '../controllers/history_report_notifier.dart';
import '../controllers/history_report_state.dart';

const String _rtdbUrl =
    'https://emergency-tracking-syste-95d0c-default-rtdb.asia-southeast1.firebasedatabase.app';

final historyReportRemoteSourceProvider = Provider<HistoryReportRemoteSource>((
  ref,
) {
  final phone = ref.watch(loggedInPhoneProvider).value ?? '';
  return HistoryReportRemoteSource(
    database: FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: _rtdbUrl,
    ),
    phone: phone,
  );
});

final historyReportRepositoryProvider = Provider<HistoryReportRepository>((
  ref,
) {
  final remoteSource = ref.watch(historyReportRemoteSourceProvider);
  return HistoryReportRepositoryImpl(remoteSource);
});

final getHistoryReportsUsecaseProvider = Provider<GetHistoryReportsUsecase>((
  ref,
) {
  final repository = ref.watch(
    historyReportRepositoryProvider,
  ); // watch not read
  return GetHistoryReportsUsecase(repository);
});

final historyReportNotifierProvider =
    StateNotifierProvider<HistoryReportNotifier, HistoryReportState>((ref) {
      final usecase = ref.watch(
        getHistoryReportsUsecaseProvider,
      ); // watch not read
      return HistoryReportNotifier(usecase)..watchReports();
    });
