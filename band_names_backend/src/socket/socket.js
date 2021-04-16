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

            client.on('disconnect', () => {
                console.log('Disconnected!')
            });

            client.on('message', (data) => {
                console.log(`Client ${ data.uuid } sends:`, data);

                this.io.emit('message', data);
            });
        });
    }
}

module.exports = Socket;