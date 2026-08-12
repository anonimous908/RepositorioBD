-- =============================================
-- Ejercicio 09: Proyecto Empresa
-- =============================================

USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'proyecto_empresa')
BEGIN
    ALTER DATABASE proyecto_empresa SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE proyecto_empresa;
END
GO

CREATE DATABASE proyecto_empresa;
GO

USE proyecto_empresa;
GO

CREATE TABLE departamento (
    clave_departamento INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    presupuesto DECIMAL(12,2) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    CONSTRAINT pk_departamento PRIMARY KEY (clave_departamento),
    CONSTRAINT uq_departamento_nombre UNIQUE (nombre),
    CONSTRAINT ck_departamento_presupuesto CHECK (presupuesto > 0)
);
GO

CREATE TABLE empleado (
    num_empleado INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    curp VARCHAR(18) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    clave_departamento INT NOT NULL,
    num_empleado_jefe INT NULL,
    CONSTRAINT pk_empleado PRIMARY KEY (num_empleado),
    CONSTRAINT uq_empleado_curp UNIQUE (curp),
    CONSTRAINT fk_empleado_departamento FOREIGN KEY (clave_departamento)
        REFERENCES departamento (clave_departamento)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_empleado_jefe FOREIGN KEY (num_empleado_jefe)
        REFERENCES empleado (num_empleado)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE capacitaciones (
    clave_capacitaciones INT IDENTITY(1,1) NOT NULL,
    nombre_capacitaciones VARCHAR(100) NOT NULL,
    CONSTRAINT pk_capacitaciones PRIMARY KEY (clave_capacitaciones),
    CONSTRAINT uq_capacitaciones_nombre UNIQUE (nombre_capacitaciones)
);
GO

CREATE TABLE asistir_capacitaciones (
    num_empleado INT NOT NULL,
    clave_capacitaciones INT NOT NULL,
    fecha_inscripcion DATE NOT NULL DEFAULT GETDATE(),
    calificacion DECIMAL(4,2) NULL,
    status VARCHAR(50) NOT NULL,
    CONSTRAINT pk_asistir_capacitaciones PRIMARY KEY (num_empleado, clave_capacitaciones),
    CONSTRAINT fk_asistir_empleado FOREIGN KEY (num_empleado)
        REFERENCES empleado (num_empleado)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_asistir_capacitaciones FOREIGN KEY (clave_capacitaciones)
        REFERENCES capacitaciones (clave_capacitaciones)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE proyecto (
    clave_proyecto INT IDENTITY(1,1) NOT NULL,
    nombre_proyecto VARCHAR(100) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_final DATE NULL,
    presupuesto DECIMAL(12,2) NOT NULL,
    CONSTRAINT pk_proyecto PRIMARY KEY (clave_proyecto),
    CONSTRAINT uq_proyecto_nombre UNIQUE (nombre_proyecto),
    CONSTRAINT ck_proyecto_presupuesto CHECK (presupuesto > 0)
);
GO

CREATE TABLE participa_proyecto (
    num_empleado INT NOT NULL,
    clave_proyecto INT NOT NULL,
    fecha_asignacion DATE NOT NULL DEFAULT GETDATE(),
    horas INT NOT NULL,
    rol VARCHAR(50) NOT NULL,
    CONSTRAINT pk_participa_proyecto PRIMARY KEY (num_empleado, clave_proyecto),
    CONSTRAINT fk_participa_empleado FOREIGN KEY (num_empleado)
        REFERENCES empleado (num_empleado)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_participa_proyecto FOREIGN KEY (clave_proyecto)
        REFERENCES proyecto (clave_proyecto)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT ck_participa_horas CHECK (horas > 0)
);
GO

CREATE TABLE sucursal (
    clave_sucursal INT IDENTITY(1,1) NOT NULL,
    nombre_sucursal VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    telefono VARCHAR(15) NULL,
    CONSTRAINT pk_sucursal PRIMARY KEY (clave_sucursal)
);
GO

CREATE TABLE telefono_sucursal (
    clave_sucursal INT NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    CONSTRAINT pk_telefono_sucursal PRIMARY KEY (clave_sucursal, telefono),
    CONSTRAINT fk_telefono_sucursal FOREIGN KEY (clave_sucursal)
        REFERENCES sucursal (clave_sucursal)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE participa_sucursal (
    num_empleado INT NOT NULL,
    clave_sucursal INT NOT NULL,
    CONSTRAINT pk_participa_sucursal PRIMARY KEY (num_empleado, clave_sucursal),
    CONSTRAINT fk_sucursal_empleado FOREIGN KEY (num_empleado)
        REFERENCES empleado (num_empleado)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_sucursal_sucursal FOREIGN KEY (clave_sucursal)
        REFERENCES sucursal (clave_sucursal)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE puesto (
    clave_puesto INT IDENTITY(1,1) NOT NULL,
    nombre_puesto VARCHAR(100) NOT NULL,
    salario_minimo DECIMAL(10,2) NOT NULL,
    salario_maximo DECIMAL(10,2) NOT NULL,
    nivel_jerarquico VARCHAR(50) NOT NULL,
    num_empleado INT NOT NULL,
    CONSTRAINT pk_puesto PRIMARY KEY (clave_puesto),
    CONSTRAINT fk_puesto_empleado FOREIGN KEY (num_empleado)
        REFERENCES empleado (num_empleado)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT ck_puesto_salario CHECK (salario_maximo >= salario_minimo)
);
GO
