const http = require('http');
const socketIo = require('socket.io');

class Socket {
    constructor(app) {
        this.server = http.createServer(app);
        this.io = socketIo(this.server);

        this.handleMessages();
    }

    // Sockets messages.
    handleMessages() {
        this.io.on('connection', client => {
            console.log('Connected!');
            
            // Listen disconnection event.
            client.on('disconnect', () => {
                console.log('Disconnected!')
            });
            
            // Listen message event.
            client.on('message', (data) => {
                console.log(`Client ${ data.uuid } sends:`, data);

                //this.io.emit('message', data); // Emit to everybody.
                client.broadcast.emit('message', data); // Emit to everybody but the client who sends the data.
            });
        });
    }
}

module.exports = Socket;