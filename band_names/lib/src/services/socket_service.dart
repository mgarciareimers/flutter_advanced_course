import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  SocketService() {
    this._init();
  }

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  // Initialize socket.
  void _init() {
    this._socket = IO.io('http://localhost:3000', IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());

    // Connection handler.
    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    // Disconnection handler.
    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    this._socket.connect();
  }
}