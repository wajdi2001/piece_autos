import 'package:piece_autos/core/utils/dio_helper.dart';

import '../../../../../core/services/injection_container.dart';
import '../../../../../core/utils/typedef.dart';

abstract class AuthRemoteDataSource {
  Future<void> signUp(DataMap params); // For SignUp API call
  Future<void> signIn(DataMap params); // For SignIn API call
}


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
 
final dioHelper = sl<DioHelper>();
  AuthRemoteDataSourceImpl();

  @override
  Future<void> signUp(DataMap params) async {
    final response = await dioHelper.postData(url:'/api/Auth/SignUp', data: params);
    if (response.statusCode != 200) {
      throw Exception('Failed to sign up');
    }
  }

  @override
  Future<void> signIn(DataMap params) async {
    final response = await dioHelper.postData(url:'/api/Auth/SignIn', data: params);
    if (response.statusCode != 200) {
      throw Exception('Failed to sign in');
    }
  }
}
