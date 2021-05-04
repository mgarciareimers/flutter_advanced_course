const { check } = require('express-validator');
const fieldsValidationErrorChecker = require('./fields_validation_error_checker');

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
    validateSignUp,
}