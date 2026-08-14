-- =======================================================
-- 1. BASE DE DATOS Y TABLA CON DATOS DE PRUEBA
-- =======================================================
USE Ventas_Piz;
GO

CREATE TABLE Ventas_Sucursales (
    id_venta INT PRIMARY KEY,
    sucursal VARCHAR(50) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha DATE NOT NULL
);
GO

INSERT INTO Ventas_Sucursales (id_venta, sucursal, categoria, monto, fecha) VALUES
(1, 'Centro', 'Tecnologia', 1500.00, '2026-03-01'),
(2, 'Centro', 'Muebles',     800.00, '2026-03-01'),
(3, 'Centro', 'Tecnologia', 1200.00, '2026-03-02'),
(4, 'Norte',  'Tecnologia', 2000.00, '2026-03-02'),
(5, 'Norte',  'Tecnologia', 1000.00, '2026-03-03'),
(6, 'Sur',    'Muebles',     500.00, '2026-03-03'),
(7, 'Sur',    'Tecnologia',  900.00, '2026-03-04');
GO

-- Ver todos los datos cargados (7 ventas en total)
SELECT * FROM Ventas_Sucursales;
GO


-- =======================================================
-- 2. EJEMPLOS INDIVIDUALES DE FUNCIONES DE AGREGADO
-- =======================================================

-- Función COUNT(): Total de ventas registradas
SELECT COUNT(*) AS total_ventas_registradas
FROM Ventas_Sucursales;
GO

-- Función SUM(): Suma total del dinero recaudado
SELECT SUM(monto) AS total_dinero_recaudado
FROM Ventas_Sucursales;
GO

-- Función AVG(): Monto promedio por venta
SELECT AVG(monto) AS promedio_por_venta
FROM Ventas_Sucursales;
GO

-- Función MIN(): La venta de menor valor
SELECT MIN(monto) AS venta_minima
FROM Ventas_Sucursales;
GO

-- Función MAX(): La venta de mayor valor
SELECT MAX(monto) AS venta_maxima
FROM Ventas_Sucursales;
GO


-- =======================================================
-- 3. AGRUPAMIENTO CON GROUP BY
-- =======================================================

-- Resume métricas clave agrupadas por cada sucursal
SELECT 
    sucursal,
    COUNT(*) AS cantidad_ventas,
    SUM(monto) AS total_ventas,
    AVG(monto) AS promedio_ventas
FROM Ventas_Sucursales
GROUP BY sucursal;
GO


-- =======================================================
-- 4. FILTRADO DE GRUPOS CON HAVING
-- =======================================================

-- Solo muestra sucursales cuyo total recaudado supere los $2,000
SELECT 
    sucursal,
    SUM(monto) AS total_ventas
FROM Ventas_Sucursales
GROUP BY sucursal
HAVING SUM(monto) > 2000;
GO


-- =======================================================
-- 5. COMBINACIÓN CLAVE: WHERE vs HAVING EN LA MISMA CONSULTA
-- =======================================================

-- WHERE filtra filas individuales (solo Tecnología) ANTES de agrupar
-- HAVING filtra grupos calculados (total > 1500) DESPUÉS de agrupar
SELECT 
    sucursal,
    SUM(monto) AS total_tecnologia
FROM Ventas_Sucursales
WHERE categoria = 'Tecnologia'
GROUP BY sucursal
HAVING SUM(monto) > 1500;
GO
