import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobiledev/api/const_api.dart';

import 'dart:convert' as convert;

import 'package:mobiledev/api/http_helper.dart';
import 'package:mobiledev/model/success_token.dart';
import 'package:mobiledev/model/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  void registerUser({required Map<String, dynamic> data}) {
    emit(RegisterLodinState());

    Httplar.httpPost(path: REGISTERUSER, data: data).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        print(jsonResponse);
        emit(RegisterStateGood(model: UserModel.fromJson(jsonResponse)));
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        print(jsonResponse);
        emit(ErrorState(errorModel: ApiResponse.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(RegisterStateBad());
    });
  }

  void login({required Map<String, dynamic> data, required String path}) {
    emit(LoginLoadingState());
    Httplar.httpPost(path: path, data: data).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        print(jsonResponse);
        emit(LoginStateGood(model: ApiResponse.fromJson(jsonResponse)));
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ApiResponse.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(LoginStateBad());
    });
  }

  // void login({required Map<String, dynamic> data}) {
  //   emit(LoginLoadingState());
  //   Httplar.httpPost(path: LOGINUSER, data: data).then((value) {
  //     if (value.statusCode == 200) {
  //       print(value.body);
  //       var jsonResponse =
  //           convert.jsonDecode(value.body) as Map<String, dynamic>;
  //       print(jsonResponse);
  //       // emit(LoginStateGood(model: ApiResponse.fromJson(jsonResponse)));
  //     } else if (value.statusCode == 400 ||
  //         value.statusCode == 401 ||
  //         value.statusCode == 404) {
  //       var jsonResponse =
  //           convert.jsonDecode(value.body) as Map<String, dynamic>;
  //       print(jsonResponse);
  //       // emit(ErrorState(errorModel: ApiResponse.fromJson(jsonResponse)));
  //     }
  //   }).catchError((e) {
  //     print(e.toString());
  //     emit(LoginStateBad());
  //   });
  // }
}
