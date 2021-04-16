const http = require('http');
const socketIo = require('socket.io');

const BandModel = require('../models/band_model');
const BandsModel = require('../models/bands_model');

class Socket {
    constructor(app) {
        this.server = http.createServer(app);
        this.io = socketIo(this.server);
        this.bands = new BandsModel();
        
        this.init();
        this.handleMessages();
    }

    // Initialize variables.
    init() {
        this.bands.addBand(new BandModel('Metallica'));
        this.bands.addBand(new BandModel('Queen'));
        this.bands.addBand(new BandModel('Héroes del Silencio'));
        this.bands.addBand(new BandModel('Bon Jovi'));
    }

    // Sockets messages.
    handleMessages() {
        this.io.on('connection', client => {
            console.log('Connected!');
            
            // Send bands when user is connected.
            client.emit('getBands', this.bands.get());
            
            // Listen disconnection event.
            client.on('disconnect', () => {
                console.log('Disconnected!')
            });

            // Listen 'getBands' event.
            client.on('getBands', (data) => {
                client.emit('getBands', this.bands.get()); // Emit to the client.
            });

            // Listen 'addBand' event.
            client.on('addBand', (data) => {
                this.bands.addBand(new BandModel(data.name));
                this.io.emit('getBands', this.bands.get()); // Emit to everybody.
            });

            // Listen 'voteBand' event.
            client.on('voteBand', (data) => {
                this.bands.voteBand(data.id);
                this.io.emit('getBands', this.bands.get()); // Emit to everybody.
            });

            // Listen 'deleteBand' event.
            client.on('deleteBand', (data) => { 
                this.bands.deleteBand(data.id);
                this.io.emit('getBands', this.bands.get()); // Emit to everybody.
            });

            // Listen 'deleteBandList' event.
            client.on('deleteBands', (data) => { 
                for (let i = 0; i < data.bands.length; i++) {
                    this.bands.deleteBand(data.bands[i].id);
                }

                this.io.emit('getBands', this.bands.get()); // Emit to everybody.
            });
        });
    }
}

module.exports = Socket;