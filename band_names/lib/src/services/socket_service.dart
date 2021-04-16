import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket socket;

  SocketService() {
    this._init();
  }

  void _init() {
    this.socket = IO.io('http://localhost:3000', IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());

    // Dart client
    socket.on('connect', (_) => print('Connected'));
    socket.on('disconnect', (_) => print('Disconnected'));

    this.socket.connect();
  }
}