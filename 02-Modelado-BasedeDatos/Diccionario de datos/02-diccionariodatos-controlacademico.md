# Diccionario de Datos de la Base de Datos: Control Académico

## 1. Información General
| Elemento | Valor |
| :--- | :--- |
| Proyecto | Control Académico |
| Versión | 1.0 |
| Fecha | Junio 2026 |
| Elaboró | David Borges Tavera |
| SGBD | SQLSERVER |

---

## 2. Descripción de la Base de Datos

La base de datos administra:

- Curso
- Profesor
- Especialidad

Permite controlar la oferta de cursos, la asignación y datos personales de los profesores, así como el registro de las especialidades profesionales que posee cada docente.

---

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :--- | :--- |
| **PK** | Primary Key (Clave Primaria) |
| **FK** | Foreign Key (Clave Foránea) |
| **NN** | Not Null (No Nulo) |
| **AI** | Identity (Autoincrementable) |

---

## 4. Diccionario de Datos

### **Tabla:** *Curso*
 
**Descripción:** Almacena los cursos o asignaturas que oferta la institución académica y el profesor asignado a cada uno.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `numero_curso` | INT | - | PK, AI, NN | Identificador único y autoincrementable del curso. |
| `nombre_curso` | VARCHAR | 100 | NN | Nombre oficial de la asignatura o curso. |
| `creditos` | INT | - | NN | Cantidad de créditos académicos que otorga el curso. |
| `numero_profesor` | INT | - | FK, NN | Enlace al profesor que imparte el curso (Relación N:1). |

---

### **Tabla:** *Profesor*
 
**Descripción:** Almacena los datos de identificación de los profesores de la institución.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `numero_profesor` | INT | - | PK, AI, NN | Número de nómina o identificador único del profesor. |
| `nombre` | VARCHAR | 50 | NN | Nombre o nombres del docente. |
| `apellido_paterno` | VARCHAR | 50 | NN | Apellido paterno del docente. |
| `apellido_materno` | VARCHAR | 50 | *Null* | Apellido materno del docente (opcional). |

---

### **Tabla:** *Especialidad*
 
**Descripción:** Almacena las distintas especialidades, maestrías o certificaciones técnicas que ostentan los profesores.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `id_especialidad` | INT | - | PK, AI, NN | Identificador único de registro de la especialidad. |
| `nombre` | VARCHAR | 100 | NN | Nombre o título de la especialidad profesional. |
| `numero_profesor` | INT | - | FK, NN | Enlace al profesor que posee dicha especialidad (Relación N:1). |

---

## 5. Relaciones en la Base de Datos

| Relación | Cardinalidad | Descripción |
| :--- | :--- | :--- |
| Profesor -> Curso | 1:N | Un profesor puede impartir varios cursos. |
| Profesor -> Especialidad | 1:N | Un profesor puede registrar y contar con muchas especialidades académicas. |

---

## 6. Matriz de Claves Foráneas

| Tabla | Campo FK | Referencia |
| :--- | :--- | :--- |
| Curso | `numero_profesor` | Profesor(`numero_profesor`) |
| Especialidad | `numero_profesor` | Profesor(`numero_profesor`) |

---

## 7. Integridad Referencial

| Clave | Regla |
| :--- | :--- |
| **IR-01** | No se puede registrar un curso si se le asigna un `numero_profesor` que no exista en la tabla Profesor. |
| **IR-02** | No se puede registrar una especialidad ligada a un `numero_profesor` inexistente en la tabla Profesor. |
| **IR-03** | Si se elimina un profesor, no se permite dejar huérfanos a los cursos; se debe restringir la eliminación si existen registros dependientes. |

---

## 8. Reglas de Negocio

| Clave | Regla |
| :--- | :--- |
| **RN-01** | Un profesor puede impartir varios cursos, pero cada curso es impartido por un único profesor. |
| **RN-02** | Un profesor puede registrar múltiples especialidades para comprobar su capacidad en diferentes ramas de estudio. |
| **RN-03** | Todo curso registrado debe contar con un valor de créditos asignado mayor a cero de forma obligatoria. |

---

## 9. Diagrama Relacional

![Diagrama Relacional](/img/Relacional/Relacional2.jpeg)
