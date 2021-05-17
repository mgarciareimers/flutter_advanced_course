/**
 * @author mgarciareimers
 * @description Method that gets the users.
 * @param {*} req Request
 * @param {*} res Response. 
 */

const ResponseModel = require('../../models/response_model');
const User = require('../../models/database/user_model');
const constants = require('../../commons/constants');
 
const getUsers = async (req, res) => {
    let { page, limit } = req.query;

    page = page === undefined || page === null || parseInt(page) < constants.numbers.MIN_PAGE ? constants.numbers.MIN_PAGE : parseInt(page); 
    limit = limit === undefined || limit === null || parseInt(limit) < 1 ? constants.numbers.DEFAULT_LIMIT : parseInt(limit); 
    
    const filter = { 
        _id: { $ne: req.authUser._id } 
    };

    // Get users.
    const getUsersResult = await new Promise(resolve => {
        User.find(filter)
            .sort({ isOnline: -1 })
            .skip(limit * (page - 1))
            .limit(limit)
            .then(usersDB => resolve(new ResponseModel(true, null, usersDB, null)))
            .catch(error => resolve(new ResponseModel(false, error.errors === undefined || error.errors === null || error.errors[Object.keys(error.errors)[0]].properties === undefined || error.errors[Object.keys(error.errors)[0]].properties === null ? 'Se ha producido un error al recuperar los usuarios' : error.errors[Object.keys(error.errors)[0]].properties.message, null, error.errors === undefined || error.errors === null || error.errors[Object.keys(error.errors)[0]].properties === undefined || error.errors[Object.keys(error.errors)[0]].properties === null ? error : error.errors[Object.keys(error.errors)[0]])));
    });
     
    if (!getUsersResult.success) {
        return res.status(getUsersResult.error.errors === undefined || getUsersResult.error.errors === null || getUsersResult.error.errors[Object.keys(getUsersResult.error.errors)[0]].properties === undefined || getUsersResult.error.errors[Object.keys(getUsersResult.error.errors)[0]].properties === null ? 500 : 400).json(getUsersResult.toJson());
    }

    // Count users.
    const countTotalUsersResult = await new Promise(resolve => {
        User.countDocuments(filter)
            .then(count => resolve(new ResponseModel(true, null, count, null)))
            .catch(error => resolve(new ResponseModel(false, error.errors === undefined || error.errors === null || error.errors[Object.keys(error.errors)[0]].properties === undefined || error.errors[Object.keys(error.errors)[0]].properties === null ? 'Se ha producido un error al recuperar los usuarios' : error.errors[Object.keys(error.errors)[0]].properties.message, null, error.errors === undefined || error.errors === null || error.errors[Object.keys(error.errors)[0]].properties === undefined || error.errors[Object.keys(error.errors)[0]].properties === null ? error : error.errors[Object.keys(error.errors)[0]])));
    });
     
    if (!countTotalUsersResult.success) {
        return res.status(countTotalUsersResult.error.errors === undefined || countTotalUsersResult.error.errors === null || countTotalUsersResult.error.errors[Object.keys(countTotalUsersResult.error.errors)[0]].properties === undefined || countTotalUsersResult.error.errors[Object.keys(countTotalUsersResult.error.errors)[0]].properties === null ? 500 : 400).json(countTotalUsersResult.toJson());
    }

    res.status(200).json(new ResponseModel(true, 'Se han recuperado los usuarios con éxito', { users: getUsersResult.data, total: countTotalUsersResult.data }, null));
}
 
module.exports = getUsers;