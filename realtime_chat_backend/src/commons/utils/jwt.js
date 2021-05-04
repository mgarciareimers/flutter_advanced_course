const jwt = require('jsonwebtoken');

const ResponseModel = require('../../models/response_model');

// Method that generates the jwt.
const generateJwt = (uid) => {
    const payload = { uid: uid };

    return new Promise(resolve => {
        jwt.sign(payload, process.env.JWT_KEY, { expiresIn: '24h' }, (error, token) => {    
            resolve(new ResponseModel(error ? false : true, null, error ? null : token, error ? error : null));
        });
    });
}

module.exports = {
    generateJwt,
}