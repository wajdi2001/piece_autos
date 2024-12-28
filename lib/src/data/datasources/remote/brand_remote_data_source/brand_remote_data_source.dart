import 'dart:convert';

import 'package:piece_autos/core/errors/exceptions.dart';

import '../../../../../core/services/injection_container.dart';
import '../../../../../core/utils/dio_helper.dart';
import '../../../../../core/utils/typedef.dart';

abstract class BrandRemoteDataSource {

  Future<DataMap> getAllBrands(); // For GET
  Future<DataMap> createOrUpdateBrand(DataMap params); // For POST
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
      DataMap res = jsonDecode(response.body);
      return res;
    }
    throw APIException(
        message: "operation has failed", statusCode: response.statusCode!);
  }

  @override
  Future<DataMap> createOrUpdateBrand(DataMap params) async {
    final result = await dioHelper.postData(
      url: '/api/Brand/CreateOrUpdate',
      data: params,
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
      url: '/api/Brand/',
      query: {'id': id},
    );
    if (result.statusCode == 200 ) {
      return true;
    }
    throw APIException(
        message: "operation has failed", statusCode: result.statusCode!);
  }
}
