const jwt = require('jsonwebtoken');

const User = require('../models/database/user_model');
const ResponseModel = require('../models/response_model');

const validateJwt = async (req, res, next) => {
    const { token } = req.headers;

    if (token === undefined || token === null) {
        return res.status(401).json(new ResponseModel(false, 'No estás autorizado para continuar con esta operación. Por favor, inicia sesión.', null, null));
    }

    try {
        const { uid } = jwt.verify(token, process.env.JWT_KEY);

        const result = await new Promise(resolve => {
            User.findById(uid)
                .then(userDB => resolve(new ResponseModel(true, null, userDB, null)))
                .catch(error => resolve(new ResponseModel(false, null, null, error)));
        });

        if (!result.success || result.data === null) {
            return res.status(401).json(new ResponseModel(false, 'No estás autorizado para continuar con esta operación. Por favor, inicia sesión.', null, result.error));
        }

        req.authUser = result.data;

        next();
    } catch(error) {
        return res.status(401).json(new ResponseModel(false, 'No estás autorizado para continuar con esta operación. Por favor, inicia sesión.', null, error));
    }
}

module.exports = {
    validateJwt,
}