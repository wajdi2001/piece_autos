import 'package:dio/dio.dart';
import 'package:piece_autos/core/errors/exceptions.dart';

import '../../../../../core/services/injection_container.dart';
import '../../../../../core/utils/dio_helper.dart';
import '../../../../../core/utils/typedef.dart';

abstract class BrandRemoteDataSource {
  Future<DataMap> getAllBrands(); // For GET
  Future<DataMap> createOrUpdateBrand(FormData formData); // For POST
  Future<bool> deleteBrand(String id); // For DELETE
}

class BrandRemoteDataSourceImpl implements BrandRemoteDataSource {
  final dioHelper = sl<DioHelper>();
  @override
  Future<DataMap> getAllBrands() async {
    final response = await dioHelper.getData(
      url: '/api/Brand/GetAll',
    );
    if (response.statusCode == 200) {
      return response.data;
    }
    throw APIException(
        message: "operation has failed", statusCode: response.statusCode!);
  }

  @override
  Future<DataMap> createOrUpdateBrand(FormData params) async {
    final result = await dioHelper.postData(
      url: '/api/Brand/CreateOrUpdate',
      formData: params,
      isFormData: true, // For multipart/form-data
    );
    if (result.statusCode == 200 || result.statusCode == 201) {
      return result.data;
    }
    throw APIException(
        message: "operation has failed", statusCode: result.statusCode!);
  }

  @override
  Future<bool> deleteBrand(String id) async {
    var result = await dioHelper.deleteData(
      url: '/api/Brand/$id', // Use the id in the URL path
    );
    if (result.statusCode == 200) {
      return true;
    }
    throw APIException(
        message: "operation has failed", statusCode: result.statusCode!);
  }
}
