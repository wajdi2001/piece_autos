import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../../core/utils/dio_helper.dart';
import '../../../../../core/utils/typedef.dart';

abstract class ItemRemoteDataSource {
  Future<DataMap> getAllItems(DataMap? params); // For GET
  Future<DataMap> createOrUpdateItem(DataMap params); // For POST
  Future<bool> deleteItem(String id); // For DELETE
}
class ItemRemoteDataSourceImpl implements ItemRemoteDataSource {
  final dioHelper = sl<DioHelper>();

  @override
  Future<DataMap> getAllItems(DataMap? params) async {
    try {
      final response = await dioHelper.getData(
        url: '/api/Item/GetAll',
        query: params ?? {}, // Pass query parameters if provided
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
  Future<DataMap> createOrUpdateItem(DataMap params) async {
    final response = await dioHelper.postData(
      url: '/api/Item/CreateOrUpdate',
      data: params,
      isFormData: true, // Specify if the data should be sent as form-data
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
  Future<bool> deleteItem(String id) async {
    final response = await dioHelper.deleteData(
      url: '/api/Item/',
      query: {'id': id}, // Pass the ID as a query parameter
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
