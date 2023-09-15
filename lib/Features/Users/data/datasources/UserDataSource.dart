import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_cleanarchiteture/Core/BaseRepository.dart';
import 'package:project_cleanarchiteture/Core/CustomError.dart';

abstract class UserDataSource extends BaseRepository {
  Future UserLov({required String token});
}

class UserDataSourceImplementation extends UserDataSource {
  @override
  Future UserLov({required String token}) async {
    try {
      GraphQLClient client = graphqlConfig.clientToQuery(null);
      QueryResult result = await client.query(
        QueryOptions(
          document: gql(
            """
              query GetAllUserslov {
                getAllUserslov {
                  id
                  email
                  profilePic
                  fullName {
                    en
                    ar
                  }
                }
              }
              """,
          ),
        ),
      );

      if (result.hasException) {
        print("Data in result: ${result.data}");
        throw Exception(
          Code.fromJson(
            jsonDecode(result.exception!.graphqlErrors.first.message),
          ),
        );
      } else {
        return result.data;
      }
    } catch (error) {
      throw Exception(error).toString();
    }
  }
}
