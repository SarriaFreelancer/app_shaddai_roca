# 📱 Aplicación Shaddai Roca Gestión de servicios en el hogar  

🚀 *Descripción:*  
Esta aplicación móvil, desarrollada en *Flutter* con un backend en *Node.js y MySQL, permite a los usuarios registrarse, iniciar sesión con autenticación mediante **JWT (JSON Web Token)*, gestionar categorías, recuperar contraseñas y aceptar términos y condiciones.  

🔐 *Características principales:*  
✅ *Autenticación con JWT* (Inicio de sesión y registro)  
✅ *Gestión de usuarios* (Registro, recuperación de contraseña, validación de email)  
✅ *Aceptación de términos y condiciones* (Versión controlada en base de datos)  
✅ *Manejo de categorías* (CRUD de categorías)  
✅ *Seguridad con hashing de contraseñas usando bcrypt*  
✅ *Persistencia de sesión con SharedPreferences*  

---

## 📚 *Estructura del Proyecto*  


📁 mi_proyecto/
│-- 📁 backend/          # Código del backend en Node.js + Express
│   ├── server.js        # Servidor principal
│   ├── routes/          # Rutas de la API
│   ├── db.js            # Conexión con MySQL
│   ├── authController.js # Lógica de autenticación
│   ├── categoryController.js # Gestión de categorías
│   ├── middlewares/     # Middleware de autenticación
│
│-- 📁 frontend/         # Código del frontend en Flutter
│   ├── lib/
│   │   ├── main.dart    # Punto de entrada de la app
│   │   ├── pages/       # Pantallas principales (Login, Registro, Categorías)
│   │   └── services/    # Comunicación con el backend
│
│-- 📁 database/         # Scripts SQL para crear la base de datos
│   └── schema.sql       # Estructura de la base de datos
│
└── README.md            # Este archivo 📚


---

## 🔧 *Instalación y Configuración*  

### 🖥 *Backend (Node.js + MySQL)*  
1️⃣ Clona el repositorio:  
sh
git clone https://github.com/tu-usuario/tu-repositorio.git
cd tu-repositorio/backend

2️⃣ Instala dependencias:  
sh
npm install

3️⃣ Configura el archivo **.env** con las credenciales de MySQL:  
env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=tu_password
DB_NAME=mi_base_de_datos
JWT_SECRET=mi_secreto_super_seguro

4️⃣ Ejecuta el servidor:  
sh
node server.js


---

### 📱 *Frontend (Flutter)*  
1️⃣ Instala Flutter si aún no lo tienes: [Flutter Docs](https://flutter.dev/docs/get-started/install)  
2️⃣ Entra a la carpeta del frontend:  
sh
cd ../frontend

3️⃣ Instala paquetes de Flutter:  
sh
flutter pub get

4️⃣ Ejecuta la app en un emulador o dispositivo:  
sh
flutter run


---

## 💎 *Base de Datos (Usuarios y Categorías)*  
sql
CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    accepted_terms BOOLEAN NOT NULL DEFAULT FALSE,
    terms_version VARCHAR(10) NOT NULL DEFAULT '1.0',
    token_reset VARCHAR(255) NULL
);

CREATE TABLE categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    usuario_id INT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);


---

## 🔑 *Autenticación y Seguridad*  

- *Inicio de sesión y autenticación* con *JWT* (JSON Web Token)  
- *Contraseñas cifradas con bcrypt*  
- *Tokens de recuperación de contraseña* para seguridad  
- *Autorización de usuario* con middleware en Express  

### 📄 *Flujo de autenticación:*  
1️⃣ El usuario se registra con email y contraseña.  
2️⃣ Recibe un *token JWT* tras iniciar sesión.  
3️⃣ El token se almacena en *SharedPreferences* en el frontend.  
4️⃣ Las solicitudes protegidas al backend requieren el token en los headers.  

---

## 📩 *Endpoints de la API*  

### 🔐 *Autenticación*  
| Método | Ruta                  | Descripción                      |
|--------|-----------------------|----------------------------------|
| POST   | /api/auth/register   | Registro de usuario             |
| POST   | /api/auth/login      | Inicio de sesión                |
| POST   | /api/auth/accept-terms | Aceptar términos y condiciones |

### 🔄 *Gestión de Categorías*  
| Método | Ruta                     | Descripción                      |
|--------|--------------------------|----------------------------------|
| GET    | /api/categories        | Obtener todas las categorías     |
| POST   | /api/categories        | Crear una nueva categoría        |
| PUT    | /api/categories/:id    | Actualizar una categoría         |
| DELETE | /api/categories/:id    | Eliminar una categoría           |

---

## 💌 *Contacto*  
📌 *Desarrollador:* David Sarria 
📌 *Correo:* sarriafreelancer@gmail.com
📌 *GitHub:* https://github.com/SarriaFreelancer
