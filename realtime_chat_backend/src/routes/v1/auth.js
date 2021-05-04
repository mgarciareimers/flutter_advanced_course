/**
 * path: /api/v1/
 */
const { Router } = require('express');
const controller = require('../../controllers/auth');
const fieldsValidator = require('../../middlewares/auth_fields_validator');

const router = Router();

router.post('/login', fieldsValidator.validateLogin(), controller.login);
router.post('/signup', fieldsValidator.validateSignUp(), controller.signUp);


module.exports = router;