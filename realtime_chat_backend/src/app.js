const express = require('express');
const path = require('path');
require('dotenv').config();

const Socket = require('./socket/socket');

// Initialize app.
const app = express();

// Public path.
const publicPath = path.resolve(__dirname, '../public');

// Use static content.
app.use(express.static(publicPath));

// Define socket.
const socket = new Socket(app);

socket.server.listen(process.env.PORT, (error) => {
    if (error) {
        throw new Error(error);
    }

    console.log('Server running on port', process.env.PORT);
});