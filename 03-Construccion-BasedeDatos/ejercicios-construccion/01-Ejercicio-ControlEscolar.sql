-- =============================================
-- Ejercicio 01: Control Escolar
-- =============================================

CREATE DATABASE control_escolar;
GO

USE control_escolar;
GO

CREATE TABLE carrera (
    id_carrera INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    duracion_cuatrimestre INT NOT NULL,
    CONSTRAINT pk_carrera PRIMARY KEY (id_carrera),
    CONSTRAINT uq_carrera_nombre UNIQUE (nombre),
    CONSTRAINT ck_carrera_duracion CHECK (duracion_cuatrimestre > 0)
);
GO

CREATE TABLE alumno (
    id_alumno INT IDENTITY(1,1) NOT NULL,
    matricula VARCHAR(10) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    correo VARCHAR(100) NULL,
    fecha_nacimiento DATE NOT NULL,
    id_carrera INT NOT NULL,
    CONSTRAINT pk_alumno PRIMARY KEY (id_alumno),
    CONSTRAINT uq_alumno_matricula UNIQUE (matricula),
    CONSTRAINT uq_alumno_correo UNIQUE (correo),
    CONSTRAINT fk_alumno_carrera FOREIGN KEY (id_carrera)
        REFERENCES carrera (id_carrera)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE profesor (
    id_profesor INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    correo VARCHAR(100) NULL,
    especialidad VARCHAR(100) NULL,
    CONSTRAINT pk_profesor PRIMARY KEY (id_profesor),
    CONSTRAINT uq_profesor_correo UNIQUE (correo)
);
GO

CREATE TABLE materia (
    id_materia INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    creditos INT NOT NULL,
    id_carrera INT NOT NULL,
    CONSTRAINT pk_materia PRIMARY KEY (id_materia),
    CONSTRAINT uq_materia_nombre UNIQUE (nombre),
    CONSTRAINT ck_materia_creditos CHECK (creditos > 0),
    CONSTRAINT fk_materia_carrera FOREIGN KEY (id_carrera)
        REFERENCES carrera (id_carrera)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE grupo (
    id_grupo INT IDENTITY(1,1) NOT NULL,
    clave_grupo VARCHAR(20) NOT NULL,
    semestre VARCHAR(20) NOT NULL,
    id_materia INT NOT NULL,
    id_profesor INT NOT NULL,
    CONSTRAINT pk_grupo PRIMARY KEY (id_grupo),
    CONSTRAINT uq_grupo_clave UNIQUE (clave_grupo),
    CONSTRAINT fk_grupo_materia FOREIGN KEY (id_materia)
        REFERENCES materia (id_materia)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_grupo_profesor FOREIGN KEY (id_profesor)
        REFERENCES profesor (id_profesor)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE inscripcion (
    id_inscripcion INT IDENTITY(1,1) NOT NULL,
    id_alumno INT NOT NULL,
    id_grupo INT NOT NULL,
    fecha_inscripcion DATE NOT NULL DEFAULT GETDATE(),
    calificacion DECIMAL(4,2) NULL,
    CONSTRAINT pk_inscripcion PRIMARY KEY (id_inscripcion),
    CONSTRAINT uq_inscripcion_alumno_grupo UNIQUE (id_alumno, id_grupo),
    CONSTRAINT fk_inscripcion_alumno FOREIGN KEY (id_alumno)
        REFERENCES alumno (id_alumno)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_inscripcion_grupo FOREIGN KEY (id_grupo)
        REFERENCES grupo (id_grupo)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO
