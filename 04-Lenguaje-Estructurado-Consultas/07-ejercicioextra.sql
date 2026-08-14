-- Seleccionar la base de datos
USE NORTHWND;

-- Mostrar los clientes de mexico o de alemania y ademas que sean solo de Stuttgart
SELECT 
	c.CustomerID,
	c.CompanyName,
	c.Region,
	c.City,
	c.Country 
FROM Customers AS c
WHERE c.Country ='Mexico'
	OR
	c.Country='Germany' 
	AND c.Country ='Stuttgart' ;

	SELECT 
	c.CustomerID,
	c.CompanyName,
	c.Region,
	c.City,
	c.Country 
FROM Customers AS c
WHERE c.Country IN ('Mexico','Germany') 

-- Mostrar las ventas realizadas en francia , brazil y belgica
-- de 10 de julio de 1996 a 31 de diciembre de 1998 , que tengan Region de Envio,
-- para los clientes VICTE,HANAR,SUPRF, y ordenados por fecha de pedido
-- de la mas cercana a la mas antigua

SELECT 
o.OrderID AS [numero_order],
o.CustomerID AS [cliente],
o.ShipAddress AS [pais_envio],
o.OrderDate AS [fecha_pedido],
UPPER(FORMAT (o.OrderDate,'MMMM','es-ES')) AS [mes_pedido],
UPPER(FORMAT (o.OrderDate,'dddd','es-ES')) AS [dia_pedido],
DATEPART(YEAR,o.OrderDate) AS [año_pedido]
FROM Orders AS o
WHERE o.ShipCountry IN ('France','Brazil','Gelgium')
AND
o.OrderDate BETWEEN '1996-07-10' AND '1998-12-31'
AND o.ShipRegion IS NOT NULL
AND
o.CustomerID IN ('VICTE','HANAR','SUPRF')
ORDER BY o.OrderDate DESC;
SELECT * FROM Orders AS o;