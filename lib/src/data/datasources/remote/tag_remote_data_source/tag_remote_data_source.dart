import 'package:piece_autos/core/utils/typedef.dart';
import 'package:piece_autos/core/errors/exceptions.dart';
import 'package:piece_autos/core/services/injection_container.dart';
import 'package:piece_autos/core/utils/dio_helper.dart';
abstract class TagRemoteDataSource {
  Future<DataMap> getAllTags(DataMap? params); // For GET
  Future<DataMap> createOrUpdateTag(DataMap params); // For POST
  Future<bool> deleteTag(String id); // For DELETE
}


class TagRemoteDataSourceImpl implements TagRemoteDataSource {
  final dioHelper = sl<DioHelper>();

  @override
  Future<DataMap> getAllTags(DataMap? params) async {
    try {
      final response = await dioHelper.getData(
        url: '/api/Tag/GetAll',
        query: params ?? {},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }

      throw APIException(
        message: "Failed to fetch tags",
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
  Future<DataMap> createOrUpdateTag(DataMap params) async {
    final response = await dioHelper.postData(
      url: '/api/Tag/CreateOrUpdate',
      data: params,
      isFormData: true,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    }

    throw APIException(
      message: "Failed to create or update tag",
      statusCode: response.statusCode!,
    );
  }

  @override
  Future<bool> deleteTag(String id) async {
    final response = await dioHelper.deleteData(
      url: '/api/Tag/$id',
    );

    if (response.statusCode == 200) {
      return true;
    }

    throw APIException(
      message: "Failed to delete tag",
      statusCode: response.statusCode!,
    );
  }
}
