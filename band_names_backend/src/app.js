const express = require('express');

const app = express();

app.listen(3000, (error) => {
    if (error) {
        throw new Error(error);
    }

    console.log('Server running on PORT', 3000);
});