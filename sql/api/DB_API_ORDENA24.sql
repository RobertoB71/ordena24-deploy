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
    ('Bebidas', TRUE)
ON CONFLICT (descripcion) DO NOTHING;

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