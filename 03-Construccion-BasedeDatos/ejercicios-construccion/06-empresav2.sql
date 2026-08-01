-- =============================================
-- Ejercicio 06: Empresa V2
-- =============================================

create database empresa2;

GO

use empresa2;
GO




create table empleado(
num_employee INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
ssn VARCHAR(11) NOT NULL UNIQUE,                    
nombre VARCHAR(50) NOT NULL,
apellido_materno varchar(50) not null,
apellido_paterno varchar(50) not null,
salario int  not null,
direccion varchar(50) not null,
cumpleanos date not null,
supervisor INT FOREIGN KEY REFERENCES empleado(num_employee) NULL
);
GO


create table dependiente_empleado(
Nombre varchar(50) not null,
Sexo varchar(50) not null,
nacimiento date not null,
empleadoid int foreign key references empleado(num_employee) ,
CONSTRAINT pk_dependiente PRIMARY KEY (empleadoid, Nombre)
);
GO



create table departamento(
numberid INT PRIMARY KEY IDENTITY(1,1),
manages  int foreign key references empleado(num_employee),
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

