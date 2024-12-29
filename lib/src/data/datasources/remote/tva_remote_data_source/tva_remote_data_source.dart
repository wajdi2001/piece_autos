import 'package:piece_autos/core/utils/dio_helper.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../../core/utils/typedef.dart';

abstract class TVARemoteDataSource {
  Future<DataMap> getAllTVAs(DataMap params);
  Future<DataMap> createOrUpdateTVA(DataMap params);
  Future<bool> deleteTVA(String id);
}

class TVARemoteDataSourceImpl implements TVARemoteDataSource {
  final DioHelper dioHelper = sl<DioHelper>();

  @override
  Future<DataMap> getAllTVAs(DataMap params) async {
    try {
      final response = await dioHelper.getData(url: '/api/TVA', query: params);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw APIException(
          message: 'Failed to fetch TVAs',
          statusCode: response.statusCode ?? 500,
        );
      }
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<DataMap> createOrUpdateTVA(DataMap params) async {
    try {
      final response = await dioHelper.postData(url: '/api/TVA', data: params);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw APIException(
          message: 'Failed to create or update TVA',
          statusCode: response.statusCode ?? 500,
        );
      }
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<bool> deleteTVA(String id) async {
    try {
      final response = await dioHelper.deleteData(url: '/api/TVA/$id');
      if (response.statusCode == 200) {
        return true;
      } else {
        throw APIException(
          message: 'Failed to delete TVA',
          statusCode: response.statusCode ?? 500,
        );
      }
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
