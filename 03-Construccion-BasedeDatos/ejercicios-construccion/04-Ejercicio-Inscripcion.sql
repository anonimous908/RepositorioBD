-- =============================================
-- Ejercicio 04: Inscripciones
-- =============================================

USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'inscripciones')
BEGIN
    ALTER DATABASE inscripciones SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE inscripciones;
END
GO

CREATE DATABASE inscripciones;
GO

USE inscripciones;
GO

CREATE TABLE alumno (
    num_alumno INT IDENTITY(1,1) NOT NULL,
    matricula VARCHAR(20) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    semestre INT NOT NULL,
    CONSTRAINT pk_alumno PRIMARY KEY (num_alumno),
    CONSTRAINT uq_alumno_matricula UNIQUE (matricula),
    CONSTRAINT ck_alumno_semestre CHECK (semestre > 0)
);
GO

CREATE TABLE materia (
    clave_materia INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    creditos INT NOT NULL,
    CONSTRAINT pk_materia PRIMARY KEY (clave_materia),
    CONSTRAINT uq_materia_nombre UNIQUE (nombre),
    CONSTRAINT ck_materia_creditos CHECK (creditos > 0)
);
GO

CREATE TABLE inscribe (
    num_alumno INT NOT NULL,
    clave_materia INT NOT NULL,
    fecha_inscribe DATE NOT NULL DEFAULT GETDATE(),
    calificacion DECIMAL(4,2) NULL,
    CONSTRAINT pk_inscribe PRIMARY KEY (num_alumno, clave_materia),
    CONSTRAINT fk_inscribe_alumno FOREIGN KEY (num_alumno) REFERENCES alumno (num_alumno)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_inscribe_materia FOREIGN KEY (clave_materia)
        REFERENCES materia (clave_materia)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO
