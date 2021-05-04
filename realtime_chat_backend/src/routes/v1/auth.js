/**
 * path: /api/v1/
 */
const { Router } = require('express');
const controller = require('../../controllers/auth');
const fieldsValidator = require('../../middlewares/auth_fields_validator');

const router = Router();

router.post('/login', fieldsValidator.validateLogin(), controller.login);
router.get('/refresh', fieldsValidator.validateRefreshToken(), controller.refreshToken);
router.post('/signup', fieldsValidator.validateSignUp(), controller.signUp);


module.exports = router;