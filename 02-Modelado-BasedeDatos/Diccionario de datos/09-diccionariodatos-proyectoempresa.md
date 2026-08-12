# Diccionario de Datos de la Base de Datos: Proyecto Empresa

## 1. Información General
| Elemento | Valor |
| :--- | :--- |
| Proyecto | Proyecto Empresa |
| Versión | 1.0 |
| Fecha | Junio 2026 |
| Elaboró | David Borges Tavera |
| SGBD | SQLSERVER |

---

## 2. Descripción de la Base de Datos

La base de datos administra la estructura organizacional, operativa y capacitaciones de una corporación:
- **Estructura Organizacional:** Departamentos, puestos de trabajo con bandas salariales (mínimos y máximos), y empleados con supervisión jerárquica.
- **Sucursales y Teléfonos:** Sucursales regionales con sus datos de localización y teléfonos de contacto.
- **Capacitación Continua:** Catálogo de capacitaciones y seguimiento del historial de asistencia, calificaciones y estatus por empleado.
- **ProyectosCorporativos:** Proyectos estratégicos de la empresa, su asignación presupuestal y la asignación de empleados con roles y horas dedicadas.

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

### **Tabla:** *departamento*
**Descripción:** Unidades operativas o administrativas de la corporación.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `clave_departamento` | INT | - | PK, AI, NN | Identificador único del departamento. |
| `nombre` | VARCHAR | 100 | UQ, NN | Nombre oficial del departamento. |
| `presupuesto` | DECIMAL | 12,2 | CK, NN | Presupuesto anual asignado (> 0). |
| `ubicacion` | VARCHAR | 100 | NN | Edificio o piso de ubicación. |

---

### **Tabla:** *empleado*
**Descripción:** Plantilla del personal de la corporación.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_empleado` | INT | - | PK, AI, NN | Número de empleado institucional. |
| `nombre` | VARCHAR | 50 | NN | Nombre(s) del trabajador. |
| `apellido_paterno` | VARCHAR | 50 | NN | Apellido paterno. |
| `apellido_materno` | VARCHAR | 50 | NN | Apellido materno. |
| `curp` | VARCHAR | 18 | UQ, NN | Clave Única de Registro de Población. |
| `fecha_nacimiento` | DATE | - | NN | Fecha de nacimiento. |
| `clave_departamento` | INT | - | FK, NN | Departamento al que pertenece. |
| `num_empleado_jefe` | INT | - | FK, Null | Jefe directo (FK recursiva a empleado). |

---

### **Tabla:** *capacitaciones*
**Descripción:** Catálogo de cursos y capacitaciones ofrecidas.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `clave_capacitaciones` | INT | - | PK, AI, NN | Identificador único del curso. |
| `nombre_capacitaciones` | VARCHAR | 100 | UQ, NN | Título oficial del programa de capacitación. |

---

### **Tabla:** *asistir_capacitaciones*
**Descripción:** Historial de inscripción y rendimiento del personal en capacitaciones.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_empleado` | INT | - | PK, FK, NN | Empleado inscrito. |
| `clave_capacitaciones` | INT | - | PK, FK, NN | Capacitación a la que asiste. |
| `fecha_inscripcion` | DATE | - | NN | Fecha de registro al curso (DEFAULT GETDATE()). |
| `calificacion` | DECIMAL | 4,2 | Null | Evaluación numérica obtenida. |
| `status` | VARCHAR | 50 | NN | Estatus ('Aprobado', 'En curso', 'Reprobado'). |

---

### **Tabla:** *proyecto*
**Descripción:** Proyectos estratégicos de desarrollo o innovación corporativa.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `clave_proyecto` | INT | - | PK, AI, NN | Identificador único del proyecto. |
| `nombre_proyecto` | VARCHAR | 100 | UQ, NN | Nombre del proyecto. |
| `fecha_inicio` | DATE | - | NN | Fecha de arranque del proyecto. |
| `fecha_final` | DATE | - | Null | Fecha estimada de conclusión. |
| `presupuesto` | DECIMAL | 12,2 | CK, NN | Recursos financieros asignados (> 0). |

---

### **Tabla:** *participa_proyecto*
**Descripción:** Asignación de trabajadores a proyectos de la empresa.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_empleado` | INT | - | PK, FK, NN | Empleado participante. |
| `clave_proyecto` | INT | - | PK, FK, NN | Proyecto asignado. |
| `fecha_asignacion` | DATE | - | NN | Fecha de ingreso al proyecto. |
| `horas` | INT | - | CK, NN | Horas semanales invertidas (> 0). |
| `rol` | VARCHAR | 50 | NN | Función o rol desempeñado en el proyecto. |

---

### **Tabla:** *sucursal*
**Descripción:** Sedes o sucursales físicas de la corporación.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `clave_sucursal` | INT | - | PK, AI, NN | Clave de identificación de la sucursal. |
| `nombre_sucursal` | VARCHAR | 100 | NN | Nombre comercial o zona de la sucursal. |
| `estado` | VARCHAR | 50 | NN | Estado de la República donde se ubica. |
| `ciudad` | VARCHAR | 50 | NN | Ciudad de localización. |
| `telefono` | VARCHAR | 15 | Null | Teléfono principal de conmutador. |

---

### **Tabla:** *telefono_sucursal*
**Descripción:** Teléfonos adicionales de contacto por sucursal (Atributo multivaluado).

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `clave_sucursal` | INT | - | PK, FK, NN | Sucursal a la que pertenece el número. |
| `telefono` | VARCHAR | 15 | PK, NN | Número telefónico de contacto directos. |

---

### **Tabla:** *participa_sucursal*
**Descripción:** Asignación operativa de empleados en sucursales físicas.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_empleado` | INT | - | PK, FK, NN | Empleado asignado. |
| `clave_sucursal` | INT | - | PK, FK, NN | Sucursal donde labora. |

---

### **Tabla:** *puesto*
**Descripción:** Definición de cargos de trabajo y rangos salariales.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `clave_puesto` | INT | - | PK, AI, NN | Clave del puesto laboral. |
| `nombre_puesto` | VARCHAR | 100 | NN | Denominación oficial del cargo. |
| `salario_minimo` | DECIMAL | 10,2 | NN | Sueldo mínimo establecido para la categoría. |
| `salario_maximo` | DECIMAL | 10,2 | CK, NN | Sueldo máximo para la categoría (>= mínimo). |
| `nivel_jerarquico` | VARCHAR | 50 | NN | Nivel dentro del organigrama corporativo. |
| `num_empleado` | INT | - | FK, NN | Empleado asignado al puesto. |
