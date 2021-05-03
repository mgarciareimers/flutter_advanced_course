const express = require('express');
const path = require('path');
require('dotenv').config();

const Socket = require('./socket/socket');
const { dbConnection } = require('./database/config');

// Initialize app.
const app = express();

// Body parsing.
app.use(express.json());

// Database config.
dbConnection();

// Public path.
const publicPath = path.resolve(__dirname, '../public');

// Use static content.
app.use(express.static(publicPath));

// Define socket.
const socket = new Socket(app);

// Define routes.
app.use('/', require('./routes'));

socket.server.listen(process.env.PORT, (error) => {
    if (error) {
        throw new Error(error);
    }

    console.log('Server running on port', process.env.PORT);
});