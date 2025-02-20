const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/userModel");
require("dotenv").config();

exports.register = async (req, res) => {
  try {
    const { cedula, nombre, telefono, email, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);

    const newUser = await User.create({
      cedula,
      nombre,
      telefono,
      email,
      password: hashedPassword
    });

    res.status(201).json({ message: "Usuario registrado con éxito" });
  } catch (error) {
    res
      .status(500)
      .json({ error: "Error al registrar usuario", details: error.message });
  }
};

exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ where: { email } });

    if (!user) return res.status(404).json({ error: 'Usuario no encontrado' });

    const isValidPassword = await bcrypt.compare(password, user.password);
    if (!isValidPassword) return res.status(401).json({ error: 'Credenciales incorrectas' });

    const token = jwt.sign({ userId: user.codigo }, process.env.JWT_SECRET, { expiresIn: '1h' });

    // Incluir información del usuario en la respuesta
    res.json({
      message: 'Inicio de sesión exitoso',
      token,
      user: {
        email: user.email,
        terms_accepted: user.terms_accepted,  // 👈 Asegurar que este campo existe en la BD
        terms_version: user.terms_version ?? "1.0" // 👈 Manejar si es null
      }
    });
  } catch (error) {
    res.status(500).json({ error: 'Error al iniciar sesión', details: error.message });
  }
};


exports.acceptTerms = async (req, res) => {
  try {
    const { email, terms_version } = req.body;

    if (!email || !terms_version) {
      return res
        .status(400)
        .json({ message: "Email y versión de términos son requeridos" });
    }

    const user = await User.findOne({ where: { email } });
    if (!user) {
      return res.status(404).json({ message: "Usuario no encontrado" });
    }

    user.terms_accepted = true;
    user.terms_version = terms_version;
    await user.save();

    return res
      .status(200)
      .json({ message: "Términos aceptados correctamente" });
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Error al aceptar términos", error });
  }
};
