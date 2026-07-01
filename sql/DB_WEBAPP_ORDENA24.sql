SET search_path TO public;

CREATE TABLE IF NOT EXISTS roles (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(50) NOT NULL UNIQUE
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

INSERT INTO roles (nombre) VALUES
('cliente'),
('personal'),
('admin');

INSERT INTO usuarios (nombre, email, password, rol_id) VALUES
('Administrador Ordena24', 'admin@ordena24.com', 'admin123', 3),
('Personal Restaurante', 'personal@ordena24.com', 'personal123', 2),
('Cliente Demo', 'cliente@ordena24.com', 'cliente123', 1);