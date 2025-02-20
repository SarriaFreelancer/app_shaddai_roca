const express = require('express');
const { register, login, acceptTerms } = require('../controllers/authController');

const router = express.Router();

router.post('/register', register);
router.post('/login', login);
router.post('/accept-terms', acceptTerms);

module.exports = router;
