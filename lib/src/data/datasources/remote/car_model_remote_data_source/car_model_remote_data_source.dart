
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../../core/utils/dio_helper.dart';
import '../../../../../core/utils/typedef.dart';

abstract class CarModelRemoteDataSource {
  Future<DataMap> getAllCarModels(DataMap? params); // For GET
  Future<DataMap> createOrUpdateCarModel(DataMap params); // For POST
  Future<bool> deleteCarModel(String id); // For DELETE
}




class CarModelRemoteDataSourceImpl implements CarModelRemoteDataSource {
  final dioHelper = sl<DioHelper>();

  @override
  Future<DataMap> getAllCarModels(DataMap? params) async {
    try {
      final response = await dioHelper.getData(
        url: '/api/CarModel/GetAll',
        query: params ?? {},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }

      throw APIException(
        message: "Operation failed",
        statusCode: response.statusCode!,
      );
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<DataMap> createOrUpdateCarModel(DataMap params) async {
    final response = await dioHelper.postData(
      url: '/api/CarModel/CreateOrUpdate',
      data: params,
      isFormData: true,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    }

    throw APIException(
      message: "Operation failed",
      statusCode: response.statusCode!,
    );
  }

  @override
  Future<bool> deleteCarModel(String id) async {
    final response = await dioHelper.deleteData(
      url: '/api/CarModel/',
      query: {'id': id},
    );

    if (response.statusCode == 200) {
      return true;
    }

    throw APIException(
      message: "Operation failed",
      statusCode: response.statusCode!,
    );
  }
}


