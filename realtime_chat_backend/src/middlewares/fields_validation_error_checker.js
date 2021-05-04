const { validationResult } = require('express-validator');
const ResponseModel = require('../models/response_model');

// Method that checks if the request passes the fields validator. In case it doesn't, return error.
const fieldsValidationErrorChecker = (req, res, next) => {
    const result = validationResult(req);

    if (!result.isEmpty()) {
        return res.status(400).json(new ResponseModel(false, result.errors[0].msg, null, result.errors[0]));
    }

    next();
}

module.exports = fieldsValidationErrorChecker;