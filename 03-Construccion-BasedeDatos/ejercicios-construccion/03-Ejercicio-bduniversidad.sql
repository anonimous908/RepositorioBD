-- =============================================
-- Ejercicio 03: Control Académico (Universidad)
-- =============================================


CREATE DATABASE control_academico;
GO

USE control_academico;
GO

CREATE TABLE profesor (
    numero_profesor INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NULL,
    especialidad VARCHAR(100) NULL,
    CONSTRAINT pk_profesor PRIMARY KEY (numero_profesor)
);
GO

CREATE TABLE curso (
    numero_curso INT IDENTITY(1,1) NOT NULL,
    nombre_curso VARCHAR(100) NOT NULL,
    creditos INT NOT NULL,
    numero_profesor INT NOT NULL,
    CONSTRAINT pk_curso PRIMARY KEY (numero_curso),
    CONSTRAINT ck_curso_creditos CHECK (creditos > 0),
    CONSTRAINT fk_curso_profesor FOREIGN KEY (numero_profesor)
        REFERENCES profesor (numero_profesor)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO
