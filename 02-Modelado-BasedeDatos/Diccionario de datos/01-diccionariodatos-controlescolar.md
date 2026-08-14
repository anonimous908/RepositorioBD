# Diccionario de Datos de la Base de Datos: Control Escolar

## 1. Información General
| Elemento | Valor |
| :--- | :--- |
| Proyecto | Control Escolar |
| Versión | 1.0 |
| Fecha | Junio 2026 |
| Elaboró | David Borges Tavera |
| SGBD | SQLSERVER |

---

## 2. Descripción de la Base de Datos

La base de datos administra la estructura académica básica de una institución:
- **Carreras y Materias:** Carreras técnicas/universitarias y las materias adscritas a cada plan de estudios.
- **Alumnos y Profesores:** Padrón de estudiantes e instructores.
- **Grupos e Inscripciones:** Apertura de grupos por materia y asignación del profesor, así como el historial de inscripciones y calificaciones de alumnos.

---

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :--- | :--- |
| **PK** | Primary Key (Clave Primaria) |
| **FK** | Foreign Key (Clave Foránea) |
| **NN** | Not Null (No Nulo) |
| **UQ** | Unique (Único) |
| **AI** | Identity / Autoincrementable |

---

## 4. Diccionario de Datos por Tabla

### **Tabla:** *carrera*
**Descripción:** Catálogo de carreras académicas impartidas.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `id_carrera` | INT | - | PK, AI, NN | Identificador único de la carrera. |
| `nombre` | VARCHAR | 100 | UQ, NN | Nombre oficial de la carrera. |
| `duracion_cuatrimestre` | INT | - | NN, CK | Duración en cuatrimestres (>0). |

---

### **Tabla:** *alumno*
**Descripción:** Almacena los datos personales de los estudiantes inscritos.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `id_alumno` | INT | - | PK, AI, NN | Clave primaria interna del alumno. |
| `matricula` | VARCHAR | 10 | UQ, NN | Matrícula institucional del estudiante. |
| `nombre` | VARCHAR | 50 | NN | Nombre(s) del alumno. |
| `apellido_paterno` | VARCHAR | 50 | NN | Apellido paterno del alumno. |
| `apellido_materno` | VARCHAR | 50 | NN | Apellido materno del alumno. |
| `correo` | VARCHAR | 100 | UQ, Null | Correo electrónico personal/institucional. |
| `fecha_nacimiento` | DATE | - | NN | Fecha de nacimiento del alumno. |
| `id_carrera` | INT | - | FK, NN | Carrera en la que se encuentra inscrito. |

---

### **Tabla:** *profesor*
**Descripción:** Padrón de los docentes de la institución.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `id_profesor` | INT | - | PK, AI, NN | Clave primaria del profesor. |
| `nombre` | VARCHAR | 50 | NN | Nombre(s) del profesor. |
| `apellido_paterno` | VARCHAR | 50 | NN | Apellido paterno. |
| `apellido_materno` | VARCHAR | 50 | NN | Apellido materno. |
| `correo` | VARCHAR | 100 | UQ, Null | Correo del docente. |
| `especialidad` | VARCHAR | 100 | Null | Especialidad o área de conocimiento. |

---

### **Tabla:** *materia*
**Descripción:** Catálogo de materias pertenecientes a cada carrera.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `id_materia` | INT | - | PK, AI, NN | Identificador de la asignatura. |
| `nombre` | VARCHAR | 100 | UQ, NN | Nombre de la asignatura. |
| `creditos` | INT | - | NN, CK | Valor en créditos de la asignatura (>0). |
| `id_carrera` | INT | - | FK, NN | Carrera a la que pertenece la materia. |

---

### **Tabla:** *grupo*
**Descripción:** Apertura de grupos por cuatrimestre/semestre con su profesor asignado.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `id_grupo` | INT | - | PK, AI, NN | Identificador único del grupo. |
| `clave_grupo` | VARCHAR | 20 | UQ, NN | Clave alfanumérica única del grupo. |
| `semestre` | VARCHAR | 20 | NN | Periodo/semestre escolar correspondiente. |
| `id_materia` | INT | - | FK, NN | Materia que se imparte en el grupo. |
| `id_profesor` | INT | - | FK, NN | Docente asignado al grupo. |

---

### **Tabla:** *inscripcion*
**Descripción:** Registro histórico de los alumnos inscritos en cada grupo.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `id_inscripcion` | INT | - | PK, AI, NN | Folio único de la inscripción. |
| `id_alumno` | INT | - | FK, NN | Alumno que realiza la inscripción. |
| `id_grupo` | INT | - | FK, NN | Grupo al que se inscribe. |
| `fecha_inscripcion` | DATE | - | NN | Fecha en que se procesó la inscripción. |
| `calificacion` | DECIMAL | 4,2 | Null | Calificación final obtenida. |
