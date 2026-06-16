import 'package:another_telephony/telephony.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../../core/provider/connectivity_provider.dart';
import '../../../../core/storage/auth_local_datasource_provider.dart';
 
import '../../data/repositories/offline_sms_repository_impl.dart';
import '../../data/sources/offline_sms_remote_source.dart';
import '../../domain/repositories/offline_sms_repository.dart';
import '../../domain/usecases/set_offline_sms_usecase.dart'; 

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final offlineSmsRemoteSourceProvider = Provider<OfflineSmsRemoteSource>((ref) {
  final FirebaseFirestore firestore = FirebaseFirestore.instance; // Initialize this properly
  final FirebaseAuth auth = FirebaseAuth.instance; // Initialize this properly
  final authLocal = ref.read(authLocalDataSourceProvider);
  // final userRepo = ref.read(userRepositoryProvider); // 👈 add this
  return OfflineSmsRemoteSource(
    firestore: firestore,
    auth: auth,
    authLocalDataSource: authLocal,
    
  );
});

final offlineSmsRepositoryProvider = Provider<OfflineSmsRepository>((ref) {
  final connectivity = ref.watch(connectivityProvider);
  final remoteSource = ref.watch(offlineSmsRemoteSourceProvider);
  final database = ref.watch(appDatabaseProvider);

  return OfflineSmsRepositoryImpl(
    database: database,
    remoteDataSource: remoteSource,
    connectivity: connectivity,
    telephony: Telephony.instance, // ✅ FIXED
  );
});

final sendOfflineSmsUseCaseProvider = Provider<SendOfflineSmsUseCase>((ref) {
  final repository = ref.read(offlineSmsRepositoryProvider);
  return SendOfflineSmsUseCase(repository);
});
