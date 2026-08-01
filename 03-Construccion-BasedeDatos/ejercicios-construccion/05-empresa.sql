-- =============================================
-- Ejercicio 05: Empresa V1
-- =============================================


create database empresa1;

GO

use empresa1;
GO

create table empleado(
ssn int primary key not null identity(1,1),
nombre varchar(50) not null,
apellido_materno varchar(50) not null,
apellido_paterno varchar(50) not null,
salario int  not null,
direccion varchar(50) not null,
cumpleanos date not null,
supervisor int foreign key references empleado(ssn) null
);
GO


create table dependiente_empleado(
Nombre varchar(50) not null,
Sexo varchar(50) not null,
nacimiento date not null,
empleadoid int foreign key references empleado(ssn) ,
CONSTRAINT pk_dependiente PRIMARY KEY (empleadoid, Nombre)
);
GO



create table departamento(
numberid INT PRIMARY KEY IDENTITY(1,1),
manages  int foreign key references empleado(ssn),
);
GO


create table ubicacion(
nombre_ubicacion int  foreign key references departamento(numberid),
ubicacion varchar(50)     
);
GO




create table proyectos(
number int ,
nombre varchar(50),
departamento_id INT FOREIGN KEY REFERENCES departamento(numberid)
);
GO



