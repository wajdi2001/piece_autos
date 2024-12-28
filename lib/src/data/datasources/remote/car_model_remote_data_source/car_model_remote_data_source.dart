import 'dart:convert';

import '../../../../../core/services/injection_container.dart';
import '../../../../../core/utils/dio_helper.dart';
import '../../../../../core/utils/typedef.dart';

abstract class CarModelRemoteDataSource {
  Future<DataMap> getAllCarModels(DataMap params); // For GET
  Future<void> createOrUpdateCarModel(DataMap params); // For POST
  Future<void> deleteCarModel(String id); // For DELETE
}




class CarModelRemoteDataSourceImpl implements CarModelRemoteDataSource {
  final dioHelper = sl<DioHelper>();
  @override
  Future<DataMap> getAllCarModels(DataMap params) async {
    final response = await dioHelper.getData(
      url: '/api/CarModel/GetAll',
      query: params,
    );
     DataMap res = jsonDecode(response.body);
      return res; // Assuming the response is JSON
  }

  @override
  Future<void> createOrUpdateCarModel(DataMap params) async {
    await dioHelper.postData(
      url: '/api/CarModel/CreateOrUpdate',
      data: params,
      isFormData: true, // For multipart/form-data
    );
  }

  @override
  Future<void> deleteCarModel(String id) async {
    await dioHelper.deleteData(
      url: '/api/CarModel/',
      query: {'id': id},
    );
  }
}

