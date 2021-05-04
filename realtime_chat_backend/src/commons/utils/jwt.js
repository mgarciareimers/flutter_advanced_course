const jwt = require('jsonwebtoken');

const ResponseModel = require('../../models/response_model');

// Method that generates the jwt.
const generateJwt = (uid) => {
    const payload = { uid };

    return new Promise(resolve => {
        jwt.sign(payload, process.env.JWT_KEY, { expiresIn: '24h' }, (error, token) => {
            if (error) {
                resolve(new ResponseModel(false, null, null, error));
            }
    
            resolve(new ResponseModel(true, null, token, null));
        });
    });
}

module.exports = {
    generateJwt,
}