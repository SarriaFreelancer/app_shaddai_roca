const { Sequelize } = require('sequelize');
require('dotenv').config();

const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASS, {
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,  // 👈 Agregamos el puerto
  dialect: 'mysql',
  logging: false,
});

const connectDB = async () => {
  try {
    await sequelize.authenticate();
    console.log('✅ Conectado a MySQL exitosamente');
  } catch (error) {
    console.error('❌ Error al conectar a MySQL:', error);
  }
};

module.exports = { sequelize, connectDB };
