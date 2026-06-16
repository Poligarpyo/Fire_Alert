import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'auth_local_datasource.dart';

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  final box = Hive.box(authBoxName);
  return AuthLocalDataSource(box);
});

// Watches Hive box for phone changes
final loggedInPhoneProvider = StreamProvider<String?>((ref) async* {
  final box = Hive.box(authBoxName);
  yield box.get(loginKey) as String?;
  yield* box.watch(key: loginKey).map((_) => box.get(loginKey) as String?);
});
