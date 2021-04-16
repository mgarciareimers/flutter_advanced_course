import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Services.
import 'package:band_names/src/services/socket_service.dart';

// Models.
import 'package:band_names/src/models/band_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BandModel> bands;

  bool typeBandNameError;

  SocketService socketService;

  @override
  void initState() {
    this.bands = bands = [
      new BandModel(id: '1', name: 'Metallica', votes: 0),
      new BandModel(id: '2', name: 'Queen', votes: 0),
      new BandModel(id: '3', name: 'Héroes del Silencio', votes: 0),
      new BandModel(id: '4', name: 'Bon Jovi', votes: 0),
    ];

    this.typeBandNameError = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this._init();

    return Scaffold(
      appBar: AppBar(
        title: Text('Band Names', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => this.socketService.serverStatus == ServerStatus.Online ? this.socketService.socket.disconnect() : this.socketService.socket.connect(),
              child: Icon(
                this.socketService.serverStatus == ServerStatus.Online ? Icons.check_circle : Icons.offline_bolt,
                color: this.socketService.serverStatus == ServerStatus.Online ? Colors.blue : Colors.red,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: this.bands.length,
        itemBuilder: (BuildContext context, int index) => this._createBandTile(index, this.bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: () => this._onAddBandFloatingActionButtonClicked(),
      ),
    );
  }

  // Method that initializes the variables.
  void _init() {
    this.socketService = Provider.of<SocketService>(context);
  }

  // Method that creates the band list tile.
  Widget _createBandTile(int index, BandModel band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) => this._onDeleteBand(index, band),
      background: Container(
        color: Colors.red.withOpacity(0.1),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Icon(Icons.delete, color: Colors.red),
            SizedBox(width: 8),
            Text('Delete Band', style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name, style: TextStyle(color: Colors.black)),
        trailing: Text(band.votes.toString(), style: TextStyle(fontSize: 16)),
        onTap: () => print(band.name),
      ),
    );
  }

  // Method that is called when the user clicks the add floating button.
  void _onAddBandFloatingActionButtonClicked() {
    this.typeBandNameError = false;
    this._showNewBandButtonClicked();
  }

  // Method that is called when the user clicks the add floating button.
  void _showNewBandButtonClicked() async {
    TextEditingController textEditingController = new TextEditingController();

    if (!Platform.isIOS) {
      return await showDialog(
        context: this.context,
        builder: (context) => AlertDialog(
          title: Text('New Band Name:'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textEditingController,
              ),
              SizedBox(height: this.typeBandNameError ? 8 : 0,),
              this.typeBandNameError ?
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Type a band name error', style: TextStyle(color: Colors.red, fontSize: 12, fontStyle: FontStyle.italic))
              ) : Container(),
            ],
          ),
          actions: [
            MaterialButton(
              child: Text('Add'),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => this._onAddButtonClicked(textEditingController.text),
            ),
          ],
        ),
      );
    }

    showCupertinoDialog(
      context: this.context,
      builder: (context) => CupertinoAlertDialog(
          title: Text('New Band Name:'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8),
              CupertinoTextField(
                controller: textEditingController,
              ),
              SizedBox(height: this.typeBandNameError ? 8 : 0,),
              this.typeBandNameError ?
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Type a band name error', style: TextStyle(color: Colors.red, fontSize: 12, fontStyle: FontStyle.italic))
              ) : Container(),
            ],
          ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Add'),
            onPressed: () => this._onAddButtonClicked(textEditingController.text),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(this.context),
          ),
        ],
      )
    );

  }

  // Method that is called when the user clicks the add button.
  void _onAddButtonClicked(String name) {
    if (name == null || name.length <= 1) {
      this.typeBandNameError = true;
      Navigator.pop(this.context);
      this._showNewBandButtonClicked();
      return;
    }

    this.bands.add(new BandModel(id: DateTime.now().toString(), name: name, votes: 0));
    Navigator.pop(this.context);
    this.setState(() {});
  }

  // Method that is called when the user deletes an element from the list.
  void _onDeleteBand(int index, BandModel band) {
    print('Deleting band...');
  }
}
