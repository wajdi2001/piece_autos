import 'package:dartz/dartz.dart';
import 'package:piece_autos/core/errors/exceptions.dart';
import 'package:piece_autos/core/errors/failure.dart';
import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/data/models/brand_model.dart';

import '../../../domain/repositories/brand_repo/brand_repo.dart';
import '../../datasources/remote/brand_remote_data_source/brand_remote_data_source.dart';


class BrandRepositoryImpl implements BrandRepository {
  final BrandRemoteDataSource remoteDataSource;

  BrandRepositoryImpl(this.remoteDataSource);

  @override
  ResultFuture<List<BrandModel>> getAllBrands() async {
    try {
      final result = await remoteDataSource.getAllBrands();
      final List<BrandModel> resultList =[];
      if(result.isNotEmpty && result.containsKey("items"))
      {
        for (var item in result["items"]) {
          resultList.add(BrandModel.fromJson(item));
        }

      }
      return Right(resultList);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e)); // Handle errors
    }  // Catch excepti
    
    catch (e) {
      return Left(ServerFailure(message: e.toString())); // Handle errors
    }
  }

  @override
  ResultFuture<String?> createOrUpdateBrand(DataMap params) async {
    try {
     var res= await remoteDataSource.createOrUpdateBrand(params);
   
     return Right(res["id"]);
   
    }on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } 
    catch (e) {
       return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<bool> deleteBrand(String id) async {
    try {
     var res= await remoteDataSource.deleteBrand(id);
      return Right(res);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } 
    
    catch (e) {
       return Left(ServerFailure(message: e.toString()));
    }
  }
}
