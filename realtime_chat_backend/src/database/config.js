const mongoose = require('mongoose');

const dbConnection = async() => {
    try {
        await mongoose.connect(process.env.DB_CONNECTION, {
            useNewUrlParser: true, 
            useUnifiedTopology: true,
            useCreateIndex: true,
        });

        console.log('Connection to database completed');
    } catch(error) {
        throw new Error('Error while connection to database');
    }
}

module.exports = {
    dbConnection,

}