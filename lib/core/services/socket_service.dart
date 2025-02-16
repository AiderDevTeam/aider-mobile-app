// import 'package:aider_mobile_app/core/services/logger_service.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// import 'remote_config_service.dart';

// class SocketService {
//   static final SocketService _socketService = SocketService._internal();
//   factory SocketService() => _socketService;
//   SocketService._internal();

//   static late IO.Socket _socket;

//   IO.Socket get getSocket => _socket;

//   void connect(String userExternalId, dynamic Function(dynamic) handler) {
//     _socket = IO.io(
//       RemoteConfigService.getRemoteData.socketBaseUrl,
//       IO.OptionBuilder().setTransports(['websocket']).setQuery({
//         'userExternalId': userExternalId,
//         'externalIdType': 'user',
//       }).setExtraHeaders({
//         'authorization': RemoteConfigService.getRemoteData.socketKey
//       }).build(),
//     );

//     _socket.onConnect(handler);
//   }

//   void onReconnecting(dynamic Function(dynamic) handler) {
//     _socket.onReconnecting(handler);
//   }

//   bool get isConnected => _socket.connected;

//   void emit(String event, [dynamic data]) {
//     _socket.emit(event, data);
//   }

//   void on(String event, dynamic Function(dynamic) handler) {
//     _socket.on(event, handler);
//   }

//   void once(String event, dynamic Function(dynamic) handler) {
//     _socket.once(event, handler);
//   }

//   void off(String event) {
//     _socket.off(event, (data) => ZLoggerService.logOnInfo('OFF LISTENING....'));
//   }

//   void disconnect() {
//     _socket.disconnect();
//   }

//   void onDisconnect() {
//     _socket.onDisconnect(
//         (data) => ZLoggerService.logOnInfo('SOCKET DISCONNECTED....'));
//   }
// }
