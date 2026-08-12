-- =============================================
-- Ejercicio 05: Pedidos y Ventas
-- =============================================

USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'ventas')
BEGIN
    ALTER DATABASE ventas SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ventas;
END
GO

CREATE DATABASE ventas;
GO

USE ventas;
GO

CREATE TABLE cliente (
    num_cliente INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (num_cliente)
);
GO

CREATE TABLE pedido (
    numero_pedido INT IDENTITY(1,1) NOT NULL,
    fecha_pedido DATE NOT NULL DEFAULT GETDATE(),
    num_cliente INT NOT NULL,
    CONSTRAINT pk_pedido PRIMARY KEY (numero_pedido),
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (num_cliente)
        REFERENCES cliente (num_cliente)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE producto (
    num_producto INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_producto PRIMARY KEY (num_producto),
    CONSTRAINT uq_producto_nombre UNIQUE (nombre),
    CONSTRAINT ck_producto_precio CHECK (precio > 0)
);
GO

CREATE TABLE pedido_producto (
    numero_pedido INT NOT NULL,
    num_producto INT NOT NULL,
    cantidad_vendida INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_pedido_producto PRIMARY KEY (numero_pedido, num_producto),
    CONSTRAINT fk_pedido_producto_pedido FOREIGN KEY (numero_pedido)
        REFERENCES pedido (numero_pedido)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_pedido_producto_producto FOREIGN KEY (num_producto)
        REFERENCES producto (num_producto)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT ck_pedido_producto_cantidad CHECK (cantidad_vendida > 0),
    CONSTRAINT ck_pedido_producto_precio CHECK (precio > 0)
);
GO