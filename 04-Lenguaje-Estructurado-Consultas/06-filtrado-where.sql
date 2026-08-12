/*===================================================================



FILTRADO DE REGISTROS CON WHERE


ARCHIVO : 06-filtrado-where.sql 

Descripcion: 
En este tema se filtraran registros mediante condiciones
comparaciones , operadores logicos , y busqueda por patrones 


===================================================================*/


--SELECCIONAR COLUMNAS UY FIRLTRAR FILAS


USE comercial_db;

--WHERE SE EJECUTA DESPUIES DE FROM ,,,,FROM,WHERE, SELECT

SELECT
	codigo,
	nombre,
	precio
FROM productos;


--MOSTRAR LOS PRODUCTOS CON UN PRECIO MAYOR A 40

SELECT
	codigo,
	nombre,
	precio
FROM productos
WHERE precio > 400;


--MOSTRAR EL PRODUCTO CUYO PRECIO ES ESACTAMENTE 200
SELECT
	p.codigo AS Codigo,
	p.nombre,
	p.precio
FROM productos AS p
WHERE p.precio = 200;

--SELECCIONAR LOS DATOS DEL CLIENTE 25

SELECT 
	c.id_cliente,
	c.nombre,
	c.apellido_paterno,
	c.correo
FROM clientes AS c
WHERE c.id_cliente =25;

--Comparacion de cadenas de texto
--LOS VALORES DE TEXTO DEBEN ESCRIBIRSE ENTRE COMILLAS SIMPLES 

-- SELECCIONAR TODAS LAS CATEGORIAS, DONDE EL 
--NOMBRE SEA COMPUTO.

SELECT 
	c.id_categoria,
	c.nombre
FROM categorias AS c
WHERE c.nombre = 'Cómputo'

--MOSTRAR LOS DATOS DE LOS EMPLEADOS QUE NO PERTENESCAN AL DEPARTAMENTO 1
--(NUMERO DE EMPLEADO, NOMBRE , SALARIO , Y NUMERO DEL DEPARTAMENTO )

SELECT 
	e.id_empleado,
	e.nombre,
	e.salario,
	e.id_departamento
FROM empleados AS e
WHERE e.id_departamento<>1;

--SELECCIONAR  LOS PRODUCTOS CUYO PRECIO SEA SUPERIOR A 450 
--codigo , nombre , precio , existencia , utilizar aliass en colummnas y de tabla 

SELECT 
	p.codigo AS codigo,
	p.nombre AS Nombre_producto,
	p.precio,
	p.existencia
FROM productos AS p
WHERE p.precio>=450;

--MENORES
SELECT 
	p.codigo AS codigo,
	p.nombre AS Nombre_producto,
	p.precio,
	p.existencia
FROM productos AS p
WHERE p.precio<=450;

SELECT 
	p.codigo AS codigo,
	p.nombre AS Nombre_producto,
	p.precio,
	p.existencia
FROM productos AS p
WHERE p.precio<>450;

--FILTRAR FECHAS 
-- LAS FECHAS DEBEN ESCRIBIRSE ENTRE COMILLAS SIMPOLES 
-- SE RFECOMIENDA UTILIZAR EL FORMATO AAAA-MM-DD

--seleccionar todass las ventas realizadas el 24 de diciembre del 2024
--mostrar el numero de venta , la fecha de venta , cliente al que se vendio ,
-- empleado que lo vendio 

--corregir

SELECT 
	v.id_venta AS numero_venta,
	v.fecha AS fecha_venta,
	v.id_cliente AS Cliente,
	v.id_empleado AS Empleado

FROM ventas AS v
WHERE fecha = '2024-12-24';
-- en el where no se usa un alias de columna 



SELECT 
	v.id_venta AS numero_venta,
	v.fecha AS fecha_venta,
	v.id_cliente AS Cliente,
	v.id_empleado AS Empleado

FROM ventas AS v
INNER JOIN 
clientes AS c 
ON v.id_cliente = c.id_cliente
INNER JOIN 
empleados  AS e
ON v.id_empleado = e.id_empleado;

--2daclase

--ventas anterirores al 1 de febrero  2025

SELECT 
	v.id_venta AS numero_venta ,
	v.fecha AS fecha_venta,
	v.id_cliente cliente
FROM ventas AS v
WHERE v.fecha < '2025-02-15';

--seleccionar todas las ventas desde el primeor de octubre de 2025 en adelante

SELECT 
	v.id_venta AS numero_venta ,
	v.fecha AS fecha_venta,
	v.id_cliente cliente
FROM ventas AS v
WHERE v.fecha >= '2025-10-01';



--COPARACIONES CON EXPRESIONES  CALCULADASS

-- seleccionar los productos cuyo valor del inventario sea mayor a 500000

--valor_inventario = precio * existencia

SELECT 
	p.codigo,
	p.nombre,
	p.precio,
	p.existencia,
	(precio * existencia)  AS valor_inventario

FROM productos AS p
WHERE (precio * existencia) > 50000
ORDER BY valor_inventario DESC;
GO
--desc y default es acendente 
--	((precio + 10)* existencia)/2.0  AS valor_inventario

SELECT 
	p.codigo,
	p.nombre,
	p.precio,
	p.existencia,
	(precio * existencia)  AS valor_inventario

FROM productos AS p
WHERE (precio * existencia) > 50000
ORDER BY (precio * existencia) DESC;
GO


-- 5 (nuemro de columan ) 
SELECT 
	p.codigo,
	p.nombre,
	p.precio,
	p.existencia,
	(precio * existencia)  AS valor_inventario

FROM productos AS p
WHERE (precio * existencia) > 50000
ORDER BY 5 DESC;
GO

SELECT 
	p.codigo,
	p.nombre,
	p.precio,
	p.existencia,
	(precio * existencia)  AS valor_inventario

FROM productos AS p
WHERE (precio * existencia) > 50000
ORDER BY p.precio DESC;
GO




--NOTA: SQL SERVER no reconoce el valor del alias dentro del 
--where en el mismo nivel consulta , esto ocurre por el orden logico 
-- de en que sql server proccsa las partes de una consulta 

-- ORDEN DE EJECUCION 
/*====================================

FROM / JOIN
WHERE 
GROUP BY 
HAVING 
SELECT 
DISTINCT
ORDER BY
TOP 

======================================*/



/*====================================

ORDEN DE ESCRITURA 

SELECT / TOP
FROM/JOIN
WHERE
GROUP BY
HAVING 
ORDER BY 
FROM / JOIN

======================================*/





--OPERADORES LOGICOS

/*======================================
consulta comn operadores logicos
--(not and or)

========================================*/


-- operador logico AND 

/*======================================
condicion 1 |condicion 2 | resultado 
    TRUE       TRUE         TRUE
	TRUE       FLASE        FALSE
	FALSE      TRUE         FALSE
	FALSE      FALSE        FALSE 

========================================*/

--mostrar los productos con precio  entre 200 y 300 que 
-- ademas tengan - de 50 unidades 

SELECT 
	p.codigo,
	p.nombre,
	p.precio,
	p.existencia
FROM productos AS p
WHERE (precio >= 200 
	AND p.precio<=300) 
	AND p.existencia<50;
GO

-- CON NOT 


SELECT 
	p.codigo,
	p.nombre,
	p.precio,
	p.existencia
FROM productos AS p
WHERE NOT(precio >= 200 
	AND p.precio<=300) 
	AND p.existencia<50;
GO

--------CON BETWEEN 
--USA CUANDO HAY RANGO 

SELECT 
	p.codigo,
	p.nombre,
	p.precio,
	p.existencia
FROM productos AS p
WHERE (precio BETWEEN 200 
	AND 300) 
	AND p.existencia<50;
GO

------SELECCIONAR los empleados del deptoo 1
-- cuyo salio sea superior a $25

SELECT 
	e.nombre,
	e.id_empleado,
	e.id_departamento AS Departamento,
	e.salario,
	CONCAT(e.nombre, ' ', 
	e.apellido_paterno, '', 
	e.apellido_materno) AS nombre_completo
FROM empleados AS e
WHERE e.salario > 25.0
AND e.id_departamento=1;
GO


-- Operador logico OR 

/*==========================
	OR requiere que almenos una condicion sea verdadera 
	
	condicion 1 |condicion 2 | resultado 
    TRUE       TRUE         TRUE
	TRUE       FLASE        TRUE
	FALSE      TRUE         TRUE
	FALSE      FALSE        FALSE 
============================*/

--SELECCIONAR los productos con existencia inferior a 10 
-- o superior a $190

SELECT TOP 15
	p.nombre,
	p.id_producto
FROM productos AS p
WHERE p.existencia < 10 
OR p.precio > 190
ORDER BY p.nombre DESC;
GO


-- Operador logico NOT


/*==========================
	NOT niega una condicion 
	
	condicion 1 | Resultado
    TRUE           FALSE
	FALSE          TRUE       
============================*/

-- seleccionar los productos no sea mayor a 400
SELECT
	p.nombre,
	p.id_producto,
	p.precio
FROM productos AS p
WHERE NOT p.precio > 400
ORDER BY p.precio DESC;
GO


-- MOSTRAR LOS PRODUCTOS utilizando not que no se encuentrar dentro del rango 
--de 100 a 400 pesos 
SELECT
	p.nombre,
	p.id_producto,
	p.precio
FROM productos AS p
WHERE NOT p.precio <= 400 
AND p.precio >=100
ORDER BY p.precio DESC;
GO


-- MOSTRAR los empleados de los departamentos 1 o 2 que tengan 
-- salario mayor a $25,000

SELECT 
	e.nombre,
	e.id_empleado
FROM empleados AS e
WHERE e.id_empleado = 1 AND e.id_empleado = 2;


-- Mostrar los empleados de los departamentos 1 o 2 que tengan
-- salario mayor a $25,000

SELECT
    e.id_empleado,
    CONCAT(e.nombre, ' ',
    e.apellido_paterno, ' ',
    e.apellido_materno) AS [nombre_completo],
    e.id_departamento AS departamento,
    e.salario
FROM empleados AS e
WHERE
    (e.id_departamento = 1
    OR e.id_departamento = 2)
    AND e.salario>25000

USE comercial_db;
-- Todo :Instruccion  BETWEEN E IN , LIKE ,COMPARACIONES CON NULL

-- OPERADORES BETWEEN :
-- Permite comprobar si un valor se encuentra en el rango definido

-- sintaxis
-- where columna beetween limite_inferior and limite_superior;


SELECT 
	e.id_empleado,
	e.nombre,
	e.salario
FROM empleados AS e
WHERE e.salario BETWEEN 15000 AND 20000;



SELECT 
	e.id_empleado,
	e.nombre,
	e.salario
FROM empleados AS e
WHERE e.salario >=15000
AND e.salario <=20000;

-- seleccionar las ventas del 1 de enero del 2025 al 
-- 10 de enero del 2025

SELECT  
v.id_venta,
v.fecha,
FORMAT(v.fecha,'MM') AS [Mes en Digito],
FORMAT(v.fecha,'MMM') AS [Nombre Mes],
UPPER(FORMAT(v.fecha,'MMMM','es-ES')) AS [Nombre del Mes en Espanol],
FORMAT(v.fecha,'dd') AS [Dia en Digito],
FORMAT(v.fecha,'dddd') AS [Nombre del Dia en Ingles],
UPPER(FORMAT(v.fecha,'dddd','es-ES')) AS [Nombre del DIA en Espanol],
DATEPART(MONTH,v.fecha) AS [Mes del Año],
v.id_cliente
FROM VENTAS as v
WHERE v.fecha BETWEEN '2025-01-01' AND '2025-01-10';

-- seleccionar los productos que no se encuentre en el rango de precios
SELECT  
p.id_producto,
p.nombre,
p.precio
FROM productos AS p
WHERE precio NOT BETWEEN 100 AND 400;

-- operador in
-- permite comparar una columna con una lista de valores
-- sintaxis : where columna IN (valor_1,valor_2,valor_n);
-- Equivale a varias condicciones OR conectadas

-- Mostrar los productos permanecientes a las categorias 1,7,12

SELECT
	p.id_producto,
	p.nombre,
	p.precio,
	p.id_categoria
FROM productos AS p
WHERE p.id_categoria = 1
OR  p.id_categoria = 7
OR  p.id_categoria = 12;


SELECT
	p.id_producto,
	p.nombre,
	p.precio,
	p.id_categoria
FROM productos AS p
WHERE p.id_categoria IN (1,7,12);

-- seleccionar los datos de los clientes 1,10,25,50,100

SELECT
	c.id_cliente,
	c.nombre,
	c.correo
FROM clientes AS c
WHERE id_cliente IN (1,10,25,50,100);

-- Seleccionar los datos de los departamentos de ventas , TI o direccion 

SELECT
	d.id_departamento AS Numero ,
	d.nombre AS nombre_departamento
FROM departamentos AS d
WHERE d.nombre IN ('Ventas','TI','Dirección');

-- SELECCIONAR TODOS LOS DEPARTAMENTOS QUE NO CORRESPONDAN AL DEPTO 1,2
-- NOT IN 
SELECT
	d.id_departamento AS Numero ,
	d.nombre AS nombre_departamento
FROM departamentos AS d
WHERE d.id_departamento NOT IN (1,2)

SELECT
	d.id_departamento AS Numero ,
	d.nombre AS nombre_departamento
FROM departamentos AS d
WHERE 
	NOT (d.id_departamento =1 
	or d.id_departamento =2);

-- PRECAUCION CON NOT IN Y NULL.
-- Cuando una columna contiene NULL, una comparacion con NOT IN puede comportarse
-- de manera diferente a lo esperado

-- seleccionar todos los empleados sin jefe
SELECT *
FROM empleados;


SELECT 
e.id_jefe, 
e.nombre,
e.apellido_materno,
e.apellido_paterno
FROM empleados AS e
WHERE e.id_jefe IS  NULL;



SELECT 
e.id_jefe, 
e.nombre,
e.apellido_materno,
e.apellido_paterno
FROM empleados AS e
WHERE e.id_jefe NOT IN (1,2,3) OR e.id_jefe IS NULL;

SELECT 
e.id_empleado, 
e.nombre,
e.apellido_materno,
e.apellido_paterno
FROM empleados AS e
WHERE NOT e.id_jefe = 1
	OR e.id_jefe = 2
	OR e.id_jefe = 3
	OR e.id_jefe IS NULL




-- operador like
-- permite buscar patrones dentro de valores de texto

-- sintaxis

-- WHERE columna like 'patron'

-- los patrones son:

-- comodin  significado
-- %  cero,uno o varios caracteres
-- _ Exactamente un caracter 
-- [abc] un caracter incluido en la lista
-- [a-f] un caracter incluido en el rango
-- [^abc] un caracter no incluido en la lista 

-- seleccionar los datos de los productos donde el codigo comience con
-- poo1

select 
*
FROM productos
WHERE codigo LIKE 'P001%'
