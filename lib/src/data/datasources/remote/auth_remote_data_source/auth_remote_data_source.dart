import 'package:piece_autos/core/utils/dio_helper.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../../core/utils/typedef.dart';

abstract class AuthRemoteDataSource {
  Future<void> signUp(DataMap params); // For SignUp API call
  Future<void> signIn(DataMap params); // For SignIn API call
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioHelper dioHelper = sl<DioHelper>();

  AuthRemoteDataSourceImpl();

  @override
  Future<void> signUp(DataMap params) async {
    try {
      final response = await dioHelper.postData(
        url: '/api/Auth/SignUp',
        data: params,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: 'Failed to sign up',
          statusCode: response.statusCode ?? 500,
        );
      }
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 500,
      ); // Wrap all exceptions into APIException
    }
  }

  @override
  Future<void> signIn(DataMap params) async {
    try {
      final response = await dioHelper.postData(
        url: '/api/Auth/SignIn',
        data: params,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: 'Failed to sign in',
          statusCode: response.statusCode ?? 500,
        );
      }
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 500,
      ); // Wrap all exceptions into APIException
    }
  }
}
