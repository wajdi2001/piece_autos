import 'package:get_it/get_it.dart';
import 'package:piece_autos/core/utils/dio_helper.dart';
import 'package:piece_autos/src/data/datasources/remote/tva_remote_data_source/tva_remote_data_source.dart';
import 'package:piece_autos/src/data/repositories/tva_repo_impl/tva_repo_impl.dart';
import 'package:piece_autos/src/domain/repositories/tva_repo/tva_repo.dart';
import 'package:piece_autos/src/domain/usecases/car_model_use_cases/create_or_update.dart';
import '../../src/data/datasources/remote/auth_remote_data_source/auth_remote_data_source.dart';
import '../../src/data/datasources/remote/brand_remote_data_source/brand_remote_data_source.dart';
import '../../src/data/datasources/remote/car_model_remote_data_source/car_model_remote_data_source.dart';
import '../../src/data/repositories/auth_repo_impl/auth_repo_impl.dart';
import '../../src/data/repositories/brand_repo_impl/brand_repo_impl.dart';
import '../../src/data/repositories/car_repo_impl/car_repo_impl.dart';
import '../../src/domain/repositories/auth_repo/auth_repo.dart';
import '../../src/domain/repositories/brand_repo/brand_repo.dart';
import '../../src/domain/repositories/car_model_repo/car_model_repo.dart';
import '../../src/domain/usecases/auth_usesCases/sign_in_use_case.dart';
import '../../src/domain/usecases/auth_usesCases/sign_up_use_case.dart';
import '../../src/domain/usecases/brand_use_cases/create_or_update_brand.dart';
import '../../src/domain/usecases/brand_use_cases/delete_brand.dart';
import '../../src/domain/usecases/brand_use_cases/get_all_brand.dart';
import '../../src/domain/usecases/car_model_use_cases/delete_car_model.dart';
import '../../src/domain/usecases/car_model_use_cases/ger_all_car_models.dart';
import '../../src/domain/usecases/tva_use_cases/create_or_update.dart';
import '../../src/domain/usecases/tva_use_cases/delete_tva.dart';
import '../../src/domain/usecases/tva_use_cases/get_all_tva.dart';
import '../../src/presentation/controllers/global_bloc/global_bloc.dart';

final sl = GetIt.instance;

void init() async {
  /// Core
  sl.registerLazySingleton<DioHelper>(() {
    DioHelper.init(); // Call the init method of DioHelper
    return DioHelper();
  });

  /// Global Bloc
  sl.registerLazySingleton<GlobalBloc>(() => GlobalBloc());

  /// Auth
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()));

  // Use cases
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl()));
  sl.registerLazySingleton(() => SignInUseCase(repository: sl()));

  /// Brand
  // Data sources
  sl.registerLazySingleton<BrandRemoteDataSource>(
      () => BrandRemoteDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<BrandRepository>(
      () => BrandRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetAllBrandsUseCase(sl()));
  sl.registerLazySingleton(() => CreateOrUpdateBrandUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteBrandUseCase(repository: sl()));



 /// TVA
  // Data sources
  sl.registerLazySingleton<TVARemoteDataSource>(
      () => TVARemoteDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<TVARepository>(
      () => TVARepositoryImpl(remoteDataSource:  sl()));

//useCases
   sl.registerLazySingleton(() => GetAllTVAsUseCase(sl()));
  sl.registerLazySingleton(() => CreateOrUpdateTVAUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTVAUseCase(sl()));


  //CarModel
  // Data sources
   sl.registerLazySingleton<CarModelRemoteDataSource>(() => CarModelRemoteDataSourceImpl());
   // Repositories
   sl.registerLazySingleton<CarModelRepository>(() => CarModelRepositoryImpl( sl()));
 

  // Use Cases
  sl.registerLazySingleton<GetAllCarModelsUseCase>(
      () => GetAllCarModelsUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateOrUpdateCarModelUseCase(repository:  sl()));
  sl.registerLazySingleton(() => DeleteCarModelUseCase(repository:  sl()));
}
