USE bdejemplo;

CREATE TABLE alumno(
idAlumno INT NOT NULL PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
apellidoPaterno VARCHAR(20) NOT NULL,
apellidoMaterno VARCHAR(20)  NULL,
fechanaci DATE NOT NULL,
calle VARCHAR(50) NOT NULL,
numeroInt INT,
numeroExt INT
);
INSERT INTO alumno
VALUES (1,'	David','Borges',NULL,'2007-07-17','Tula de Allende' ,NULL,123);


INSERT INTO alumno
VALUES (2,'Sinn','peres','islas','2007-07-17','Tula de Allende' ,NULL,null);

INSERT INTO alumno (idAlumno,nombre,apellidoPaterno,fechanaci,calle)
VALUES (3,'Cristofer','Garcia','2007-07-17','Conocida');
SELECT * FROM alumno;

--Razón de cardinalidad

CREATE TABLE categoria2(
categoriaId INT NOT NULL ,
nombre VARCHAR(30) NOT NULL,
apellidoPaterno VARCHAR(20) NOT NULL,
CONSTRAINT pk_categoria2
PRIMARY KEY (categoriaId)
);


CREATE TABLE producto2(
productoId INT NOT NULL PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
existencia VARCHAR(20) NOT NULL,
precio DECIMAL(10,2) NOT NULL,
categoriaId INT,
CONSTRAINT fk_producto2_categoria2
FOREIGN KEY (categoriaId)
REFERENCES categoria2(categoriaId)
);