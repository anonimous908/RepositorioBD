-- Restricción Default
USE universidad;
CREATE TABLE categoria (
categoria_id INT NOT NULL IDENTITY  (1,1) PRIMARY KEY,
nombre VARCHAR(30) NOT NULL UNIQUE,
activo BIT DEFAULT 1
);
GO

CREATE TABLE categoria (
categoria_id INT NOT NULL IDENTITY  (1,1)
CONSTRAINT pk_categoria
PRIMARY KEY,
nombre VARCHAR(30) NOT NULL
CONSTRAINT uq_categoria_nombre
UNIQUE,
activo BIT
CONSTRAINT df_categoria_activo
DEFAULT 1
);
GO

CREATE TABLE categoria (
categoria_id INT NOT NULL IDENTITY  (1,1),
nombre VARCHAR(30) NOT NULL,
activo BIT
CONSTRAINT df_categoria_activo
DEFAULT 1,
CONSTRAINT pk_categoria
PRIMARY KEY (categoria_id),
CONSTRAINT uq_categoria_nombre
UNIQUE  (nombre)
);
GO

DROP TABLE categoria;

INSERT INTO categoria
VALUES ('Carnes Frias', 1);

INSERT INTO categoria
VALUES ('Carnes Calientes', DEFAULT);

INSERT INTO categoria (nombre)
VALUES ('Chocho');

-- Restriccón Check
-- Opción de construcción 1

CREATE TABLE producto (
producto_id INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(20) NOT NULL UNIQUE,
precio DECIMAL(10,2) NOT NULL CHECK (precio>0),
existencia INT NOT NULL CHECK (existencia > 0 AND existencia<=100),
activo BIT NOT NULL DEFAULT 1
);
GO

INSERT INTO producto (nombre, precio, existencia, activo)
VALUES ('Pitufo', 200, 99, 0);

INSERT INTO producto (nombre, precio, existencia, activo)
VALUES ('Quemadita', 200, 100, DEFAULT);

INSERT INTO producto (nombre, existencia, precio)
VALUES ('Pantera Rosa', 47, 80);

SELECT *
FROM producto;
DROP TABLE producto;

--Opción de construcción 2

CREATE TABLE producto (
producto_id INT IDENTITY(1,1)
CONSTRAINT pk_producto
PRIMARY KEY,
nombre VARCHAR(20) NOT NULL
CONSTRAINT uq_producto_nombre
UNIQUE,
precio DECIMAL(10,2) NOT NULL 
CONSTRAINT ck_producto_precio
CHECK (precio>0),
existencia INT NOT NULL 
CONSTRAINT ck_producto_existencia
CHECK (existencia > 0 AND existencia<=100),
activo BIT NOT NULL
DEFAULT 1
);
GO

--Opción de construcción 3
CREATE TABLE producto (
producto_id INT NOT NULL,
nombre VARCHAR(20) NOT NULL,
descripcion VARCHAR(80),
precio DECIMAL(10, 2) NOT NULL,
existencia INT NOT NULL,
activo BIT NOT NULL
CONSTRAINT df_producto_activo
DEFAULT 1,
-- Restricción PK
CONSTRAINT pk_producto
PRIMARY KEY(producto_id),
--Restricción UNIQUE
CONSTRAINT uq_producto_nombre
UNIQUE(NOMBRE),
--Restricción check precio
CONSTRAINT ck_producto_precio
CHECK (precio>0),
-- Restricción check existencia
CONSTRAINT ck_producto_existencia
CHECK (existencia BETWEEN 1 AND 100)
);
GO

INSERT INTO producto (producto_id, nombre, descripcion, precio, existencia, activo)
VALUES (1, 'Pitufo', NULL, 200, 99, 0);

INSERT INTO producto (producto_id, nombre, descripcion, precio, existencia, activo)
VALUES (2, 'Quemadita', NULL, 200, 100, DEFAULT);

INSERT INTO producto (producto_id, nombre, existencia, precio)
VALUES (3, 'Pantera Rosa', 47, 80);

SELECT * FROM producto;


--- Crear una base de datos para empresa patito 
-- Crear la BD

CREATE DATABASE empresa_patito;
GO

--Usar la BD
USE empresa_patito;
GO

-- Restriccion de FK
CREATE TABLE proveedor (
proveedor_id INT NOT NULL IDENTITY(1, 1),
empresa VARCHAR (35) NOT NULL,
direccion VARCHAR (80) NULL,
limite_credito DECIMAL (10, 2) NOT NULL,
--- PRIMARY KEY
CONSTRAINT pk_proveedor
PRIMARY KEY (proveedor_id),
-- UNIQUE
CONSTRAINT uq_proveedor_empresa
UNIQUE (empresa),
-- CHECK LIMITE RECIDTO
CONSTRAINT ck_proveedor_limite_credito
CHECK (limite_credito >0.0 AND limite_credito <=100000)
);
GO

CREATE TABLE producto (
fabricante_id CHAR(3) NOT NULL,
producto_id INT NOT NULL,
nombre VARCHAR (20) NOT NULL
CONSTRAINT uq_producto_nombre
UNIQUE,
stock INT NOT NULL
CONSTRAINT ck_producto_stock
CHECK (stock BETWEEN 1 AND 100),
precio DECIMAL (10, 2) NOT NULL
CONSTRAINT ck_producto_precio 
CHECK (precio > 0.0),
activo BIT NOT NULL 
CONSTRAINT df_producto_activo
DEFAULT 1,
proveedor_id INT NOT NULL,
CONSTRAINT pk_producto
PRIMARY KEY (fabricante_id, producto_id),
CONSTRAINT fk_producto_proveeor
FOREIGN KEY (proveedor_id)
REFERENCES proveedor (proveedor_id)
);

-- Restricción Default
USE universidad;
CREATE TABLE categoria (
categoria_id INT NOT NULL IDENTITY  (1,1) PRIMARY KEY,
nombre VARCHAR(30) NOT NULL UNIQUE,
activo BIT DEFAULT 1
);
GO

CREATE TABLE categoria (
categoria_id INT NOT NULL IDENTITY  (1,1)
CONSTRAINT pk_categoria
PRIMARY KEY,
nombre VARCHAR(30) NOT NULL
CONSTRAINT uq_categoria_nombre
UNIQUE,
activo BIT
CONSTRAINT df_categoria_activo
DEFAULT 1
);
GO

CREATE TABLE categoria (
categoria_id INT NOT NULL IDENTITY  (1,1),
nombre VARCHAR(30) NOT NULL,
activo BIT
CONSTRAINT df_categoria_activo
DEFAULT 1,
CONSTRAINT pk_categoria
PRIMARY KEY (categoria_id),
CONSTRAINT uq_categoria_nombre
UNIQUE  (nombre)
);
GO

DROP TABLE categoria;

INSERT INTO categoria
VALUES ('Carnes Frias', 1);

INSERT INTO categoria
VALUES ('Carnes Calientes', DEFAULT);

INSERT INTO categoria (nombre)
VALUES ('Chocho');

-- Restriccón Check
-- Opción de construcción 1

CREATE TABLE producto (
producto_id INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(20) NOT NULL UNIQUE,
precio DECIMAL(10,2) NOT NULL CHECK (precio>0),
existencia INT NOT NULL CHECK (existencia > 0 AND existencia<=100),
activo BIT NOT NULL DEFAULT 1
);
GO

INSERT INTO producto (nombre, precio, existencia, activo)
VALUES ('Pitufo', 200, 99, 0);

INSERT INTO producto (nombre, precio, existencia, activo)
VALUES ('Quemadita', 200, 100, DEFAULT);

INSERT INTO producto (nombre, existencia, precio)
VALUES ('Pantera Rosa', 47, 80);

SELECT *
FROM producto;
DROP TABLE producto;

--Opción de construcción 2

CREATE TABLE producto (
producto_id INT IDENTITY(1,1)
CONSTRAINT pk_producto
PRIMARY KEY,
nombre VARCHAR(20) NOT NULL
CONSTRAINT uq_producto_nombre
UNIQUE,
precio DECIMAL(10,2) NOT NULL 
CONSTRAINT ck_producto_precio
CHECK (precio>0),
existencia INT NOT NULL 
CONSTRAINT ck_producto_existencia
CHECK (existencia > 0 AND existencia<=100),
activo BIT NOT NULL
DEFAULT 1
);
GO

--Opción de construcción 3
CREATE TABLE producto (
producto_id INT NOT NULL,
nombre VARCHAR(20) NOT NULL,
descripcion VARCHAR(80),
precio DECIMAL(10, 2) NOT NULL,
existencia INT NOT NULL,
activo BIT NOT NULL
CONSTRAINT df_producto_activo
DEFAULT 1,
-- Restricción PK
CONSTRAINT pk_producto
PRIMARY KEY(producto_id),
--Restricción UNIQUE
CONSTRAINT uq_producto_nombre
UNIQUE(NOMBRE),
--Restricción check precio
CONSTRAINT ck_producto_precio
CHECK (precio>0),
-- Restricción check existencia
CONSTRAINT ck_producto_existencia
CHECK (existencia BETWEEN 1 AND 100)
);
GO

INSERT INTO producto (producto_id, nombre, descripcion, precio, existencia, activo)
VALUES (1, 'Pitufo', NULL, 200, 99, 0);

INSERT INTO producto (producto_id, nombre, descripcion, precio, existencia, activo)
VALUES (2, 'Quemadita', NULL, 200, 100, DEFAULT);

INSERT INTO producto (producto_id, nombre, existencia, precio)
VALUES (3, 'Pantera Rosa', 47, 80);

SELECT * FROM producto;


--- Crear una base de datos para empresa patito 
-- Crear la BD

CREATE DATABASE empresa_patito;
GO

--Usar la BD
USE empresa_patito;
GO

-- Restriccion de FK
CREATE TABLE proveedor (
proveedor_id INT NOT NULL IDENTITY(1, 1),
empresa VARCHAR (35) NOT NULL,
direccion VARCHAR (80) NULL,
limite_credito DECIMAL (10, 2) NOT NULL,
--- PRIMARY KEY
CONSTRAINT pk_proveedor
PRIMARY KEY (proveedor_id),
-- UNIQUE
CONSTRAINT uq_proveedor_empresa
UNIQUE (empresa),
-- CHECK LIMITE RECIDTO
CONSTRAINT ck_proveedor_limite_credito
CHECK (limite_credito >0.0 AND limite_credito <=100000)
);
GO

CREATE TABLE producto (
fabricante_id CHAR(3) NOT NULL,
producto_id INT NOT NULL,
nombre VARCHAR (20) NOT NULL
CONSTRAINT uq_producto_nombre
UNIQUE,
stock INT NOT NULL
CONSTRAINT ck_producto_stock
CHECK (stock BETWEEN 1 AND 100),
precio DECIMAL (10, 2) NOT NULL
CONSTRAINT ck_producto_precio 
CHECK (precio > 0.0),
activo BIT NOT NULL 
CONSTRAINT df_producto_activo
DEFAULT 1,
proveedor_id INT NOT NULL,
CONSTRAINT pk_producto
PRIMARY KEY (fabricante_id, producto_id),
CONSTRAINT fk_producto_proveeor
FOREIGN KEY (proveedor_id)
REFERENCES proveedor (proveedor_id)
);

-- INTEGRIDADES REFERENCIALES ON DELETE Y ON UPDATE
-- NO ACTION, CASCADE, SET NULL, SET DEFAULT

CREATE DATABASE construccion;
GO

USE construccion;
GO

-- NO ACTION

CREATE TABLE cliente(
cliente_id INT
CONSTRAINT pk_cliente
PRIMARY KEY,
empresa VARCHAR(20)
CONSTRAINT uq_cliente_empresa
UNIQUE,
direccion VARCHAR(50) NOT NULL,
tel VARCHAR(15) NOT NULL,
activo BIT NOT NULL,
created_at DATETIME2 NOT NULL
CONSTRAINT df_cliente_created_at
DEFAULT SYSDATETIME (),
updated_at DATETIME NOT NULL
DEFAULT SYSDATETIME ()
);
GO


CREATE TABLE telefono(
telefono_id INT IDENTITY (1, 1),
numero_telefono VARCHAR(15) NOT NULL,
created_at DATETIME2 NOT NULL
CONSTRAINT df_telefono_created_at
DEFAULT SYSDATETIME(),
updated_at DATETIME2 NOT NULL
CONSTRAINT df_telefono_updated_at
DEFAULT SYSDATETIME(),
cliente_id INT,
CONSTRAINT pk_telefono
PRIMARY KEY (telefono_id),
CONSTRAINT uq_telefono_numero_telefono
UNIQUE (numero_telefono),
CONSTRAINT ck_telefono_numero_telefono
CHECK (numero_telefono LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
);
GO



-- Actualizar en on UPDATE CASCADE
UPDATE cliente 
SET cliente_id = 10 
WHERE cliente_id=1;
-- TODO : EXPLICAR ON DELETE BY ON UPDATE 

-- TODO : EXPLICAR ON DELETE BY ON UPDATE 

CREATE TABLE telefono(
telefono_id INT IDENTITY (1, 1),
numero_telefono VARCHAR(15) NOT NULL,
created_at DATETIME2 NOT NULL
CONSTRAINT df_telefono_created_at
DEFAULT SYSDATETIME(),
updated_at DATETIME2 NOT NULL
CONSTRAINT df_telefono_updated_at
DEFAULT SYSDATETIME(),
cliente_id INT,
CONSTRAINT pk_telefono
PRIMARY KEY (telefono_id),
CONSTRAINT uq_telefono_numero_telefono
UNIQUE (numero_telefono),
CONSTRAINT ck_telefono_numero_telefono
CHECK (numero_telefono LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
CONSTRAINT fk_telefono_cliente
FOREIGN KEY(cliente_id)
REFERENCES cliente(cliente_id)
ON DELETE  SET NULL
ON UPDATE CASCADE
);
GO


DELETE FROM cliente
WHERE cliente_id =11;

UPDATE cliente
SET cliente_id = 15
WHERE cliente_id = 3;


SELECT * FROM cliente;
SELECT * FROM telefono;

-- ON DELETE Y ON UPDATE 
DROP TABLE telefono;
CREATE TABLE telefono(
telefono_id INT IDENTITY (1, 1),
numero_telefono VARCHAR(15) NOT NULL,
created_at DATETIME2 NOT NULL
CONSTRAINT df_telefono_created_at
DEFAULT SYSDATETIME(),
updated_at DATETIME2 NOT NULL
CONSTRAINT df_telefono_updated_at
DEFAULT SYSDATETIME(),
cliente_id INT
CONSTRAINT df_telefono_cliente_id
DEFAULT 0,
CONSTRAINT pk_telefono
PRIMARY KEY (telefono_id),
CONSTRAINT uq_telefono_numero_telefono
UNIQUE (numero_telefono),
CONSTRAINT ck_telefono_numero_telefono
CHECK (numero_telefono LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
CONSTRAINT fk_telefono_cliente
FOREIGN KEY(cliente_id)
REFERENCES cliente(cliente_id)
ON DELETE  SET DEFAULT
ON UPDATE SET DEFAULT
);
GO

INSERT INTO telefono (numero_telefono,cliente_id)
VALUES  ('111-345-3456',10),
		('211-345-3456',10),
		('131-345-3456',10),
		('151-345-3456',15);

		SELECT * FROM cliente;