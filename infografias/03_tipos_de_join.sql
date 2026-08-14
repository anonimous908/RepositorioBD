-- ============================================================
-- SCRIPT SQL: DEMOSTRACIÓN DE TIPOS DE JOIN (6 REGISTROS POR TABLA)
-- Asignatura: Base de Datos
-- ============================================================

-- 1. ESTRUCTURA DE TABLAS
CREATE TABLE clientes (
    cliente_id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    ciudad VARCHAR(50)
);

CREATE TABLE pedidos (
    pedido_id INT PRIMARY KEY,
    cliente_id INT,
    total DECIMAL(10,2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE empleados (
    empleado_id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    puesto VARCHAR(50),
    supervisor_id INT
);

-- 2. INSERCIÓN DE 6 REGISTROS EN CLIENTES
INSERT INTO clientes (cliente_id, nombre, ciudad) VALUES
(1, 'Carlos Gómez', 'CDMX'),
(2, 'Ana Martínez', 'Guadalajara'),
(3, 'Luis Hernández', 'Monterrey'),
(4, 'Sofía López', 'Puebla'),
(5, 'Mateo Torres', 'Querétaro'),   -- Cliente sin pedidos
(6, 'Valentina Ríos', 'Mérida');    -- Cliente sin pedidos

-- 3. INSERCIÓN DE 6 REGISTROS EN PEDIDOS
INSERT INTO pedidos (pedido_id, cliente_id, total) VALUES
(101, 1, 150.50),  -- Pedido 1 de Carlos
(102, 1, 200.00),  -- Pedido 2 de Carlos
(103, 2, 85.00),   -- Pedido de Ana
(104, 3, 420.00),  -- Pedido de Luis
(105, 4, 310.00),  -- Pedido de Sofía
(106, NULL, 99.99); -- Pedido sin cliente asignado

-- 4. INSERCIÓN DE 6 REGISTROS EN EMPLEADOS (Para SELF JOIN)
INSERT INTO empleados (empleado_id, nombre, puesto, supervisor_id) VALUES
(1, 'Roberto Silva', 'Director General', NULL),
(2, 'María Morales', 'Gerente de TI', 1),
(3, 'Juan Pérez', 'Jefe de Desarrollo', 2),
(4, 'Laura Gómez', 'Dev Senior', 3),
(5, 'Diego Fernández', 'Dev Junior', 3),
(6, 'Lucía Castro', 'Pasante', 4);

-- ============================================================
-- CONSULTAS CON CADA TIPO DE JOIN
-- ============================================================

-- A. INNER JOIN: Trae solo coincidencias (Clientes que tienen pedidos)
SELECT c.cliente_id, c.nombre, p.pedido_id, p.total
FROM clientes c
INNER JOIN pedidos p ON c.cliente_id = p.cliente_id;

-- B. LEFT JOIN: Trae todos los clientes (incluso Mateo y Valentina que no compraron nada)
SELECT c.cliente_id, c.nombre, p.pedido_id, p.total
FROM clientes c
LEFT JOIN pedidos p ON c.cliente_id = p.cliente_id;

-- C. RIGHT JOIN: Trae todos los pedidos (incluyendo el 106 que no tiene cliente)
SELECT c.nombre, p.pedido_id, p.total
FROM clientes c
RIGHT JOIN pedidos p ON c.cliente_id = p.cliente_id;

-- D. FULL OUTER JOIN: Trae absolutamente todo (Clientes sin pedido y pedidos sin cliente)
-- En SQL Standard / PostgreSQL / SQL Server:
-- SELECT c.nombre, p.pedido_id, p.total FROM clientes c FULL JOIN pedidos p ON c.cliente_id = p.cliente_id;
-- Sintaxis universal para MySQL (UNION de LEFT y RIGHT):
SELECT c.nombre, p.pedido_id, p.total
FROM clientes c
LEFT JOIN pedidos p ON c.cliente_id = p.cliente_id
UNION
SELECT c.nombre, p.pedido_id, p.total
FROM clientes c
RIGHT JOIN pedidos p ON c.cliente_id = p.cliente_id;

-- E. CROSS JOIN: Producto cartesiano (6 clientes x 6 pedidos = 36 combinaciones)
SELECT c.nombre, p.pedido_id, p.total
FROM clientes c
CROSS JOIN pedidos p;

-- F. SELF JOIN: Relación jerárquica de empleados con su supervisor
SELECT 
    e.nombre AS Empleado,
    e.puesto AS Puesto_Empleado,
    s.nombre AS SupervisorDirecto
FROM empleados e
LEFT JOIN empleados s ON e.supervisor_id = s.empleado_id;
