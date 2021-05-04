/**
 * @author mgarciareimers
 * @description Method that signs a user up by credentials.
 * @param {*} req Request
 * @param {*} res Response. 
 */

const bcrypt = require('bcryptjs');

const ResponseModel = require('../../models/response_model');
const User = require('../../models/database/user_model');

const signUp = async (req, res) => {
    const { name, email, password, isOnline } = req.body; 

    
    // Hash password.
    const hashedPassword = bcrypt.hashSync(password, bcrypt.genSaltSync());

    const user = new User({ name, email, hashedPassword, isOnline });
    
    const result = await new Promise(resolve => {
        user.save()
            .then(userDB => resolve(new ResponseModel(true, null, userDB, null)))
            .catch(error => resolve(new ResponseModel(false, error.errors === undefined || error.errors === null || error.errors[Object.keys(error.errors)[0]].properties === undefined || error.errors[Object.keys(error.errors)[0]].properties === null ? 'Se ha producido un error al crear la cuenta.' : error.errors[Object.keys(error.errors)[0]].properties.message, null, error.errors === undefined || error.errors === null || error.errors[Object.keys(error.errors)[0]].properties === undefined || error.errors[Object.keys(error.errors)[0]].properties === null ? error : error.errors[Object.keys(error.errors)[0]])));
    });
    
    if (!result.success) {
        return res.status(result.error.errors === undefined || result.error.errors === null || result.error.errors[Object.keys(result.error.errors)[0]].properties === undefined || result.error.errors[Object.keys(result.error.errors)[0]].properties === null ? 500 : 400).json(result.toJson());
    }

    res.status(200).json(result.toJson());
}

module.exports = signUp;