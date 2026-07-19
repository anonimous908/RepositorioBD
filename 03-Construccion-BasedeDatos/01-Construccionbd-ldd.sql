-- Crea una base de datos
CREATE DATABASE universidad;
GO

-- Utilizar la base de datos
USE universidad;
GO

-- Crear una tabla 
CREATE TABLE alumno (
 alumno_id INT, 
 nombre VARCHAR (100), 
 edad INT
);
GO

CREATE TABLE alumno_2(
	alumno_id INT, 
	nombre VARCHAR (100), 
	apellido_paterno VARCHAR(50), 
	apellido_materno VARCHAR (50), 
	fecha_nacimiento DATE, 
	correo VARCHAR (45) 
);
GO

-- Restricciones

CREATE TABLE alumno_3 (
	alumno_id INT PRIMARY KEY, 
	nombre VARCHAR(100), 
	correo VARCHAR(40)
);
GO

CREATE TABLE alumno_4 (
	alumno_id INT NOT NULL, 
	nombre VARCHAR(100), 
	correo VARCHAR(40),
	CONSTRAINT pk_alumno_4
	PRIMARY KEY (alumno_id)
);
GO

INSERT INTO alumno_4
VALUES (1, 'Panfilo', 'correo@correo.com');

INSERT INTO alumno_4
VALUES (2, 'Monico', 'correo2@correo.com');


-- Primary key con IDENTITY

CREATE TABLE profesor (
	profesor_id INT NOT NULL IDENTITY (1, 1),
	nombre VARCHAR(50) NOT NULL,
	edad INT NULL, 
	CONSTRAINT pk_profesor 
	PRIMARY KEY ( profesor_id )
);
GO

INSERT INTO profesor
VALUES ('German', 29), 
       ('Maricha', 22);

SELECT * 
FROM profesor;

-- restricci�n Unique
CREATE TABLE materia(
	materia_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
	correo VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE materia_2(
	materia_id INT NOT NULL IDENTITY(1,1), 
	correo VARCHAR(50) NOT NULL, 
	CONSTRAINT pk_materia_2
	PRIMARY KEY (materia_id), 
	CONSTRAINT uq_materia_2_correo
	UNIQUE (correo)
);
GO

INSERT INTO materia_2
VALUES ('correo@correo.com');

INSERT INTO materia_2
VALUES('correo2@correo.com');

-- Restricción Default 

CREATE TABLE categoria (
	categoria_id INT NOT NULL IDENTITY (1,1) PRIMARY KEY, 
	nombre VARCHAR(30) NOT NULL UNIQUE, 
	activo BIT DEFAULT 1
);
GO

CREATE TABLE categoria (
	categoria_id INT NOT NULL IDENTITY (1,1) 
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
	categoria_id INT NOT NULL IDENTITY (1,1), 
	nombre VARCHAR(30) NOT NULL,
	activo BIT 
	CONSTRAINT df_categoria_activo
	DEFAULT 1, 
	CONSTRAINT pk_categoria
	PRIMARY KEY (categoria_id), 
	CONSTRAINT uq_categoria_nombre
	UNIQUE (nombre)
);
GO

DROP TABLE categoria;

INSERT INTO categoria
VALUES ('Carnes Frias', 1);

INSERT INTO categoria
VALUES ('Carnes Calientes', DEFAULT);

INSERT INTO categoria (nombre)
VALUES ('Chochos');

-- Restricción Check 
-- Opción de construcción 1

CREATE TABLE producto (
   producto_id INT IDENTITY(1,1) PRIMARY KEY, 
   nombre VARCHAR(20) NOT NULL UNIQUE,
   precio DECIMAL (10, 2) NOT NULL CHECK (precio>0), 
   existencia INT NOT NULL CHECK (existencia > 0  AND existencia<=100), 
   activo BIT NOT NULL DEFAULT 1
);
GO


-- Opción de construcción 2

CREATE TABLE producto (
   producto_id INT IDENTITY(1,1) 
   CONSTRAINT pk_producto
   PRIMARY KEY, 
   nombre VARCHAR(20) NOT NULL 
   CONSTRAINT uq_producto_nombre
   UNIQUE,
   precio DECIMAL (10, 2) NOT NULL 
   CONSTRAINT ck_producto_precio
   CHECK (precio>0), 
   existencia INT NOT NULL 
   CONSTRAINT ck_producto_existencia
   CHECK (existencia > 0  AND existencia<=100), 
   activo BIT NOT NULL 
   CONSTRAINT df_producto_activo
   DEFAULT 1
);
GO

-- Opción de construcción 3
CREATE TABLE producto (
	producto_id INT NOT NULL, 
	nombre VARCHAR (20) NOT NULL, 
	descripcion VARCHAR(80), 
	precio DECIMAL(10, 2) NOT NULL, 
	existencia INT NOT NULL, 
	activo BIT NOT NULL
	CONSTRAINT df_producto_activo
	DEFAULT 1, 
	-- Restricción PK
	CONSTRAINT pk_producto
	PRIMARY KEY(producto_id), 
	-- Restricción UNIQUE
	CONSTRAINT uq_producto_nombre
	UNIQUE (nombre),
	-- Restricción check precio
	CONSTRAINT ck_producto_precio
	CHECK (precio>0.0),
	-- Restricción check existencia
	CONSTRAINT ck_producto_existencia
	CHECK (existencia BETWEEN 1 AND 100)
);
GO


DROP TABLE producto;
GO


INSERT INTO producto
VALUES (1, 'Pitufo',NULL ,200, 99, 0);

INSERT INTO producto
VALUES (2, 'Quemadita',NULL ,200, 100, DEFAULT);

INSERT INTO producto (producto_id, nombre, existencia, precio)
VALUES (3,'Pantera Rosa', 47, 80);


SELECT *
FROM producto;


-- CREAR UNA BASE DE DATOS PARA EMPRESA PATITO

-- CREAR LA BD

CREATE DATABASE empresa_patito;
GO

-- USAR LA BASE DE DATOS
USE empresa_patito;
GO

-- RESTRICCIÓN DE FOREIGN KEY 
CREATE TABLE proveedor (
	proveedor_id INT NOT NULL IDENTITY(1,1),
	empresa VARCHAR(35) NOT NULL, 
	direccion VARCHAR (80) NULL, 
	limite_credito DECIMAL (10,2) NOT NULL, 
	-- PRIMARY KEY
	CONSTRAINT pk_proveedor 
	PRIMARY KEY(proveedor_id),
	-- UNIQUE
	CONSTRAINT uq_proveedor_empresa
	UNIQUE (empresa),
	-- CHECK limite_credito
	CONSTRAINT ck_proveedor_limite_credito
	CHECK (limite_credito > 0.0 AND limite_credito <= 100000)
);
GO

CREATE TABLE producto (
	fabricante_id CHAR(3) NOT NULL, 
	producto_id INT NOT NULL,
	nombre VARCHAR(20) NOT NULL
	CONSTRAINT uq_producto_nombre 
	UNIQUE, 
	stock INT NOT NULL
	CONSTRAINT ck_producto_stock
	CHECK (stock BETWEEN 1 AND 100), 
	precio DECIMAL (10,2) NOT NULL
	CONSTRAINT ck_producto_precio
	CHECK (precio > 0.0),
	activo BIT NOT NULL 
	CONSTRAINT df_producto_activo
	DEFAULT 1, 
	proveedor_id INT NOT NULL,
	CONSTRAINT pk_producto
	PRIMARY KEY (fabricante_id, producto_id),
	CONSTRAINT fk_producto_proveedor
	FOREIGN KEY (proveedor_id)
	REFERENCES proveedor (proveedor_id)
);
GO

-- INTEGRIDADES REFERENCIALES ON DELETE Y ON UPDATE 
-- NO ACTION, CASCADE, SET NULL, SET DEFAULT

CREATE DATABASE construccion;
GO

USE construccion;
GO

-- NO ACTION 

CREATE TABLE cliente (
	cliente_id INT
	CONSTRAINT pk_cliente
	PRIMARY KEY, 
	empresa	VARCHAR(20)
	CONSTRAINT uq_cliente_empresa
	UNIQUE, 
	direccion VARCHAR(50), 
	tel VARCHAR(15) NOT NULL, 
	activo BIT NOT NULL, 
	created_at DATETIME2 NOT NULL
	CONSTRAINT df_cliente_created_at
	DEFAULT SYSDATETIME (), 
	updated_at DATETIME2 NOT NULL
	DEFAULT SYSDATETIME ()
);
GO 


CREATE TABLE telefono (
	telefono_id INT IDENTITY (1,1), 
	numero_telefono VARCHAR (15) NOT NULL, 
	created_at DATETIME2  NOT NULL
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
	FOREIGN KEY (cliente_id)
	REFERENCES cliente (cliente_id)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION 
);
GO 

DROP TABLE telefono;


INSERT INTO cliente
VALUES (1, 'Patito de Hule', NULL, '773-def-123', 1, DEFAULT, DEFAULT );


INSERT INTO cliente (cliente_id, empresa, tel, activo)
VALUES (2, 'Taqueria Mr. Linux', '7731234567', 1);


INSERT INTO telefono (numero_telefono, cliente_id)
VALUES ('111-345-2347', 1);

INSERT INTO telefono (numero_telefono, cliente_id)
VALUES ('111-345-3456', 1), 
       ('455-678-1234', 1), 
	   ('123-768-2345', 1), 
	   ('773-146-2476', 2);



-- Eliminar con ON DELETE EN NO ACTION 

-- eLIMINAN LOS HIJOS
DELETE FROM telefono
WHERE cliente_id = 1;

-- Elimina el padre
DELETE FROM cliente
WHERE cliente_id = 1;

SELECT * FROM cliente;
SELECT * FROM telefono;


-- Actualizar ON UPDATE en NO Action

-- Actualiza el hijo (poniendolo en nulo)
UPDATE telefono 
SET cliente_id = NULL
WHERE cliente_id = 2;

-- Actualiza el padre 
UPDATE cliente
SET cliente_id = 3
WHERE cliente_id = 2;

-- Actualiza el hijo con el nuevo id del padre
UPDATE telefono 
SET cliente_id = 3
WHERE cliente_id IS NULL;

SELECT * FROM cliente;
SELECT * FROM telefono;


-- Integridad Referencial ON DELETE Y ON UPDATE CASCADE

CREATE TABLE cliente (
	cliente_id INT
	CONSTRAINT pk_cliente
	PRIMARY KEY, 
	empresa	VARCHAR(20)
	CONSTRAINT uq_cliente_empresa
	UNIQUE, 
	direccion VARCHAR(50), 
	tel VARCHAR(15) NOT NULL, 
	activo BIT NOT NULL, 
	created_at DATETIME2 NOT NULL
	CONSTRAINT df_cliente_created_at
	DEFAULT SYSDATETIME (), 
	updated_at DATETIME2 NOT NULL
	DEFAULT SYSDATETIME ()
);
GO 


CREATE TABLE telefono (
	telefono_id INT IDENTITY (1,1), 
	numero_telefono VARCHAR (15) NOT NULL, 
	created_at DATETIME2  NOT NULL
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
	FOREIGN KEY (cliente_id)
	REFERENCES cliente (cliente_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE 
);
GO 

SELECT * FROM cliente;
SELECT * FROM telefono;


-- ELIMINAR EN ON DELETE CASCADE

-- Elminar al padre

DELETE FROM cliente
WHERE cliente_id = 1;

-- ACTUALIZAR EN ON UPDATE CASCADE
UPDATE cliente
SET cliente_id = 10
WHERE cliente_id = 1;


DROP TABLE telefono;

-- ON DELETE Y ON UPDATE SET NULL
CREATE TABLE telefono (
	telefono_id INT IDENTITY (1,1), 
	numero_telefono VARCHAR (15) NOT NULL, 
	created_at DATETIME2  NOT NULL
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
	FOREIGN KEY (cliente_id)
	REFERENCES cliente (cliente_id)
	ON DELETE SET NULL
	ON UPDATE SET NULL
);
GO 



INSERT INTO cliente (cliente_id,empresa,tel, activo)
VALUES (11,'Bimbo', '566788999', 1);

INSERT INTO telefono (numero_telefono, cliente_id)
VALUES ('111-345-2347', 11);

INSERT INTO telefono (numero_telefono, cliente_id)
VALUES ('111-345-3456', 11), 
       ('455-678-1234', 11), 
	   ('123-768-2345', 11), 
	   ('773-146-2476', 3);

DELETE FROM cliente 
WHERE cliente_id = 11;

UPDATE cliente
SET cliente_id = 15
WHERE cliente_id = 3;

SELECT * 
FROM cliente;

SELECT *
FROM telefono;

-- ON DELETE Y ON UPDATE SET NULL
DROP TABLE telefono;
GO

CREATE TABLE telefono (
	telefono_id INT IDENTITY (1,1), 
	numero_telefono VARCHAR (15) NOT NULL, 
	created_at DATETIME2  NOT NULL
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
	FOREIGN KEY (cliente_id)
	REFERENCES cliente (cliente_id)
	ON DELETE SET DEFAULT
	ON UPDATE SET DEFAULT
);
GO 

INSERT INTO cliente (cliente_id,empresa,tel, activo)
VALUES (0,'mostrador', '66669147', 1);	

INSERT INTO telefono (numero_telefono, cliente_id)
VALUES ('111-345-2347', 10);

INSERT INTO telefono (numero_telefono, cliente_id)
VALUES ('111-345-3456', 10), 
       ('455-678-1234', 10), 
	   ('123-768-2345', 10), 
	   ('773-146-2476', 15);

DELETE FROM cliente
WHERE cliente_id = 10;

UPDATE cliente
SET cliente_id = 17
WHERE cliente_id = 15;

SELECT * 
FROM cliente;

SELECT *
FROM telefono;