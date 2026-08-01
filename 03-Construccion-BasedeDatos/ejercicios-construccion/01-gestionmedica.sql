-- =============================================
-- Ejercicio 01: Gestión Médica
-- =============================================

CREATE DATABASE gestion_medica;
USE gestion_medica;


CREATE TABLE paciente (
num_paciente int IDENTITY(1,1)  NOT NULL PRIMARY KEY,
nombre varchar (50)  NOT NULL,
apellido_paterno varchar (50) not null,
apellido_materno varchar (50)  null,

fecha_nacimiento Date not null
);
GO


CREATE TABLE expediente(
num_expediente int IDENTITY(1,1) NOT NULL PRIMARY KEY ,
fecha_apertura date NOT NULL ,
tipo_sangre varchar(5) not null,
num_paciente int  NOT NULL  UNIQUE  FOREIGN KEY 
REFERENCES paciente(num_paciente)
);
GO