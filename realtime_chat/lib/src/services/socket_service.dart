import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// Services.
import 'package:app/src/services/auth_service.dart';

// Constants.
import 'package:app/src/commons/constants/backend.dart';
import 'package:app/src/commons/constants/strings.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  // Connect socket.
  void connect() async {
    final String token = await AuthService.getJWT();

    this._socket = IO.io(
      Backend.BASE_URL,
      IO.OptionBuilder().setTransports(['websocket'])
          .disableAutoConnect()
          .enableForceNew()
          .setExtraHeaders({ Strings.TOKEN : token })
          .build()
    );

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

  // Disconnect socket.
  void disconnect() {
    this._socket.disconnect();
  }
}