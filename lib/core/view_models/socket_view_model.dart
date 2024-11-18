

import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:aider_mobile_app/core/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/domain/models/user/user_model.dart';
import '../services/socket_service.dart';

class SocketViewModel extends ChangeNotifier{

  void connect(BuildContext context, String userExternalId) {
    SocketService().connect(userExternalId, (data){
      ZLoggerService.logOnInfo('SOCKET CONNECTED....');
      SocketService().on('fetchUser', (data){
        ZLoggerService.logOnInfo('FETCHING USER \n $data');
        if(data != null){
          if(context.mounted) context.read<UserViewModel>().setUser = UserModel.fromJson(data);
        }
      });
    });
  }

  void disconnect() {
    SocketService().disconnect();
    SocketService().onDisconnect();
  }


  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}