/**
 * @author mgarciareimers
 * @description Method that signs a user up by credentials.
 * @param {*} req Request
 * @param {*} res Response. 
 */

const ResponseModel = require('../../models/response_model');

const signUp = (req, res) => {
    res.status(200).json(new ResponseModel(true, null, {}, null).toJson());
}

module.exports = signUp;