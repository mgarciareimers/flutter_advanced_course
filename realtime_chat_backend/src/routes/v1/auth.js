/**
 * path: /api/v1/
 */
const { Router } = require('express');
const controller = require('../../controllers/auth');

const router = Router();

router.post('/signup', controller.signUp);


module.exports = router;