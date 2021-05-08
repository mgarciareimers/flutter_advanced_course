const jwt = require('jsonwebtoken');

const User = require('../../models/database/user_model');
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

// Method that checks if the jwt is valid.
const checkJwt = async (token = '') => {
    try {
        const { uid } = jwt.verify(token, process.env.JWT_KEY);

        const result = await new Promise(resolve => {
            User.findById(uid)
                .then(userDB => resolve(new ResponseModel(true, null, userDB, null)))
                .catch(error => resolve(new ResponseModel(false, 'No estás autorizado para continuar con esta operación. Por favor, inicia sesión.', null, error)));
        });

        return result;
    } catch(error) {
        return new ResponseModel(false, 'No estás autorizado para continuar con esta operación. Por favor, inicia sesión.', null, error);
    }
}

module.exports = {
    generateJwt,
    checkJwt,
}