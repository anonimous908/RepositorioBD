-- =============================================
-- Ejercicio 10: Académico Institucional
-- =============================================
USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'academia_institucional')
BEGIN
    ALTER DATABASE academia_institucional SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE academia_institucional;
END
GO

CREATE DATABASE academia_institucional;
GO

USE academia_institucional;
GO

CREATE TABLE alumno (
    matricula INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    CONSTRAINT pk_alumno PRIMARY KEY (matricula),
    CONSTRAINT uq_alumno_correo UNIQUE (correo)
);
GO

CREATE TABLE credencial (
    num_credencial INT IDENTITY(1,1) NOT NULL,
    fecha_inscripcion DATE NOT NULL DEFAULT GETDATE(),
    vigencia DATE NOT NULL,
    matricula INT NOT NULL,
    CONSTRAINT pk_credencial PRIMARY KEY (num_credencial),
    CONSTRAINT uq_credencial_alumno UNIQUE (matricula),
    CONSTRAINT fk_credencial_alumno FOREIGN KEY (matricula)
        REFERENCES alumno (matricula)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE telefono_alumno (
    matricula INT NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    CONSTRAINT pk_telefono_alumno PRIMARY KEY (matricula, telefono),
    CONSTRAINT fk_telefono_alumno FOREIGN KEY (matricula)
        REFERENCES alumno (matricula)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE departamento (
    num_departamento INT IDENTITY(1,1) NOT NULL,
    nombre_departamento VARCHAR(100) NOT NULL,
    edificio VARCHAR(50) NOT NULL,
    CONSTRAINT pk_departamento PRIMARY KEY (num_departamento),
    CONSTRAINT uq_departamento_nombre UNIQUE (nombre_departamento)
);
GO

CREATE TABLE profesor (
    num_profesor INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    num_departamento INT NOT NULL,
    CONSTRAINT pk_profesor PRIMARY KEY (num_profesor),
    CONSTRAINT fk_profesor_departamento FOREIGN KEY (num_departamento)
        REFERENCES departamento (num_departamento)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE materia (
    clave_materia INT IDENTITY(1,1) NOT NULL,
    nombre_materia VARCHAR(100) NOT NULL,
    creditos INT NOT NULL,
    num_profesor INT NOT NULL,
    CONSTRAINT pk_materia PRIMARY KEY (clave_materia),
    CONSTRAINT uq_materia_nombre UNIQUE (nombre_materia),
    CONSTRAINT ck_materia_creditos CHECK (creditos > 0),
    CONSTRAINT fk_materia_profesor FOREIGN KEY (num_profesor)
        REFERENCES profesor (num_profesor)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE cursa_materia (
    matricula INT NOT NULL,
    clave_materia INT NOT NULL,
    fecha_inscripcion DATE NOT NULL DEFAULT GETDATE(),
    calificacion_final DECIMAL(4,2) NULL,
    CONSTRAINT pk_cursa_materia PRIMARY KEY (matricula, clave_materia),
    CONSTRAINT fk_cursa_alumno FOREIGN KEY (matricula)
        REFERENCES alumno (matricula)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_cursa_materia FOREIGN KEY (clave_materia)
        REFERENCES materia (clave_materia)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE profesor_dependiente (
    num_profesor INT NOT NULL,
    nombre_dependiente VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    parentesco VARCHAR(50) NOT NULL,
    CONSTRAINT pk_profesor_dependiente PRIMARY KEY (num_profesor, nombre_dependiente),
    CONSTRAINT fk_dependiente_profesor FOREIGN KEY (num_profesor)
        REFERENCES profesor (num_profesor)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE proyecto (
    num_proyecto INT IDENTITY(1,1) NOT NULL,
    nombre_proyecto VARCHAR(100) NOT NULL,
    presupuesto DECIMAL(12,2) NOT NULL,
    CONSTRAINT pk_proyecto PRIMARY KEY (num_proyecto),
    CONSTRAINT uq_proyecto_nombre UNIQUE (nombre_proyecto),
    CONSTRAINT ck_proyecto_presupuesto CHECK (presupuesto > 0)
);
GO

CREATE TABLE participa_proyecto (
    num_profesor INT NOT NULL,
    num_proyecto INT NOT NULL,
    rol VARCHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT pk_participa_proyecto PRIMARY KEY (num_profesor, num_proyecto),
    CONSTRAINT fk_participa_profesor FOREIGN KEY (num_profesor)
        REFERENCES profesor (num_profesor)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_participa_proyecto_proyecto FOREIGN KEY (num_proyecto)
        REFERENCES proyecto (num_proyecto)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO