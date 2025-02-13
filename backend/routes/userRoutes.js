const express = require('express');
const authMiddleware = require('../config/authMiddleware');
const User = require('../models/userModel');

const router = express.Router();

router.get('/profile', authMiddleware, async (req, res) => {
  try {
    const user = await User.findByPk(req.user.userId, {
      attributes: ['codigo', 'cedula', 'nombre', 'telefono', 'email'],
    });
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: 'Error al obtener perfil', details: error.message });
  }
});

module.exports = router;
