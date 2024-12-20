//
//
// import 'package:aider_mobile_app/core/auth/data/datasources/user_local_datasource.dart';
// import 'package:aider_mobile_app/core/auth/data/datasources/user_remote_datasource.dart';
// import 'package:aider_mobile_app/core/auth/data/repositories/user_repository.dart';
// import 'package:aider_mobile_app/core/auth/domain/models/user/user_model.dart';
// import 'package:aider_mobile_app/core/errors/failure.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'user_repository_test.mocks.dart';
//
//
// @GenerateMocks([UserRemoteDatasource, UserLocalDatasource])
// void main(){
//   late MockUserRemoteDatasource mockUserRemoteDatasource;
//   late MockUserLocalDatasource mockUserLocalDatasource;
//   late UserRepositoryImpl userRepository;
//   late UserModel user;
//   late Map<String, dynamic> loginRequestBody;
//
//   setUp((){
//     mockUserRemoteDatasource = MockUserRemoteDatasource();
//     mockUserLocalDatasource = MockUserLocalDatasource();
//     userRepository = UserRepositoryImpl(
//       userRemoteDatasource: mockUserRemoteDatasource,
//       userLocalDatasource: mockUserLocalDatasource,
//     );
//     user = const UserModel();
//     loginRequestBody = {'email': 'fiifipius@gmail.com', 'password':'password'};
//   });
//
//
//
//   group('TESTING USER REPOSITORY IMPLEMENTATIONS\n', () {
//     test('Test Login Successful', () async{
//       when(mockUserRemoteDatasource.login(requestBody: loginRequestBody)).thenAnswer((_) async => user);
//
//       /// Act
//       final results = await userRepository.login(requestBody: loginRequestBody);
//       final matcher = Right<Failure, UserModel>(user);
//
//       /// Assert
//       verify(mockUserRemoteDatasource.login(requestBody: loginRequestBody));
//       expect(results, matcher);
//     });
//   });
// }