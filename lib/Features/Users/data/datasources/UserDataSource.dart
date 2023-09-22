import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_cleanarchiteture/Core/BaseRepository.dart';
import 'package:project_cleanarchiteture/Core/CustomError.dart';

abstract class UserDataSource extends BaseRepository {
  Future UserLov({required String token});
  Future UserById({required String token, required int id});
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

  @override
  Future UserById({required String token, required int id}) async {
    try {
      GraphQLClient client = graphqlConfig.clientToQuery(token);
      QueryResult result = await client.query(QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(
            """
query GetUserById(\$getUserByIdId: Int!) {
  getUserById(id: \$getUserByIdId) {
    id
    email
    fullName {
      
      ar
      en
    }
    profilePic
    phoneNumber
    address {
      ar
      en
    }
    deviceId
    active
    status
    gender
    role {
      id
      name {
        ar
        en
      }
     
    }
  }
}
    """,
          ),
          variables: {"getUserByIdId": id}));

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

    //     try {
//       GraphQLClient client = graphqlConfig.clientToQuery(token);
//       QueryResult result = await client.query(QueryOptions(
//         fetchPolicy: FetchPolicy.noCache,
//         document: gql(
//           """
// query GetAllRoleslov {
//   getAllRoleslov {
//     id
//     name {
//       ar
//       en
//     }
//     active
//   }
// }
//     """,
//         ),
//         /*  variables: {
//             "input": {
//               "active": model.active,
//               "id": model.name,
//               "name": model.name.toJson(),
//             }
//           }*/
//       ));
//
//       if (result.hasException) {
//         throw Exception(Code.fromJson(
//                 jsonDecode(result.exception!.graphqlErrors.first.message))
//             .message);
//       } else {
//         return result.data;
//       }
//     } catch (error) {
//       throw Exception(error.toString());
//     }
  }
}
