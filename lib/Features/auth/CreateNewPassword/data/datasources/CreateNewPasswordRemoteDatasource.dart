import 'dart:convert';
import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_cleanarchiteture/Core/BaseRepository.dart';
import 'package:project_cleanarchiteture/Core/CustomError.dart';
import 'package:http/http.dart' as http;

abstract class CreateNewPasswordRemoteDatasource extends BaseRepository {
  Future userCreateNewPassword({
    String? password,
    required String otp,
    required String email,
  });
}

class CreateNewPasswordRemoteDatasourceImpl
    extends CreateNewPasswordRemoteDatasource {
  @override
  Future userCreateNewPassword({
    String? password,
    required String otp,
    required String email,
  }) async {
    try {
      GraphQLClient client = graphqlConfig.clientToQuery(null);
      QueryResult result = await client.mutate(
        MutationOptions(
            document: gql(
              """
              mutation ResetPassword(\$input: resetPasswordInput) {
                resetPassword(input: \$input) {
                  email
                  message
                }
              }
              """,
            ),
            variables: {
              "input": {
                "password": password,
                "otp": otp,
                "email": email,
              }
            }),
      );

      if (result.hasException) {
        throw Exception(Code.fromJson(
          jsonDecode(result.exception!.graphqlErrors.first.message),
        ).message);
      } else {
        // final data = result.data!["createUser"];
        return result.data.toString();
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
