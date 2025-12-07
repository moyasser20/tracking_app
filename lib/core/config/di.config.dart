// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/api/api_client/apply_api_client.dart' as _i901;
import '../../features/auth/api/data_source_impl/auth_remote_data_source_impl.dart'
    as _i758;
import '../../features/auth/data/datasource/auth_remote_data_source.dart'
    as _i24;
import '../../features/auth/data/repo_impl/auth_repo_impl.dart' as _i279;
import '../../features/auth/domain/repo/auth_repo.dart' as _i170;
import '../../features/auth/domain/usecases/apply/apply_driver_usecase.dart'
    as _i712;
import '../../features/auth/domain/usecases/apply/vehicle_usecase.dart'
    as _i770;
import '../../features/auth/domain/usecases/forget_password_usecase.dart'
    as _i948;
import '../../features/auth/domain/usecases/login_usecase/login_usecase.dart'
    as _i517;
import '../../features/auth/domain/usecases/logout_usecase/logout_usecase.dart'
    as _i8;
import '../../features/auth/domain/usecases/reset_password_usecase.dart'
    as _i474;
import '../../features/auth/domain/usecases/verify_code_usecase.dart' as _i294;
import '../../features/auth/presentation/apply/view_model/apply_cubit.dart'
    as _i616;
import '../../features/auth/presentation/forget_password/presentation/viewmodel/forget_password_viewmodel.dart'
    as _i530;
import '../../features/auth/presentation/forget_password/presentation/viewmodel/reset_password_viewmodel.dart'
    as _i508;
import '../../features/auth/presentation/forget_password/presentation/viewmodel/verify_code_viewmodel.dart'
    as _i565;
import '../../features/auth/presentation/login/cubit/login_cubit.dart' as _i179;
import '../../features/homescreen/api/data_sources_impl/home_remote_datasource_impl.dart'
    as _i730;
import '../../features/homescreen/data/data_sources/home_remote_datasource.dart'
    as _i1063;
import '../../features/homescreen/data/repositories/home_repo_impl.dart'
    as _i89;
import '../../features/homescreen/domain/repositories/home_repo.dart' as _i594;
import '../../features/homescreen/domain/use_cases/get_order_usecase.dart'
    as _i234;
import '../../features/homescreen/presentation/viewmodel/home_cubit.dart'
    as _i39;
import '../../features/logout/viewmodel/logout_viewmodel.dart' as _i624;
import '../../features/myorders/api/data_source_impl/data_remote_data_source_impl.dart'
    as _i125;
import '../../features/myorders/data/datasource/my_orders_remote_data_source.dart'
    as _i816;
import '../../features/myorders/data/repo_impl/my_order_repo_impl.dart'
    as _i197;
import '../../features/myorders/domain/repo/my_orders_repo.dart' as _i440;
import '../../features/myorders/domain/usecase/get_order_use_case.dart'
    as _i383;
import '../../features/myorders/presentation/view_model/my_orders_cubit.dart'
    as _i364;
import '../../features/order_details/data/repos/order_details_repo_impl.dart'
    as _i1054;
import '../../features/order_details/domain/repos/order_details_repo.dart'
    as _i428;
import '../../features/order_details/domain/use_cases/update_order_state_usecase.dart'
    as _i1034;
import '../../features/order_details/presentation/cubit/order_details_cubit.dart'
    as _i319;
import '../../features/profile/api/datasource_impl/profile_remote_datasource_impl.dart'
    as _i121;
import '../../features/profile/change_password/presentation/viewmodel/change_password_viewmodel.dart'
    as _i729;
import '../../features/profile/data/datasource/profile_remote_datasource.dart'
    as _i1031;
import '../../features/profile/data/repositories_impl/profile_repository_impl.dart'
    as _i357;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i894;
import '../../features/profile/domain/usecases/change_password_usecase.dart'
    as _i550;
import '../../features/profile/domain/usecases/edit_profile_data_usecase.dart'
    as _i691;
import '../../features/profile/domain/usecases/get_profile_data_usecase.dart'
    as _i68;
import '../../features/profile/domain/usecases/upload_photo_usecase.dart'
    as _i971;
import '../../features/profile/presentation/viewmodel/edit_vehicle_viewmodel.dart'
    as _i239;
import '../../features/profile/presentation/viewmodel/profile_viewmodel.dart'
    as _i351;
import '../../firebase_module.dart' as _i1008;
import '../api/client/api_client.dart' as _i364;
import '../firebase/firebase_service.dart' as _i842;
import 'dio_module/dio_module.dart' as _i484;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseModule = _$FirebaseModule();
    final dioModule = _$DioModule();
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.factory<String>(
      () => dioModule.baseUrl,
      instanceName: 'baseurl',
    );
    gh.lazySingleton<_i842.FirestoreService>(
        () => _i842.FirestoreService(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i361.Dio>(
        () => dioModule.dio(gh<String>(instanceName: 'baseurl')));
    gh.lazySingleton<_i901.ApplyApiClient>(
        () => _i901.ApplyApiClient(gh<_i361.Dio>()));
    gh.factory<_i364.ApiClient>(() => _i364.ApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseurl'),
        ));
    gh.factory<_i319.OrderDetailsCubit>(() => _i319.OrderDetailsCubit(
          gh<_i364.ApiClient>(),
          gh<_i842.FirestoreService>(),
        ));
    gh.factory<_i508.ResetPasswordCubit>(
        () => _i508.ResetPasswordCubit(gh<_i364.ApiClient>()));
    gh.lazySingleton<_i428.OrderDetailsRepo>(
        () => _i1054.OrderDetailsRepoImpl(gh<_i364.ApiClient>()));
    gh.lazySingleton<_i816.MyOrdersRemoteDataSource>(
        () => _i125.MyOrdersRemoteDataSourceImpl(gh<_i364.ApiClient>()));
    gh.lazySingleton<_i1031.ProfileRemoteDatasource>(() =>
        _i121.ProfileRemoteDatasourceImpl(apiClient: gh<_i364.ApiClient>()));
    gh.lazySingleton<_i24.AuthRemoteDatasource>(
        () => _i758.AuthRemoteDatasourceImpl(
              gh<_i901.ApplyApiClient>(),
              gh<_i364.ApiClient>(),
            ));
    gh.lazySingleton<_i1063.HomeRemoteDataSource>(
        () => _i730.HomeRemoteDataSourceImpl(gh<_i364.ApiClient>()));
    gh.factory<_i1034.UpdateOrderStateUseCase>(
        () => _i1034.UpdateOrderStateUseCase(gh<_i428.OrderDetailsRepo>()));
    gh.lazySingleton<_i894.ProfileRepository>(() =>
        _i357.ProfileRepositoryImpl(gh<_i1031.ProfileRemoteDatasource>()));
    gh.factory<_i691.EditProfileDataUseCase>(
        () => _i691.EditProfileDataUseCase(gh<_i894.ProfileRepository>()));
    gh.factory<_i68.GetProfileDataUseCase>(
        () => _i68.GetProfileDataUseCase(gh<_i894.ProfileRepository>()));
    gh.lazySingleton<_i440.MyOrdersRepo>(
        () => _i197.MyOrderRepoImpl(gh<_i816.MyOrdersRemoteDataSource>()));
    gh.lazySingleton<_i594.HomeRepo>(
        () => _i89.HomeRepoImpl(gh<_i1063.HomeRemoteDataSource>()));
    gh.factory<_i971.UploadPhotoUseCase>(
        () => _i971.UploadPhotoUseCase(gh<_i894.ProfileRepository>()));
    gh.lazySingleton<_i170.AuthRepo>(
        () => _i279.AuthRepoImpl(gh<_i24.AuthRemoteDatasource>()));
    gh.lazySingleton<_i550.ChangePasswordUseCases>(
        () => _i550.ChangePasswordUseCases(gh<_i894.ProfileRepository>()));
    gh.factory<_i351.ProfileViewModel>(
        () => _i351.ProfileViewModel(gh<_i68.GetProfileDataUseCase>()));
    gh.factory<_i383.GetOrderUseCase>(
        () => _i383.GetOrderUseCase(gh<_i440.MyOrdersRepo>()));
    gh.factory<_i364.MyOrdersCubit>(
        () => _i364.MyOrdersCubit(gh<_i383.GetOrderUseCase>()));
    gh.factory<_i234.GetOrderUseCase>(
        () => _i234.GetOrderUseCase(gh<_i594.HomeRepo>()));
    gh.lazySingleton<_i712.ApplyDriverUseCase>(
        () => _i712.ApplyDriverUseCase(gh<_i170.AuthRepo>()));
    gh.lazySingleton<_i770.GetVehiclesUseCase>(
        () => _i770.GetVehiclesUseCase(gh<_i170.AuthRepo>()));
    gh.factory<_i616.ApplyCubit>(() => _i616.ApplyCubit(
          gh<_i712.ApplyDriverUseCase>(),
          gh<_i770.GetVehiclesUseCase>(),
        ));
    gh.factory<_i517.LoginUsecase>(
        () => _i517.LoginUsecase(gh<_i170.AuthRepo>()));
    gh.factory<_i729.ChangePasswordViewModel>(() =>
        _i729.ChangePasswordViewModel(gh<_i550.ChangePasswordUseCases>()));
    gh.factory<_i948.ForgetPasswordUseCase>(
        () => _i948.ForgetPasswordUseCase(gh<_i170.AuthRepo>()));
    gh.factory<_i8.LogoutUseCase>(
        () => _i8.LogoutUseCase(gh<_i170.AuthRepo>()));
    gh.factory<_i474.ResetPasswordUseCase>(
        () => _i474.ResetPasswordUseCase(gh<_i170.AuthRepo>()));
    gh.factory<_i294.VerifyCodeUseCase>(
        () => _i294.VerifyCodeUseCase(gh<_i170.AuthRepo>()));
    gh.factory<_i39.HomeCubit>(
        () => _i39.HomeCubit(gh<_i234.GetOrderUseCase>()));
    gh.factory<_i530.ForgetPasswordCubit>(
        () => _i530.ForgetPasswordCubit(gh<_i948.ForgetPasswordUseCase>()));
    gh.factory<_i624.LogoutViewModel>(
        () => _i624.LogoutViewModel(gh<_i8.LogoutUseCase>()));
    gh.factory<_i179.LoginCubit>(
        () => _i179.LoginCubit(loginUsecase: gh<_i517.LoginUsecase>()));
    gh.factory<_i239.EditVehicleViewModel>(() => _i239.EditVehicleViewModel(
          gh<_i691.EditProfileDataUseCase>(),
          gh<_i770.GetVehiclesUseCase>(),
        ));
    gh.factory<_i565.VerifyCodeCubit>(() => _i565.VerifyCodeCubit(
          gh<_i294.VerifyCodeUseCase>(),
          gh<_i948.ForgetPasswordUseCase>(),
        ));
    return this;
  }
}

class _$FirebaseModule extends _i1008.FirebaseModule {}

class _$DioModule extends _i484.DioModule {}
