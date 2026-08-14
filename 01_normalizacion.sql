Create Database Ventas_Piz;
GO
Use Ventas_Piz;
GO
CREATE TABLE Ventas_Crudas (
    id_orden INT,
    cliente VARCHAR(100),
    tel_cliente VARCHAR(20),
    ciudad VARCHAR(50),
    items_comprados VARCHAR(255), 
    fecha DATE
);
GO

INSERT INTO Ventas_Crudas (id_orden, cliente, tel_cliente, ciudad, items_comprados, fecha) VALUES
(101, 'Carlos Perez', '555-1234', 'Buenos Aires', 'Teclado Mecanico, Mouse Inalambrico', '2026-03-01'),
(102, 'Ana Gomez',    '555-5678', 'Rosario',      'Monitor 24", Cable HDMI',           '2026-03-02'),
(103, 'Carlos Perez', '555-1234', 'Buenos Aires', 'Auriculares',                      '2026-03-03');
GO

SELECT * FROM Ventas_Crudas ; 


--  verrsion cd 1: Normalización de Bases de Datos (1FN

USE Ventas_Piz;
GO

-- 1. Creación de la tabla bajo 1FN 
CREATE TABLE Ventas_1FN (
    id_orden INT,
    id_producto VARCHAR(10),
    producto VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    cantidad INT NOT NULL,
    cliente VARCHAR(100) NOT NULL,
    tel_cliente VARCHAR(20),
    ciudad VARCHAR(50),
    fecha DATE NOT NULL,
    PRIMARY KEY (id_orden, id_producto) -- Clave primaria compuesta
);
GO

-- 2. Inserción con valores atómicos (un registro por cada producto de la orden)
INSERT INTO Ventas_1FN (id_orden, id_producto, producto, precio, cantidad, cliente, tel_cliente, ciudad, fecha) VALUES
(101, 'P01', 'Teclado Mecanico', 50.00,  1, 'Carlos Perez', '555-1234', 'Buenos Aires', '2026-03-01'),
(101, 'P02', 'Mouse Inalambrico', 25.00, 1, 'Carlos Perez', '555-1234', 'Buenos Aires', '2026-03-01'),
(102, 'P03', 'Monitor 24"',     180.00,  1, 'Ana Gomez',    '555-5678', 'Rosario',      '2026-03-02'),
(102, 'P04', 'Cable HDMI',       10.00,  2, 'Ana Gomez',    '555-5678', 'Rosario',      '2026-03-02'),
(103, 'P05', 'Auriculares',      40.00,  1, 'Carlos Perez', '555-1234', 'Buenos Aires', '2026-03-03');
GO

-- 3. Consulta de verificación
SELECT * FROM Ventas_1FN;
GO


------------------------------------------------------------------------------------------------------------------------------------------
-- consulta sql con la 2fn ---------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
USE Ventas_Piz;
GO

-- 1. Tabla de Catálogo de Productos (Elimina la dependencia parcial de producto y precio)
CREATE TABLE Productos (
    id_producto VARCHAR(10) PRIMARY KEY,
    producto VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL
);
GO

-- 2. Tabla de Órdenes de Venta (Contiene los datos generales de la compra)
CREATE TABLE Ordenes_2FN (
    id_orden INT PRIMARY KEY,
    cliente VARCHAR(100) NOT NULL,
    tel_cliente VARCHAR(20),
    ciudad VARCHAR(50),
    fecha DATE NOT NULL
);
GO

-- 3. Tabla Detalle (Relaciona la orden con los productos y almacena la cantidad)
CREATE TABLE Detalle_Orden (
    id_orden INT NOT NULL,
    id_producto VARCHAR(10) NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_orden, id_producto),
    FOREIGN KEY (id_orden) REFERENCES Ordenes_2FN(id_orden),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);
GO

-- =============================================
-- INSERCIÓN DE DATOS
-- =============================================

-- Catálogo único de productos
INSERT INTO Productos (id_producto, producto, precio) VALUES
('P01', 'Teclado Mecanico', 50.00),
('P02', 'Mouse Inalambrico', 25.00),
('P03', 'Monitor 24"', 180.00),
('P04', 'Cable HDMI', 10.00),
('P05', 'Auriculares', 40.00);

-- Cabecera de órdenes
INSERT INTO Ordenes_2FN (id_orden, cliente, tel_cliente, ciudad, fecha) VALUES
(101, 'Carlos Perez', '555-1234', 'Buenos Aires', '2026-03-01'),
(102, 'Ana Gomez',    '555-5678', 'Rosario',      '2026-03-02'),
(103, 'Carlos Perez', '555-1234', 'Buenos Aires', '2026-03-03');

-- Detalle de qué productos compró cada orden
INSERT INTO Detalle_Orden (id_orden, id_producto, cantidad) VALUES
(101, 'P01', 1), -- Carlos compró 1 Teclado
(101, 'P02', 1), -- Carlos compró 1 Mouse
(102, 'P03', 1), -- Ana compró 1 Monitor
(102, 'P04', 2), -- Ana compró 2 Cables HDMI
(103, 'P05', 1); -- Carlos compró 1 Auricular
GO

-- =============================================
-- CONSULTA DE COMPROBACIÓN (Uniendo las 3 tablas)
-- =============================================
SELECT 
    o.id_orden,
    o.cliente,
    p.producto,
    p.precio,
    d.cantidad,
    (p.precio * d.cantidad) AS subtotal,
    o.fecha
FROM Ordenes_2FN o
INNER JOIN Detalle_Orden d ON o.id_orden = d.id_orden
INNER JOIN Productos p ON d.id_producto = p.id_producto;
GO


-- ============================================= ============================================= =============================================
-- CONSULTA FINAL EN 3FN
-- ============================================= ============================================= =============================================
USE Ventas_Piz;
GO


-- 1. Tabla Clientes (Aislamos los datos de las personas)
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    ciudad VARCHAR(50)
);

-- 2. Tabla Productos (Ya aislada desde 2FN)
CREATE TABLE Productos (
    id_producto VARCHAR(10) PRIMARY KEY,
    producto VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL
);

-- 3. Tabla Órdenes (Solo la fecha y la referencia al cliente)
CREATE TABLE Ordenes (
    id_orden INT PRIMARY KEY,
    fecha DATE NOT NULL,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- 4. Tabla Detalle_Orden (Relaciona órdenes con productos comprados)
CREATE TABLE Detalle_Orden_3FN (
    id_orden INT NOT NULL,
    id_producto VARCHAR(10) NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_orden, id_producto),
    FOREIGN KEY (id_orden) REFERENCES Ordenes(id_orden),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);
GO

-- =============================================
-- INSERCIÓN DE DATOS NORMALIZADOS
-- =============================================

-- Clientes registrados una sola vez
INSERT INTO Clientes (id_cliente, nombre, telefono, ciudad) VALUES
(1, 'Carlos Perez', '555-1234', 'Buenos Aires'),
(2, 'Ana Gomez',    '555-5678', 'Rosario');

-- Catálogo de productos
INSERT INTO Productos (id_producto, producto, precio) VALUES
('P01', 'Teclado Mecanico', 50.00),
('P02', 'Mouse Inalambrico', 25.00),
('P03', 'Monitor 24"', 180.00),
('P04', 'Cable HDMI', 10.00),
('P05', 'Auriculares', 40.00);

-- Órdenes asociadas a clientes por id_cliente
INSERT INTO Ordenes (id_orden, fecha, id_cliente) VALUES
(101, '2026-03-01', 1), -- Orden de Carlos
(102, '2026-03-02', 2), -- Orden de Ana
(103, '2026-03-03', 1); -- Otra orden de Carlos

-- Detalle de productos vendidos
INSERT INTO Detalle_Orden_3FN (id_orden, id_producto, cantidad) VALUES
(101, 'P01', 1),
(101, 'P02', 1),
(102, 'P03', 1),
(102, 'P04', 2),
(103, 'P05', 1);
GO


SELECT 
    o.id_orden,
    c.nombre AS cliente,
    c.telefono,
    c.ciudad,
    p.producto,
    p.precio,
    d.cantidad,
    (p.precio * d.cantidad) AS subtotal,
    o.fecha
FROM Ordenes o
INNER JOIN Clientes c ON o.id_cliente = c.id_cliente
INNER JOIN Detalle_Orden_3FN d ON o.id_orden = d.id_orden
INNER JOIN Productos p ON d.id_producto = p.id_producto;
GO
