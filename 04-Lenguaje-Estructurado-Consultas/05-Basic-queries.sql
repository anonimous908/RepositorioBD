/*======================================================
TEMA: CONSULTAS BASICAS CON SELECT
ARCHIVO: 05-base-queries.sql
DESCRIPCION: DESARROLLAR LÑA CAPACIDADPARA CONSTRUIR CONSULTA BASICAS MMEDIANTE SELECT
 */
 
 USE comercial_db;
 Go

-- Uso del SELECT *

Sintaxis:

SELECT * 
FROM nombre_tabla;
/*
Nota: EL asterisco significa todoas las columna de una tabla
(No es muy recomendable usarlo o su uso)
Porque no se recomineda su uso
1. Recupera lam informacion innecesaria
2. Reduce la claridad de la consulta
3. Puede aumentar el consumo recursos
*/
-- Seleccionar todos los registros y campos de la tabla productos

SELECT *
FROM productos;

-- Proyeccion
SELECT 
   codigo,
   nombre,
   precio
FROM productos;

-- Alias de columna
-- Un alias de columna es un nombre temporal asignado a una columna dentro del resultado
-- dentro del resultado de una columna

SELECT
codigo AS codigo_producto,
nombre AS nombre_producto,
precio AS precio_producto
FROM productos;
GO

SELECT
codigo AS [codigo producto],
nombre AS [nombre producto],
precio AS [precio producto]
FROM productos;
GO

SELECT
codigo AS 'codigo producto',
nombre AS 'nombre producto',
precio AS 'precio producto'
FROM productos;
GO


SELECT
codigo 'codigo producto',
nombre 'nombre producto',
precio 'precio producto'
FROM productos;
GO

SELECT
codigo AS [codigo producto],
nombre AS 'nombre producto',
precio AS precio_producto
FROM productos;
GO

-- ALIAS DE TABLA
-- TAMBIEN SE PUEDE ASIGNAR UN ALIAS TEMPORAL EN UNA TABLA



-- SINTAXIS

/*

    SELECT alias_tabla.columna
    FROM nombre_tabla AS alias.tabla;
*/
SELECT 
    p.codigo,
    p.nombre,
    p.precio
FROM productos AS p;

SELECT * FROM categorias;
SELECT * FROM productos;

SELECT 
c.id_categoria AS [#categoria],
c.nombre AS [# Nombre categoria],
p.id_producto [#Producto],
p.nombre[#Nombre Producto],
p.precio,
p.existencia
FROM categorias AS c
INNER JOIN productos AS p
ON c.id_categoria = p.id_categoria;
GO

-- Campos Calculados - Columnas Calculadas
-- Una columna calculada es el resultado de una expresion ionjcluida en la 
-- lista de selecccion
-- No es¿xiste fisicamnete en l tabla

SELECT
    p.codigo,
    p.nombre,
    p.precio,
    p.existencia, 
    p.existencia * p.precio AS valor_inventario
FROM productos AS p;

/*============================================== 

OPERADORES ARITMETICOS EN SQL
+ SUMA
- RESTA
* MULTIPLICACION
/ DIVISION
% MODULO - RESIDUO DE DIVISION
==============================================*/

-- SELECCIONAR EL NOMBRE, APELLIDO PATERNO, SALARIO Y SIMULAR 
-- COMO QUEDARIA EL SALARIO DE CADA EMPLEADO SI RECIBIERA UN AUMENTO
-- FIJO DE $1,000, EL CAPO SE DEBE LLAMAR salario_simulado

SELECT
e.nombre,
e.apellido_paterno,
CONCAT(e.nombre, '', e.apellido_paterno, '', apellido_materno) 
AS nombre_completo,
YEAR(e.fecha_ingreso) AS año_ingreso,
MONTH(e.fecha_ingreso) AS mes_ingreso,
DAY(e.fecha_ingreso) AS dia_ingreso,
e.fecha_ingreso,
e.salario,
(e.salario + 1000) AS salario_simulado 
FROM empleados AS e;


-- Mostrar de una venta cual es su numero, cantidad vendida, precio,
-- descuento, importe_bruto (canbtiudad por el precio ) y ademas el importe 
-- con descuento la forumla es (importe_bruto, por el desceunto dividido entre 100)


SELECT 
    dv.id_venta,
    dv.cantidad,
    dv.precio,
    dv.descuento,
    (dv.cantidad * dv.precio) AS importe_bruto,
    (dv.cantidad * dv.precio) - ((dv.cantidad * dv.precio) * dv.descuento / 100.0) AS importe_con_descuento
FROM dbo.detalle_ventas AS dv;



-- USO DE LA CLAUSULA DISTINCT

-- Elimina el resultado las fillas que tengan valores repetidos en todas las columnas 
--  seleccionadas 

SELECT c.sexo
FROM clientes AS c;


SELECT COUNT(c.sexo) AS cantidad_de_sexo
FROM clientes AS c;

SELECT DISTINCT sexo
FROM clientes AS c;


-- TODO: DISTINCT CON MAS DE UN CAMPO


SELECT 
    id_cliente,
    id_empleado
FROM ventas
ORDER BY 1 DESC , 2 DESC;
GO


SELECT DISTINCT
     id_cliente,
    id_empleado
FROM ventas
GO

--limita la cantidad de filas devueltas por una consulta
select TOP(5)
id_producto,
codigo,
nombre,
precio
from productos
order by precio DESC;

-- top con expresiones calculadas

select 
codigo,
nombre,
precio,
existencia,
(precio*existencia) AS valor_inventario
from productos
order by precio DESC;

-- top con porcentaje
-- sql server permite limitar el resultado mediante un porcentaje

select  TOP(10) PERCENT
codigo,
nombre,
precio,
existencia,
(precio*existencia) AS valor_inventario
from productos
order by precio DESC;

-- conbinar distinct con el top

select DISTINCT TOP(10)
    descuento
from detalle_ventas