-- =============================================
-- Ejercicio 01: Gestión Médica
-- =============================================

USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'gestion_medica')
BEGIN
    ALTER DATABASE gestion_medica SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE gestion_medica;
END
GO

CREATE DATABASE gestion_medica;
GO

USE gestion_medica;
GO

CREATE TABLE paciente (
    num_paciente INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NULL,
    fecha_nacimiento DATE NOT NULL,
    CONSTRAINT pk_paciente PRIMARY KEY (num_paciente)
);
GO

CREATE TABLE expediente (
    num_expediente INT IDENTITY(1,1) NOT NULL,
    fecha_apertura DATE NOT NULL,
    tipo_sangre VARCHAR(5) NOT NULL,
    num_paciente INT NOT NULL,
    CONSTRAINT pk_expediente PRIMARY KEY (num_expediente),
    CONSTRAINT uq_expediente_paciente UNIQUE (num_paciente),
    CONSTRAINT fk_expediente_paciente FOREIGN KEY (num_paciente) REFERENCES paciente (num_paciente)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO
