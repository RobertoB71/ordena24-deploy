CREATE TABLE IF NOT EXISTS categorias (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    descripcion VARCHAR(100) NOT NULL UNIQUE,
    activo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS productos (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    nombre VARCHAR(150) NOT NULL UNIQUE,
    descripcion TEXT,
    precio NUMERIC(10, 2) NOT NULL,
    categoria_id INTEGER NOT NULL,
    disponible BOOLEAN NOT NULL DEFAULT TRUE,
    imagen_url VARCHAR(255),

    CONSTRAINT fk_producto_categoria
        FOREIGN KEY (categoria_id)
        REFERENCES categorias(id)
);

CREATE TABLE IF NOT EXISTS pedidos (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    usuario_id INTEGER,
    cliente_nombre VARCHAR(150) NOT NULL,
    cliente_email VARCHAR(150) NOT NULL,
    telefono VARCHAR(30),
    direccion_entrega TEXT NOT NULL,
    subtotal NUMERIC(10, 2) NOT NULL DEFAULT 0,
    costo_envio NUMERIC(10, 2) NOT NULL DEFAULT 0,
    total NUMERIC(10, 2) NOT NULL DEFAULT 0,
    estado VARCHAR(30) NOT NULL DEFAULT 'Pendiente',
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS detalle_pedido (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    pedido_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    nombre_producto VARCHAR(150) NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario NUMERIC(10, 2) NOT NULL,
    subtotal NUMERIC(10, 2) NOT NULL,

    CONSTRAINT fk_detalle_pedido
        FOREIGN KEY (pedido_id)
        REFERENCES pedidos(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (producto_id)
        REFERENCES productos(id)
);

INSERT INTO categorias (
    descripcion,
    activo
)
VALUES
    ('Hamburguesas', TRUE),
    ('Bebidas', TRUE),
    ('Pizzas', TRUE),
    ('Pastas', TRUE),
    ('Ensaladas', TRUE),
    ('Tacos', TRUE),
    ('Postres', TRUE)
ON CONFLICT (descripcion) DO NOTHING;

-- =========================================================
-- HAMBURGUESA SUPREMA CON PAPAS
-- =========================================================

INSERT INTO productos (
    nombre,
    descripcion,
    precio,
    categoria_id,
    disponible,
    imagen_url
)
SELECT
    'Hamburguesa Suprema con Papas',
    'Jugosa hamburguesa de carne con queso fundido, cebolla caramelizada, vegetales frescos y salsa especial, servida con una porción de papas fritas sazonadas.',
    12.50,
    categorias.id,
    TRUE,
    '/uploads/productos/80e8bc397bbd420f90d5957885018440.jpg'
FROM categorias
WHERE categorias.descripcion = 'Hamburguesas'
ON CONFLICT (nombre) DO NOTHING;

-- =========================================================
-- LIMONADA DE FRAMBUESA
-- =========================================================

INSERT INTO productos (
    nombre,
    descripcion,
    precio,
    categoria_id,
    disponible,
    imagen_url
)
SELECT
    'Limonada de Frambuesa y Menta',
    'Refrescante bebida artesanal preparada con frambuesas, limón y hojas de menta, servida fría con hielo. Una combinación frutal, ligeramente cítrica y perfecta para acompañar cualquier comida.',
    4.50,
    categorias.id,
    TRUE,
    '/uploads/productos/74a5f0d21af249e49058898e41283406.png'
FROM categorias
WHERE categorias.descripcion = 'Bebidas'
ON CONFLICT (nombre) DO NOTHING;

-- =========================================================
-- PIZZA MARGARITA
-- =========================================================

INSERT INTO productos (
    nombre,
    descripcion,
    precio,
    categoria_id,
    disponible,
    imagen_url
)
SELECT
    'Pizza Margarita Clásica',
    'Deliciosa pizza artesanal elaborada con salsa de tomate, queso mozzarella derretido y hojas frescas de albahaca sobre una base horneada. Una opción clásica, ligera y llena de sabor.',
    12.99,
    categorias.id,
    TRUE,
    '/uploads/productos/9fbc123cf7514189a7698fe63fc38500.jpg'
FROM categorias
WHERE categorias.descripcion = 'Pizzas'
ON CONFLICT (nombre) DO NOTHING;


-- =========================================================
-- SPAGHETTI AL POMODORO
-- =========================================================

INSERT INTO productos (
    nombre,
    descripcion,
    precio,
    categoria_id,
    disponible,
    imagen_url
)
SELECT
    'Spaghetti al Pomodoro',
    'Pasta spaghetti servida con una suave salsa de tomate, queso espolvoreado y decorada con hojas frescas de albahaca. Un plato clásico, ligero y lleno de sabor, ideal para quienes disfrutan de la cocina italiana tradicional.',
    6.50,
    categorias.id,
    TRUE,
    '/uploads/productos/bacea12f0ee34114bf3ef4a5fb214c75.jpg'
FROM categorias
WHERE categorias.descripcion = 'Pastas'
ON CONFLICT (nombre) DO NOTHING;


-- =========================================================
-- ENSALADA DE AGUACATE Y TOMATE
-- =========================================================

INSERT INTO productos (
    nombre,
    descripcion,
    precio,
    categoria_id,
    disponible,
    imagen_url
)
SELECT
    'Ensalada Fresca de Aguacate y Tomate',
    'Ensalada preparada con aguacate cremoso, tomate fresco, rúcula y semillas de girasol, ligeramente sazonada para resaltar sus sabores naturales. Una opción ligera, nutritiva y refrescante.',
    3.50,
    categorias.id,
    TRUE,
    '/uploads/productos/5b552e6a23da483d890716150c6ac1d8.jpg'
FROM categorias
WHERE categorias.descripcion = 'Ensaladas'
ON CONFLICT (nombre) DO NOTHING;


-- =========================================================
-- TACOS DE CARNE
-- =========================================================

INSERT INTO productos (
    nombre,
    descripcion,
    precio,
    categoria_id,
    disponible,
    imagen_url
)
SELECT
    'Tacos de Carne con Guacamole',
    'Tres tacos crujientes rellenos de carne sazonada, queso cheddar, lechuga fresca, tomate, cebolla, guacamole y crema agria. Una combinación abundante, colorida y llena de sabor.',
    8.99,
    categorias.id,
    TRUE,
    '/uploads/productos/70da580a73cf47b6ac9e1a31ff43de66.png'
FROM categorias
WHERE categorias.descripcion = 'Tacos'
ON CONFLICT (nombre) DO NOTHING;


-- =========================================================
-- CHEESECAKE DE FRESA
-- =========================================================

INSERT INTO productos (
    nombre,
    descripcion,
    precio,
    categoria_id,
    disponible,
    imagen_url
)
SELECT
    'Cheesecake de Fresa',
    'Cremosa tarta de queso sobre una base crujiente de galleta, cubierta con salsa de fresa, fresas frescas y un toque de crema batida. Un postre suave, frutal y equilibrado.',
    7.50,
    categorias.id,
    TRUE,
    '/uploads/productos/066484c345244f3c9ae84983a19b546b.png'
FROM categorias
WHERE categorias.descripcion = 'Postres'
ON CONFLICT (nombre) DO NOTHING;