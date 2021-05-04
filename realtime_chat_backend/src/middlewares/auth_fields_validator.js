const { check } = require('express-validator');
const fieldsValidationErrorChecker = require('./fields_validation_error_checker');
const { validateJwt } = require('./jwt_validator');

// Method that validates the request parameters in login.
const validateLogin = (req, res, next) => {
    return [
        check('password', 'Debes añadir una contraseña con una longitud mínima de 8 caracteres.').isLength({ min: 8 }),
        check('email', 'Debes añadir un email de formato correcto.').isEmail(),
        fieldsValidationErrorChecker,
    ];
}

// Method that validates the parameters to refresh the token.
const validateRefreshToken = (req, res, next) => {
    return [
        validateJwt,
    ];
}

// Method that validates the request parameters in sign up.
const validateSignUp = (req, res, next) => {
    return [
        check('name', 'Debes añadir un nombre.').not().isEmpty(),
        check('password', 'Debes añadir una contraseña con una longitud mínima de 8 caracteres.').isLength({ min: 8 }),
        check('email', 'Debes añadir un email de formato correcto.').isEmail(),
        fieldsValidationErrorChecker,
    ];
}

module.exports = {
    validateLogin,
    validateRefreshToken,
    validateSignUp,
}