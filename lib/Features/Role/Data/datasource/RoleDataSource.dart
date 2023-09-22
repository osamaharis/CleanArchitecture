import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_cleanarchiteture/Core/BaseRepository.dart';

import '../../../../Core/CustomError.dart';

abstract class RoleDataSource extends BaseRepository
{
  Future RoleLov({required String token});
}

class RoleDataSourceImple extends RoleDataSource
{
  @override
  Future RoleLov({required String token}) async {
    try {
      GraphQLClient client = graphqlConfig.clientToQuery(token);
      QueryResult result = await client.query(QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(
          """
query GetAllRoleslov {
  getAllRoleslov {
    id
    name {
      ar
      en
    }
    active
  }
}
    """,
        ),
        /*  variables: {
            "input": {
              "active": model.active,
              "id": model.name,
              "name": model.name.toJson(),
            }
          }*/
      ));

      if (result.hasException) {
        throw Exception(Code.fromJson(
            jsonDecode(result.exception!.graphqlErrors.first.message))
            .message);
      } else {
        return result.data;
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }

}