/*======================================
  Inner Join 
 que es un join?
 un join permite combinar informacion de
 2 o mas tablas en una sola consulta, 
 basandose en una columna que sea comun entre ellas.
======================================*/


USE   Northwind;

SELECT
Productid AS [numero_producto],
ProductName AS [nombre_producto],
UnitPrice AS [precio],
UnitsInStock AS [existencia],
(p.UnitPrice * p.UnitsInStock) AS [valor_inventario],
c.CategoryID AS [numero_categoria],
c.CategoryName AS [nombre_categoria],
s.CompanyName AS [nombre_proveedor]
FROM Products AS p
INNER JOIN 
Categories AS c 
On c.CategoryID = p.CategoryID
INNER JOIN Suppliers AS s
ON s.SupplierID = p.SupplierID
WHERE p.UnitsInStock <> 0
AND 
c.CategoryName IN ('SeaFood' ,'Confections','Beverages')
AND 
p.ProductName LIKE 'C%'
ORDER BY  [valor_inventario] ASC;

-- seleccionar los datos de los clientes que han hecho pedidos
-- mostrando el numero de cliente , el nombre del cliente(companyname)
-- numero de orden y la fecha de orden

Select 
	o.OrderID AS [numero_orden],
	o.OrderDate AS [fecha_order],
	UPPER(FORMAT(o.OrderDate,'MMMM','es-ES')) AS [mes_orden],
	UPPER(FORMAT(o.OrderDate,'dddd','es-ES')) AS [dia_orden],
	DATEPART(YEAR , o.OrderDate) AS [ano_orden],
	o.CustomerID AS [numero_cluente],
	UPPER(c.CompanyName) AS [nombre_cliente]
	FROM Orders AS o
	INNER JOIN 
	Customers AS c
	ON c.CustomerID = o.CustomerID;

	-- seleccionar  ademas del cliente al que se vendieron los productos ,
	-- queremos saber el nombre del empleado en formato fullname que atendio
	-- el pedido




	Select 
	o.OrderID AS [numero_orden],
	o.OrderDate AS [fecha_order],
	UPPER(FORMAT(o.OrderDate,'MMMM','es-ES')) AS [mes_orden],
	UPPER(FORMAT(o.OrderDate,'dddd','es-ES')) AS [dia_orden],
	DATEPART(YEAR , o.OrderDate) AS [ano_orden],
	o.CustomerID AS [numero_cluente],
	UPPER(c.CompanyName) AS [nombre_cliente],
	CONCAT (e.FirstName ,'' e,LastName) AS [nombre_completo]
	FROM Orders AS o
	INNER JOIN 
	Customers AS c
	ON c.CustomerID = o.CustomerID
	INNER JOIN Employees AS e
	ON o.EmployeeID = e.EmployeeID;