const http = require('http');
const socketIo = require('socket.io');

const { checkJwt } = require('../commons/utils/jwt');
const connectionController = require('../controllers/sockets/connection');

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
        this.io.on('connection', async client => {
            // Check if token is correct.
            const tokenResponse = await checkJwt(client.handshake.headers.token);
            
            if (!tokenResponse.success) {
                return;
            } 
            
            // Update user connection state.
            const connectionResponse = await connectionController.connect(tokenResponse.data._id);

            if (!connectionResponse.success) {
                return;
            }

            console.log('Connected!');

            // Listen disconnection event.
            client.on('disconnect', async () => {
                // Update user connection state.
                const connectionResponse = await connectionController.disconnect(tokenResponse.data._id);

                if (!connectionResponse.success) {
                    return;
                }

                console.log('Disconnected!')
            });
        });
    }
}

module.exports = Socket;