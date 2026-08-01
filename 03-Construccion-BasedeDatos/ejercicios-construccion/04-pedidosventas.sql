-- =============================================
-- Ejercicio 04: Pedidos y Ventas
-- =============================================

create database ventas;

GO

use ventas;
GO

create table cliente(
numcliente int identity(1,1) primary key , 
nombre varchar(50) not null ,
apellido_paterno varchar(50) not null ,
apellido_materno varchar(50) not null 
);
GO

create table pedido(
fecha_pedido date ,
numero_pedido INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
numcliente int foreign key references cliente(numcliente)
);
GO



create table producto(
num_producto INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
precio int ,
nombre varchar(50) 
);
GO

create table pedido_producto(
numero_pedido INT NOT NULL FOREIGN KEY REFERENCES pedido(numero_pedido),
producto int foreign key references producto(num_producto),
cantitadvendida int not null ,
precio int ,
CONSTRAINT pk_pedido_producto PRIMARY KEY (numero_pedido, producto)

);
GO