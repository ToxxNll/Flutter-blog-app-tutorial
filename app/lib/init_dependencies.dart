import 'package:app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:app/core/secrets/app_secrets.dart';
import 'package:app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app/features/auth/domain/repository/auth_repository.dart';
import 'package:app/features/auth/domain/usecases/current_user.dart';
import 'package:app/features/auth/domain/usecases/user_login.dart';
import 'package:app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:app/features/blog/domain/repository/blog_repository.dart';
import 'package:app/features/blog/domain/usecases/upload_blog.dart';
import 'package:app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    // DataSource
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(serviceLocator()),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    // Usecases
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    // BLoc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  serviceLocator
    // DataSource
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(serviceLocator()),
    )
    // Usecases
    ..registerFactory(() => UploadBlog(serviceLocator()))
    // BLoc
    ..registerLazySingleton(
      () => BlogBloc(uploadBlog: serviceLocator()),
    );
}
