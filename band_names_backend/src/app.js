const express = require('express');
const path = require('path');
require('dotenv').config();

// Initialize app.
const app = express();

// Public path.
const publicPath = path.resolve(__dirname, '../public');

// Use static content.
app.use(express.static(publicPath));

app.listen(process.env.PORT, (error) => {
    if (error) {
        throw new Error(error);
    }

    console.log('Server running on PORT', process.env.PORT);
});