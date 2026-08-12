-- =============================================
-- Ejercicio 07: Empresa V2
-- =============================================

USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'empresa2')
BEGIN
    ALTER DATABASE empresa2 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE empresa2;
END
GO

CREATE DATABASE empresa2;
GO

USE empresa2;
GO

CREATE TABLE empleado (
    num_empleado INT IDENTITY(1,1) NOT NULL,
    ssn VARCHAR(11) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    sexo CHAR(1) NULL,
    salario DECIMAL(10,2) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    ssn_supervisor INT NULL,
    CONSTRAINT pk_empleado PRIMARY KEY (num_empleado),
    CONSTRAINT uq_empleado_ssn UNIQUE (ssn),
    CONSTRAINT fk_empleado_supervisor FOREIGN KEY (ssn_supervisor)
        REFERENCES empleado (num_empleado)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT ck_empleado_salario CHECK (salario > 0)
);
GO

CREATE TABLE departamento (
    num_departamento INT IDENTITY(1,1) NOT NULL,
    nombre_departamento VARCHAR(100) NOT NULL,
    num_gerente INT NULL,
    fecha_inicio_gerente DATE NULL,
    CONSTRAINT pk_departamento PRIMARY KEY (num_departamento),
    CONSTRAINT uq_departamento_nombre UNIQUE (nombre_departamento),
    CONSTRAINT uq_departamento_gerente UNIQUE (num_gerente),
    CONSTRAINT fk_departamento_gerente FOREIGN KEY (num_gerente)
        REFERENCES empleado (num_empleado)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE departamento_ubicacion (
    num_departamento INT NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    CONSTRAINT pk_departamento_ubicacion PRIMARY KEY (num_departamento, ubicacion),
    CONSTRAINT fk_ubicacion_departamento FOREIGN KEY (num_departamento)
        REFERENCES departamento (num_departamento)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE proyecto (
    num_proyecto INT IDENTITY(1,1) NOT NULL,
    nombre_proyecto VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    num_departamento INT NOT NULL,
    CONSTRAINT pk_proyecto PRIMARY KEY (num_proyecto),
    CONSTRAINT uq_proyecto_nombre UNIQUE (nombre_proyecto),
    CONSTRAINT fk_proyecto_departamento FOREIGN KEY (num_departamento)
        REFERENCES departamento (num_departamento)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE empleado_proyecto (
    num_empleado INT NOT NULL,
    num_proyecto INT NOT NULL,
    horas DECIMAL(5,2) NOT NULL,
    CONSTRAINT pk_empleado_proyecto PRIMARY KEY (num_empleado, num_proyecto),
    CONSTRAINT fk_empleado_proyecto_empleado FOREIGN KEY (num_empleado)
        REFERENCES empleado (num_empleado)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_empleado_proyecto_proyecto FOREIGN KEY (num_proyecto)
        REFERENCES proyecto (num_proyecto)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT ck_empleado_proyecto_horas CHECK (horas >= 0)
);
GO

CREATE TABLE dependiente (
    num_empleado INT NOT NULL,
    nombre_dependiente VARCHAR(50) NOT NULL,
    sexo CHAR(1) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    parentesco VARCHAR(50) NOT NULL,
    CONSTRAINT pk_dependiente PRIMARY KEY (num_empleado, nombre_dependiente),
    CONSTRAINT fk_dependiente_empleado FOREIGN KEY (num_empleado)
        REFERENCES empleado (num_empleado)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO
