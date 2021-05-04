/**
 * @author mgarciareimers
 * @description Method that logs a user in by credentials.
 * @param {*} req Request
 * @param {*} res Response. 
 */

 const bcrypt = require('bcryptjs');

 const ResponseModel = require('../../models/response_model');
 const User = require('../../models/database/user_model');
 const { generateJwt } = require('../../commons/utils/jwt');
 
 const refreshToken = async (req, res) => {
    const { authUser } = req;

    if (authUser === undefined || authUser === null) {
        return res.status(401).json(new ResponseModel(false, 'No estás autorizado para continuar con esta operación. Por favor, inicia sesión.', null, null));
    }

    // Generate JWT.
    const tokenResult = await generateJwt(authUser._id);
    
    res.status(200).json(new ResponseModel(true, 'Se ha iniciado sesión con éxito.', { user: authUser, token: tokenResult.data }, null));
 }
 
 module.exports = refreshToken;