-- =============================================
-- Ejercicio 03: Inscripciones
-- =============================================

create database inscripciones;
GO

use inscripciones;
GO

create table alumno(
num_alumno INT IDENTITY(1,1) PRIMARY KEY , 
matricula  VARCHAR(20) UNIQUE NOT NULL,
semestre int not null ,
nombre varchar (50) not null ,
apellido_materno varchar (50) not null,
apellido_paterno varchar (50) not null
);
GO

create table materia(
clave_materia int identity(1,1)  primary key ,
nombre  VARCHAR(100) UNIQUE NOT NULL,
creditos  int not null
);
GO

create table inscribe(
fecha_inscribe DATE  not null,
calificacion DECIMAL(4,2) ,
num_alumno INT NOT NULL FOREIGN KEY REFERENCES alumno(num_alumno),
clave_materia INT NOT NULL FOREIGN KEY REFERENCES materia(clave_materia),
CONSTRAINT pk_inscribe PRIMARY KEY (num_alumno, clave_materia)
);
GO


