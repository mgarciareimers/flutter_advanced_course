import 'package:band_names/src/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SocketService socketService = Provider.of<SocketService>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Band Names', style: TextStyle(color: Colors.black87)),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(socketService.serverStatus.toString()),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          socketService.socket.emit('message', { 'uuid': DateTime.now().millisecond, 'name': 'Flutter', 'message': 'Hi, I am sending from Flutter' });
        },
        child: Icon(Icons.message),
        elevation: 1,
      ),
    );
  }
}

