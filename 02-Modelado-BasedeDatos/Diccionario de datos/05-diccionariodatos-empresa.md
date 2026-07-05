# Diccionario de Datos de la Base de Datos: Empresa (Company)

## 1. Información General
| Elemento | Valor |
| :--- | :--- |
| Proyecto | Empresa (Company) |
| Versión | 1.0 |
| Fecha | Junio 2026 |
| Elaboró | David Borges Tavera |
| SGBD | SQLSERVER |

---

## 2. Descripción de la Base de Datos

La base de datos administra el core operativo de una organización:
- **Employee:** Datos del personal y estructura jerárquica (supervisores).
- **Department:** Divisiones internas y sus gerentes.
- **Locations:** Múltiples sedes geográficas por departamento.
- **Project:** Proyectos ejecutados por la empresa.
- **Works_on:** Registro de horas que cada empleado invierte en cada proyecto.
- **Dependent:** Familiares directos de los empleados para beneficios médicos/seguros.

---

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :--- | :--- |
| **PK** | Primary Key (Clave Primaria) |
| **FK** | Foreign Key (Clave Foránea) |
| **NN** | Not Null (No Nulo) |
| **UQ** | Unique (Único) |

---

## 4. Diccionario de Datos

### **Tabla:** *EMPLOYEE*

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `ssn` | VARCHAR | 11 | PK, NN | Número de Seguro Social. Identificador único del empleado. |
| `first_name` | VARCHAR | 50 | NN | Primer nombre del empleado. |
| `last_name` | VARCHAR | 50 | NN | Apellidos del empleado. |
| `birthdate` | DATE | - | NN | Fecha de nacimiento del empleado. |
| `address` | VARCHAR | 100 | NN | Dirección de residencia. |
| `sex` | CHAR | 1 | NN | Género o sexo biológico (M/F). |
| `salary` | DECIMAL(10,2)| - | *Null* | Salario mensual asignado. |
| `jef_ssn` | VARCHAR | 11 | FK, *Null* | SSN del supervisor directo (Relación reflexiva). |
| `number_department` | INT | - | FK, NN | Número de departamento al que pertenece. |

---

### **Tabla:** *DEPARTMENT*

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `number_department` | INT | - | PK, NN | Número único identificador del departamento. |
| `name` | VARCHAR | 100 | UQ, NN | Nombre único de la división. |
| `manager_ssn` | VARCHAR | 11 | FK, UQ, NN | SSN del empleado que funge como gerente (1:1). |
| `startdate` | DATE | - | *Null* | Fecha en que el gerente tomó posesión del cargo. |

---

### **Tabla:** *LOCATIONS*

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_location` | INT | - | PK, NN | Identificador interno de la ubicación. |
| `number_department` | INT | - | FK, NN | Departamento al que pertenece la locación. |
| `location_name` | VARCHAR | 100 | NN | Nombre o dirección de la sede física. |

---

### **Tabla:** *PROJECT*

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `number_project` | INT | - | PK, NN | Número de identificación único del proyecto. |
| `name` | VARCHAR | 100 | UQ, NN | Nombre representativo del proyecto. |
| `location` | VARCHAR | 100 | *Null* | Ubicación geográfica donde se desarrolla el proyecto. |
| `number_department` | INT | - | FK, NN | Departamento encargado de la administración del proyecto. |

---

### **Tabla:** *WORKS_ON*

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `ssn` | VARCHAR | 11 | PK, FK, NN | SSN del empleado asignado al proyecto. |
| `number_project` | INT | - | PK, FK, NN | Número del proyecto asignado. |
| `hours` | DECIMAL(5,2) | - | *Null* | Horas acumuladas de trabajo invertidas por el empleado. |

---

### **Tabla:** *DEPENDENT*

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `ssn_employee` | VARCHAR | 11 | PK, FK, NN | SSN del empleado del cual depende familiarmente. |
| `dependent_name` | VARCHAR | 50 | PK, NN | Nombre completo del dependiente. |
| `sex` | CHAR | 1 | NN | Sexo biológico del dependiente. |
| `birthdate` | DATE | - | NN | Fecha de nacimiento del dependiente. |
| `relationship` | VARCHAR | 50 | NN | Parentesco (Hijo, Cónyuge, etc.). |

---

## 5. Relaciones en la Base de Datos

| Relación | Cardinalidad | Descripción |
| :--- | :--- | :--- |
| Employee -> Employee | 1:N | Un supervisor gestiona a varios subordinados. |
| Employee -> Department | 1:1 | Un empleado lidera como gerente a un único departamento. |
| Department -> Employee | 1:N | Un departamento alberga múltiples empleados trabajando en él. |
| Department -> Locations | 1:N | Un departamento puede operar en múltiples sedes. |
| Department -> Project | 1:N | Un departamento supervisa o financia múltiples proyectos. |
| Project -> Works_on | 1:N | Un proyecto desglosa sus horas asignadas. |
| Employee -> Works_on | 1:N | Un empleado registra sus horas invertidas. |
| Employee -> Dependent | 1:N | Un empleado puede tener uno o más dependientes. |

---

## 6. Matriz de Claves Foráneas

| Tabla | Campo FK | Referencia |
| :--- | :--- | :--- |
| EMPLOYEE | `number_department` | DEPARTMENT(`number_department`) |
| EMPLOYEE | `jef_ssn` | EMPLOYEE(`ssn`) |
| DEPARTMENT | `manager_ssn` | EMPLOYEE(`ssn`) |
| LOCATIONS | `number_department` | DEPARTMENT(`number_department`) |
| PROJECT | `number_department` | DEPARTMENT(`number_department`) |
| WORKS_ON | `ssn` | EMPLOYEE(`ssn`) |
| WORKS_ON | `number_project` | PROJECT(`number_project`) |
| DEPENDENT | `ssn_employee` | EMPLOYEE(`ssn`) |

---

## 7. Integridad Referencial

| Clave | Regla |
| :--- | :--- |
| **IR-01** | No se puede asignar un `number_department` a un proyecto o empleado si este no existe en `DEPARTMENT`. |
| **IR-02** | No se puede eliminar a un empleado si su SSN está registrado como `manager_ssn` activo de un departamento. |
| **IR-03** | Al eliminar un empleado, todos sus dependientes vinculados en la tabla `DEPENDENT` deben eliminarse automáticamente en cascada (`ON DELETE CASCADE`). |

---

## 8. Reglas de Negocio

| Clave | Regla |
| :--- | :--- |
| **RN-01** | Las horas registradas en la tabla `WORKS_ON` no pueden ser negativas. |
| **RN-02** | Un empleado no puede ser su propio supervisor directo (`jef_ssn` diferente de `ssn`). |
| **RN-03** | El campo `manager_ssn` en la tabla `DEPARTMENT` debe ser único para asegurar que un empleado sea gerente de un solo departamento a la vez. |

---

## 9. Diagrama Relacional

![Diagrama Relacional](/img/Relacional/Relacional6.png)
