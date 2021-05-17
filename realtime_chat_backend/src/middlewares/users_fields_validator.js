const { check } = require('express-validator');
const fieldsValidationErrorChecker = require('./fields_validation_error_checker');
const { validateJwt } = require('./jwt_validator');

// Method that validates the parameters to refresh the token.
const validateGetUsers = (req, res, next) => {
    return [
        validateJwt,
    ];
}

module.exports = {
    validateGetUsers,
}