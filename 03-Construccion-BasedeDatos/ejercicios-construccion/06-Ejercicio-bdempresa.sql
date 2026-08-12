-- =============================================
-- Ejercicio 06: Empresa V1
-- =============================================

USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'empresa1')
BEGIN
    ALTER DATABASE empresa1 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE empresa1;
END
GO

CREATE DATABASE empresa1;
GO

USE empresa1;
GO

CREATE TABLE empleado (
    ssn INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    sexo CHAR(1) NULL,
    salario DECIMAL(10,2) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    ssn_supervisor INT NULL,
    CONSTRAINT pk_empleado PRIMARY KEY (ssn),
    CONSTRAINT fk_empleado_supervisor FOREIGN KEY (ssn_supervisor)
        REFERENCES empleado (ssn)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT ck_empleado_salario CHECK (salario > 0)
);
GO

CREATE TABLE departamento (
    num_departamento INT IDENTITY(1,1) NOT NULL,
    nombre_departamento VARCHAR(100) NOT NULL,
    ssn_gerente INT NULL,
    fecha_inicio_gerente DATE NULL,
    CONSTRAINT pk_departamento PRIMARY KEY (num_departamento),
    CONSTRAINT uq_departamento_nombre UNIQUE (nombre_departamento),
    CONSTRAINT uq_departamento_gerente UNIQUE (ssn_gerente),
    CONSTRAINT fk_departamento_gerente FOREIGN KEY (ssn_gerente)
        REFERENCES empleado (ssn)
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

CREATE TABLE dependiente (
    ssn_empleado INT NOT NULL,
    nombre_dependiente VARCHAR(50) NOT NULL,
    sexo CHAR(1) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    parentesco VARCHAR(50) NOT NULL,
    CONSTRAINT pk_dependiente PRIMARY KEY (ssn_empleado, nombre_dependiente),
    CONSTRAINT fk_dependiente_empleado FOREIGN KEY (ssn_empleado)
        REFERENCES empleado (ssn)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO
