const { Router } = require('express');
const router = Router();

router.use('/', require('./auth'));
router.use('/users', require('./users'));


module.exports = router;