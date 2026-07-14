CREATE TABLE IF NOT EXISTS roles (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    descripcion VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS usuarios (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    rol_id INTEGER REFERENCES roles(id),
    activo BOOLEAN DEFAULT TRUE,
    registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO roles (descripcion) VALUES
('cliente'),
('trabajador'),
('admin')
ON CONFLICT (descripcion) DO NOTHING;

INSERT INTO usuarios (nombre, email, password, rol_id, activo)
VALUES (
    'Roberto Bethancourt',
    'roberto@ordena24.com',
    '$2b$12$C3fQ4qCE5R.0pm9aglyLzuNbm6HA6F254SwMpc7dzk2RWb0iN/o9C',
    3,
    TRUE
)
ON CONFLICT (email) DO NOTHING;

INSERT INTO usuarios (nombre, email, password, rol_id, activo)
VALUES (
    'Angel Gonzalez',
    'angel@ordena24.com',
    '$2b$12$oVCLYngcpT6haWGKjjwNWu3p4Y8iaN95SKPHVqGYNKHrkqwv0lmim',
    2,
    TRUE
)
ON CONFLICT (email) DO NOTHING;