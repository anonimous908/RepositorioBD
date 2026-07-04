# Ejercicios del modelo Entidad-Relación


## Ejercicio 1.

Un hospital registra información de sus pacientes:

>De cada paciente se almacena:
- Numero de paciente 
- nombre
- fecha de nacimiento 

>De cada Expediente médico se almacena:
- Numero de expediente 
- fecha de apertura
- tipo de sangre

> Reglas del negocio
1. Cada paciente debe tener un expediente médico
2. Cada expediente medico pertenece a un unico paciente
3. No puede existir un paciente sin expediente
4. No puede existir un expediente sin paciente
> Que se debe de realizar 

- Identificar las entidades
- Identificar los atributos
- Dibujar las relaciones
- Dibujar las cardinalidad
- Dibujar la participación de cada entidad

![Ejercicio1](/img/ER/diagrama1.png)

## Ejercicio 2.

Una Universidad administra profesores y cursos 

>de cada profesor se almacena 
numero de profesorID
nombre 
especialidad
>de cada **curso** se almacena:
- número de cursos
- nombre del curso
- creditos
> Reglas del negocio
1. un profesor puede impartir varios cursos
2. un curso solo puede ser impartido por 1 profesor
3. puede existir un profesor que actualmente no imparta cursos
4. todo curso debe estar asignado a un profesor
> Que se debe de realizar 

- Identificar las entidades
- Identificar los atributos
- Dibujar las relaciones
- Dibujar las cardinalidad
- Dibujar la participación de cada entidad

![Ejercicio2](/img/ER/diagrama2.png)

# Ejercicio 3
Una escuela administra alumnos y materias 
> de cada alumno almacena 
- Matricula
- Nombre
- semestre
> de cada materia se almacena 
- Clave de la materia
- nombre de la materia 
- creditos 
> Reglas del negocio
1. un alumno puede inscribirse en varias materias
2. una materia puede tener muchos alumnos inscritos
3. puede existir una materia sin alumnos inscritos
4. todo alumno debe estar inscrito en al menos 1 materia 
5. de cada inscripción se desea almacenar:
 - fecha de inscripción
 - calificación final
> Que se debe de realizar 

- Identificar las entidades
- Identificar los atributos
- Dibujar las relaciones
- Dibujar las cardinalidad
- Dibujar la participación de cada entidad

![Ejercicio3](/img/ER/diagrama3.png)
# Ejercicio 4
Una empresa dedicada a las ventas al por mayor necesita registrar lo siguiente para los clientes
> para los clientes
- número de clientes
- nombre (el cual es una persona moral)
> producto
- número del producto
- nombre
- precio
> Reglas del negocio
1. Un cliente puede realizar muchos pedidos
2. Cada pedido pertenece a un solo cliente
3. Un pedido contiene varios productos
4. Un producto puede aparecer en muchos pedidos
5. Un pedido debe contener al menos un producto
6. Un producto puede no haber sido vendido
7. El detalle del pedido no existe sin pedido
8. El detalle del pedido no existe sin producto
9. El detalle almacena la cantidad vendida y el precio
> Que se debe de realizar 

- Identificar las entidades
- Identificar los atributos
- Identificar los atributos compuestos
- Identificar los atributos multivalor
- Dibujar las relaciones
- Dibujar las cardinalidad
- Dibujar la participación de cada entidad

![Ejercicio4](/img/ER/diagrama4.png)

## Ejercicio 5

Una empresa está organizada en departamentos y necesita registrar la siguiente información:

> De cada **departamento** se almacena:
- Número único del departamento
- Nombre único del departamento
- Fecha de inicio del empleado que administra el departamento
- Ubicaciones del departamento (puede tener varias)

> De cada **proyecto** se almacena:
- Número único del proyecto
- Nombre único del proyecto
- Ubicación del proyecto

> De cada **empleado** se almacena:
- Nombre
- Número de Seguro Social (SSN)
- Dirección
- Salario
- Sexo (género)
- Fecha de nacimiento
- Horas semanales trabajadas por proyecto
- Supervisor directo (otro empleado)

> De cada **dependiente** se almacena:
- Nombre
- Sexo
- Fecha de nacimiento
- Relación con el empleado

> Reglas del negocio
1. Un departamento es administrado por un solo empleado
2. Un empleado puede administrar como máximo un departamento
3. Un departamento puede tener varias ubicaciones
4. Un departamento controla varios proyectos
5. Un proyecto pertenece a un solo departamento
6. Un empleado está asignado a un solo departamento
7. Un empleado puede trabajar en varios proyectos
8. Un proyecto puede tener varios empleados trabajando en él
9. Un empleado tiene un supervisor directo (otro empleado)
10. Un empleado puede supervisar a varios empleados
11. Un empleado puede tener varios dependientes
12. Un dependiente pertenece a un solo empleado

> Que se debe de realizar 

- Identificar las entidades
- Identificar los atributos
- Identificar los atributos multivalor (ubicaciones del departamento)
- Identificar los atributos compuestos (dirección)
- Identificar los atributos derivados
- Dibujar las relaciones
- Dibujar las cardinalidad
- Dibujar la participación de cada entidad

![Ejercicio5](/img/ER/diagrama5.png)