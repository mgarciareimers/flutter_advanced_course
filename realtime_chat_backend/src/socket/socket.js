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
            
            // Listen disconnection event.
            client.on('disconnect', () => {
                console.log('Disconnected!')
            });
        });
    }
}

module.exports = Socket;