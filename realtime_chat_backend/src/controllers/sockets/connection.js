/**
 * @author mgarciareimers
 * @description Method that updates the state of a user.
 * @param {*} uid Uid of the user.
 */

 const ResponseModel = require('../../models/response_model');
 const User = require('../../models/database/user_model');

 // Method that sets isOnline to true.
const connect = async(uid = '') => updateConnection(uid, true);

 // Method that sets isOnline to false.
const disconnect = (uid = '') => updateConnection(uid, false);

 // Method that update isOnline value.
const updateConnection = async (uid = '', isOnline = false) => {
    const userResult = await new Promise(resolve => {
        User.findById(uid)
            .then(userDB => resolve(new ResponseModel(true, null, userDB, null)))
            .catch(error => resolve(new ResponseModel(false, 'No estás autorizado para continuar con esta operación. Por favor, inicia sesión.', null, error)));
    });

    if (!userResult.success) {
        return userResult;
    }

    userResult.data.isOnline = isOnline;

    const updateResult = await new Promise(resolve => {
        userResult.data.save()
            .then(userDB => resolve(new ResponseModel(true, null, userDB, null)))
            .catch(error => resolve(new ResponseModel(false, 'No estás autorizado para continuar con esta operación. Por favor, inicia sesión.', null, error)));
    });

    return updateResult;
} 

module.exports = {
    connect,
    disconnect,
}