import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/auth_local_datasource_provider.dart';
import '../../data/repositories/report_incident_repository_impl.dart';
import '../../data/sources/report_incident_firebase_source.dart';
import '../../domain/repositories/report_incident_repository.dart';
import '../../domain/usecases/send_report_incident_usecase.dart';

const String _rtdbUrl =
    'https://emergency-tracking-syste-95d0c-default-rtdb.asia-southeast1.firebasedatabase.app';

final reportIncidentFirebaseSourceProvider =
    Provider<ReportIncidentFirebaseSource>((ref) {
      return ReportIncidentFirebaseSource(
        database: FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: _rtdbUrl,
        ),
        storage: FirebaseStorage.instance,
        auth: FirebaseAuth.instance,
        authLocalDataSource: ref.read(authLocalDataSourceProvider),
      );
    });

final reportIncidentRepositoryProvider = Provider<ReportIncidentRepository>((
  ref,
) {
  final source = ref.watch(reportIncidentFirebaseSourceProvider);
  return ReportIncidentRepositoryImpl(firebaseSource: source);
});

final sendReportIncidentUseCaseProvider = Provider<SendReportIncidentUseCase>((
  ref,
) {
  final repository = ref.read(reportIncidentRepositoryProvider);
  return SendReportIncidentUseCase(repository);
});
