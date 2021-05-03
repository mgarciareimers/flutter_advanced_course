const http = require('http');
const socketIo = require('socket.io');

class Socket {
    constructor(app) {
        this.server = http.createServer(app);
        this.io = socketIo(this.server);
        
        this.init();
        this.handleMessages();
    }

    // Initialize variables.
    init() {

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