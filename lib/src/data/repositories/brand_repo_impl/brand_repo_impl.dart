
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:piece_autos/core/errors/exceptions.dart';
import 'package:piece_autos/core/errors/failure.dart';
import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/src/data/models/brand_model.dart';
import 'package:piece_autos/src/presentation/controllers/dashboard/dashboard_state.dart';

import '../../../domain/repositories/brand_repo/brand_repo.dart';
import '../../datasources/remote/brand_remote_data_source/brand_remote_data_source.dart';

class BrandRepositoryImpl implements BrandRepository {
  final BrandRemoteDataSource remoteDataSource;

  BrandRepositoryImpl(this.remoteDataSource);

  @override
  ResultFuture<List<BrandModel>> getAllBrands() async {
    try {
      final result = await remoteDataSource.getAllBrands();
      final List<BrandModel> resultList = [];
      if (result.isNotEmpty && result.containsKey("items")) {
        for (var item in result["items"]) {
          resultList.add(BrandModel.fromJson(item));
        }
      }
      return Right(resultList);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e)); // Handle errors
    } // Catch excepti

    catch (e) {
      return Left(ServerFailure(message: e.toString())); // Handle errors
    }
  }

  @override
  ResultFuture<BrandModel?> createOrUpdateBrand(DataMap params) async {
    try {
      if (!params.containsKey("name")) {
        return Left(ValidationFailure(message: "Name is required"));
      }
      FormData formData = FormData.fromMap({
        "id": params['id'],
        "name": params['name'],
      });

      if (params.containsKey("image")) {
        final file = params['image'] as ImageData;
        formData.files.add(
          MapEntry(
            "image",
            MultipartFile.fromBytes(
              file.data, // File bytes
              filename: file.name, // File name with extension
              contentType:
                  MediaType('image', file.extension), // Set the MIME type
            ),
          ),
        );
      }

      var res = await remoteDataSource.createOrUpdateBrand(formData);
      if (res.isNotEmpty) {
        return Right(BrandModel.fromJson(res));
      }
      return Left(InvalidResponseFailure());
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<bool> deleteBrand(String id) async {
    try {
      var res = await remoteDataSource.deleteBrand(id);
      return Right(res);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
