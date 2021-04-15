const express = require('express');
const path = require('path');

// Initialize app.
const app = express();

// Public path.
const publicPath = path.resolve(__dirname, '../public');

// Use static content.
app.use(express.static(publicPath));

app.listen(3000, (error) => {
    if (error) {
        throw new Error(error);
    }

    console.log('Server running on PORT', 3000);
});