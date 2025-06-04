import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as ui_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/data/local/hive_local_datasource.dart';
import 'package:todo/data/remote/firestore_remote_data_source.dart';
import 'package:todo/data/repositories/todo_repository_remote.dart';
import 'package:todo/domain/repositories/todo_repository.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/presentation/app/app.dart';
import 'package:todo/presentation/app/cubit/auth_cubit.dart';

Future<void> main() async {
  GoRouter.optionURLReflectsImperativeAPIs = true;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  ui_auth.FirebaseUIAuth.configureProviders([ui_auth.PhoneAuthProvider()]);

  final localDataSource = HiveLocalDataSource();
  await localDataSource.init();

  final remoteDataSource = FirestoreRemoteDataSource();

  final authCubit = AuthCubit();

  FirebaseAuth.instance.authStateChanges().listen((user) {
    debugPrint('user: $user');
    authCubit.authStateChanged(user: user);
  });

  runApp(
    RepositoryProvider<ToDoRepository>(
      create: (context) => ToDoRepositoryRemote(remoteSource: remoteDataSource),
      child: BlocProvider(create: (context) => authCubit, child: const App()),
    ),
  );
}
