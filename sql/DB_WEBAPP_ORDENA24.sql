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

INSERT INTO usuarios (nombre, email, password, rol_id, activo)
VALUES (
    'Administrador Ordena24',
    'admin@ordena24.com',
    '$2b$12$7QJ8Mki60nKkLxU1v7O6E.umt4P2PvNLhkcDFNJkPHO/TKFG34MeC',
    3,
    TRUE
)
ON CONFLICT (email) DO NOTHING;

INSERT INTO roles (descripcion) VALUES
('cliente'),
('trabajador'),
('admin')
ON CONFLICT (descripcion) DO NOTHING;