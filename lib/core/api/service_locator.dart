import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tharadtech/core/api/api_service.dart';
import 'package:tharadtech/core/api/dio_consumer.dart';
import 'package:tharadtech/features/Auth/data/data_source/remote_data_source.dart';
import 'package:tharadtech/features/Auth/data/repo/repo_register_implementation.dart';
import 'package:tharadtech/features/Auth/domain/repo/repo_register.dart';
import 'package:tharadtech/features/Auth/domain/usecase/log_in_use_case.dart';
import 'package:tharadtech/features/Auth/domain/usecase/opt_use_case.dart';
import 'package:tharadtech/features/Auth/domain/usecase/register_use_case.dart';
import 'package:tharadtech/features/Auth/presentation/manage/login/login_cubit.dart';
import 'package:tharadtech/features/Auth/presentation/manage/otp/otp_cubit.dart';
import 'package:tharadtech/features/Auth/presentation/manage/register/register_cubit.dart';
import 'package:tharadtech/features/Profile/Presentation/manage/profile_cubit.dart';
import 'package:tharadtech/features/Profile/data/data_source/local_data_source_profile.dart';
import 'package:tharadtech/features/Profile/data/data_source/remote_data_source_profile.dart';
import 'package:tharadtech/features/Profile/data/repo/repo_profile_implementation.dart';
import 'package:tharadtech/features/Profile/domain/repo/base_repo_profile.dart';
import 'package:tharadtech/features/Profile/domain/usecase/get_profile_use_case.dart';
import 'package:tharadtech/features/Profile/domain/usecase/update_profile_use_case.dart';

final getit = GetIt.instance;

Future<void> setupServiceLocator() async {
  getit.registerLazySingleton<Dio>(() => Dio());

  getit.registerLazySingleton<ApiService>(
    () => DioConsumer(dio: getit.get<Dio>()),
  );
//todo register services
  getit.registerLazySingleton<RemoteDataSourceRegister>(
    () =>
        RemoteDataSourceRegisterImplementation(apiService: getit<ApiService>()),
  );

  getit.registerLazySingleton<RepoRegister>(
    () => RepoRegisterImplementation(
      remoteDataSourceRegister: getit<RemoteDataSourceRegister>(),
    ),
  );
//todo useCase and cubit for Register
  getit.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getit<RepoRegister>()),
  );

  getit.registerFactory<RegisterCubit>(
    () => RegisterCubit(getit<RegisterUseCase>()),
  );
//todo useCase and cubit for otp
  getit.registerLazySingleton<OtpUseCase>(
        () => OtpUseCase(repoRegister:  getit<RepoRegister>()),
  );

  getit.registerFactory<OtpCubit>(
        () => OtpCubit(getit<OtpUseCase>()),
  );
  //todo useCase and Cubit for LogIn
  getit.registerLazySingleton<LogInUseCase>(
        () => LogInUseCase(repoRegister:  getit<RepoRegister>()),
  );

  getit.registerFactory<LoginCubit>(
        () => LoginCubit(getit<LogInUseCase>()),
  );
  //todo services for profile
  getit.registerLazySingleton<RemoteDataSourceProfile>(
        () =>
            RemoteDataSourceProfileImplementation(apiService: getit<ApiService>()),
  );
  getit.registerLazySingleton<ProfileLocalDataSource>(
        () =>
        ProfileLocalDataSourceImpl(),
  );
  getit.registerLazySingleton<BaseRepoProfile>(
        () => RepoProfileImplementation(
      remoteDataSourceProfile: getit<RemoteDataSourceProfile>(),
          localDataSource: getit<ProfileLocalDataSource>()

    ),
  );
  //todo useCase and cubit for get Profile
  getit.registerLazySingleton<GetProfileUseCase>(
        () => GetProfileUseCase(baseRepoProfile:  getit<BaseRepoProfile>()),
  );
  getit.registerLazySingleton<UpdateProfileUseCase>(
        () => UpdateProfileUseCase(baseRepoProfile:  getit<BaseRepoProfile>()),
  );
  getit.registerFactory<ProfileCubit>(
        () => ProfileCubit(getit<GetProfileUseCase>(),getit<UpdateProfileUseCase>()),
  );
}
