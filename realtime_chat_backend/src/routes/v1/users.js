/**
 * path: /api/v1/users
 */

 const { Router } = require('express');
 const controller = require('../../controllers/users');
 const fieldsValidator = require('../../middlewares/users_fields_validator');
 
 const router = Router();
 
 router.get('/', fieldsValidator.validateGetUsers(), controller.getUsers);
 
 module.exports = router;