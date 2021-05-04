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
 
 const login = async (req, res) => {
    const { email, password } = req.body; 
    
    // Get user.
    const result = await new Promise(resolve => {
        User.findOne({ email: email })
            .then(userDB => resolve(new ResponseModel(true, null, userDB, null)))
            .catch(error => resolve(new ResponseModel(false, error.errors === undefined || error.errors === null || error.errors[Object.keys(error.errors)[0]].properties === undefined || error.errors[Object.keys(error.errors)[0]].properties === null ? 'Se ha producido un error al iniciar sesión.' : error.errors[Object.keys(error.errors)[0]].properties.message, null, error.errors === undefined || error.errors === null || error.errors[Object.keys(error.errors)[0]].properties === undefined || error.errors[Object.keys(error.errors)[0]].properties === null ? error : error.errors[Object.keys(error.errors)[0]])));
    });
    
    if (!result.success) {
        return res.status(result.error.errors === undefined || result.error.errors === null || result.error.errors[Object.keys(result.error.errors)[0]].properties === undefined || result.error.errors[Object.keys(result.error.errors)[0]].properties === null ? 500 : 400).json(result.toJson());
    }
    
    // Validate credentials.
    if (result.data === null || !bcrypt.compareSync(password, result.data.hashedPassword)) {
        return res.status(400).json(new ResponseModel(false, 'Tus credenciales no son correctas.', null, null));
    } 

    // Generate JWT.
    const tokenResult = await generateJwt(result.data.uid);
    
    res.status(200).json(new ResponseModel(true, 'Se ha iniciado sesión con éxito.', { user: result.data, token: tokenResult.data }, null));
 }
 
 module.exports = login;