import 'dart:convert';
import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_cleanarchiteture/Core/BaseRepository.dart';
import 'package:project_cleanarchiteture/Core/CustomError.dart';
import 'package:http/http.dart' as http;
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/entities/AdminSignInResponse.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/params/UserLoginInput.dart';

abstract class LoginRemoteDatasource extends BaseRepository {
  Future userLogin({required UserLoginInput input});
}

class LoginRemoteDatasourceImpl extends LoginRemoteDatasource {

  @override
  Future userLogin({required UserLoginInput input}) async {
    try {
      GraphQLClient client = graphqlConfig.clientToQuery(null);
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(
            """
            mutation LoginUser(\$input: loginUserInput!) {
              loginUser(input: \$input) {
                id
                fullName {
                  ar
                  en
                }
              
                email
                profilePic
                role {
                  id
                  name {
                    en
                    ar
                  }
                }
                token
              }
            }
            """,
          ),
          variables: {
            "input": {
              "email": input.email,
              "password": input.password,
              "deviceId": input.deviceId,
              "loginIp": input.loginIp,
            }
          },
        ),
      );

      if (result.hasException) {
        throw Exception(Code.fromJson(
                jsonDecode(result.exception!.graphqlErrors.first.message))
            .message);
      } else {
        final data = result.data!["loginUser"];
        return LoginAdmin.fromJson(data);
        //LoginAdmin.fromJson(jsonDecode(data));
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
