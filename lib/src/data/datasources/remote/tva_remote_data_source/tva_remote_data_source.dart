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
    final response =
        await dioHelper.getData(url: '/api/Tva/GetAll', query: params);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw APIException(
        message: 'Failed to fetch TVAs',
        statusCode: response.statusCode ?? 500,
      );
    }
  }

  @override
  Future<DataMap> createOrUpdateTVA(DataMap params) async {
    final response =
        await dioHelper.postData(url: '/api/Tva/CreateOrUpdate', data: params);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    }
    throw APIException(
        message: "operation has failed", statusCode: response.statusCode!);
  }

  @override
  Future<bool> deleteTVA(String id) async {
    final result = await dioHelper.deleteData(url: '/api/Tva/$id');
    if (result.statusCode == 200) {
      return true;
    }
    throw APIException(
        message: "operation has failed", statusCode: result.statusCode!);
  }
}
