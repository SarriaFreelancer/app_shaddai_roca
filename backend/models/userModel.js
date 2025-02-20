const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db');

const User = sequelize.define('User', {
  codigo: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  cedula: {
    type: DataTypes.STRING(20),
    unique: true,
    allowNull: false,
  },
  nombre: {
    type: DataTypes.STRING(100),
    allowNull: false,
  },
  telefono: {
    type: DataTypes.STRING(15),
    allowNull: false,
  },
  email: {
    type: DataTypes.STRING(100),
    unique: true,
    allowNull: false,
  },
  password: {
    type: DataTypes.STRING(255),
    allowNull: false,
  },
  token_confirmacion: {
    type: DataTypes.STRING(255),
    defaultValue: null,
  },
  terms_accepted: {
    type: DataTypes.BOOLEAN,
    defaultValue: false, // Por defecto, el usuario no ha aceptado
  },
  terms_version: {
    type: DataTypes.STRING(10),
    allowNull: true, // Se guarda la versión de los términos aceptados
  },
}, {
  timestamps: false,
  tableName: 'usuarios',
});

module.exports = User;
