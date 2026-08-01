-- =============================================
-- Ejercicio 02: Control Académico
-- =============================================


CREATE DATABASE Control_Academico;
GO

USE control_Academico;
GO

create table profesor(
numero_profesor int identity(1,1) primary key  not null,
nombre varchar(50) not null,
apellido_paterno varchar(50) not null,
apellido_materno varchar(50)  null
);
GO

create table especialidad(
id_especialidad INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
numero_profesor int foreign key references profesor(numero_profesor),
especialidad_nombre varchar(50)
);

GO

create table curso(
numero_curso int identity(1,1) not null primary key,
nombre_curso varchar(50) not null,
credito int not null,
numero_profesor INT NOT NULL FOREIGN KEY REFERENCES profesor(numero_profesor)
);

GO
