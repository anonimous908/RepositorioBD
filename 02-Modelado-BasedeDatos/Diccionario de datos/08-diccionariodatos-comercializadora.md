# Diccionario de Datos de la Base de Datos: Comercializadora

## 1. Información General
| Elemento | Valor |
| :--- | :--- |
| Proyecto | Comercializadora |
| Versión | 1.0 |
| Fecha | Junio 2026 |
| Elaboró | David Borges Tavera |
| SGBD | SQLSERVER |

---

## 2. Descripción de la Base de Datos

La base de datos administra las operaciones comerciales de una empresa distribuidora:
- **Oficinas y Representantes:** Red de sucursales u oficinas comerciales, asignación de representantes de ventas (vendedores) y jerarquía de supervisión/jefatura.
- **Clientes:** Registro de empresas clientes y administración de su límite de crédito asignado.
- **Productos:** Catálogo de artículos disponibles especificando fabricante, precio unitario y existencia en almacén.
- **Pedidos y Detalle de Ventas:** Registro de órdenes de compra emitidas por clientes, atendidas por representantes de ventas y el desglose de productos vendidos por pedido.

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

### **Tabla:** *oficina*
**Descripción:** Sucursales comerciales y sus metas de venta.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `numero_oficina` | INT | - | PK, AI, NN | Número único de la oficina comercial. |
| `ciudad` | VARCHAR | 30 | UQ, NN | Ciudad donde se ubica la oficina. |
| `region` | VARCHAR | 20 | CK, Null | Región geográfica ('Este', 'Oeste'). |
| `objetivo` | DECIMAL | 10,2 | NN | Meta u objetivo financiero de ventas. |
| `ventas` | DECIMAL | 10,2 | NN | Total de ventas acumuladas por la oficina. |
| `numero_empl` | INT | - | FK, NN | Representante asignado como jefe de oficina. |

---

### **Tabla:** *representante*
**Descripción:** Fuerza de ventas y estructura jerárquica comercial.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `representante_id` | INT | - | PK, AI, NN | Identificador único del representante. |
| `nombre` | VARCHAR | 20 | NN | Nombre del representante de ventas. |
| `apellido_paterno` | VARCHAR | 18 | NN | Apellido paterno. |
| `apellido_materno` | VARCHAR | 18 | Null | Apellido materno (opcional). |
| `cuota` | DECIMAL | 10,2 | CK, NN | Cuota individual asignada (> 0.0). |
| `venta` | DECIMAL | 10,2 | CK, Null | Monto de ventas acumuladas (> 0.0). |
| `fecha_nacimiento` | DATE | - | NN | Fecha de nacimiento del vendedor. |
| `puesto` | VARCHAR | 30 | NN | Cargo o puesto de trabajo. |
| `representante_id_jefe` | INT | - | FK, Null | ID del jefe o supervisor directo (FK recursiva). |
| `numero_oficina` | INT | - | FK, NN | Oficina a la que está adscrito. |

---

### **Tabla:** *cliente*
**Descripción:** Empresas cliente registradas en el sistema.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `cliente_id` | INT | - | PK, AI, NN | Identificador único del cliente. |
| `empresa` | VARCHAR | 30 | UQ, NN | Nombre comercial o razón social. |
| `limite_credito` | DECIMAL | 10,2 | CK, NN | Límite de crédito otorgado (entre 1,000 y 100,000). |
| `representante_id` | INT | - | FK, NN | Representante asignado para atención al cliente. |

---

### **Tabla:** *producto*
**Descripción:** Inventario de mercancía producida por fabricantes.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `numero_producto` | INT | - | PK, NN | Código único del producto por fabricante. |
| `numero_fab` | CHAR | 5 | PK, NN | Clave de identificación del fabricante. |
| `descripcion` | VARCHAR | 50 | NN | Nombre y descripción técnica del artículo. |
| `precio_unitario` | DECIMAL | 10,2 | NN | Precio de lista unitario. |
| `existencia` | INT | - | NN | Unidades disponibles en inventario. |

---

### **Tabla:** *pedido*
**Descripción:** Órdenes de venta generadas por los clientes.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `pedido_id` | CHAR | 3 | PK, NN | Folio identificador de la orden de compra. |
| `fecha_pedido` | DATE | - | NN | Fecha de emisión de la orden. |
| `representante_id` | INT | - | FK, NN | Vendedor que procesó la venta. |
| `cliente_id` | INT | - | FK, NN | Cliente que adquiere la mercancía. |

---

### **Tabla:** *detalle_pedido*
**Descripción:** Desglose de partidas de productos en cada orden de compra.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `pedido_id` | CHAR | 3 | PK, FK, NN | Folio del pedido asociado. |
| `numero_producto` | INT | - | PK, FK, NN | Código del producto adquirido. |
| `numero_fab` | CHAR | 5 | PK, FK, NN | Fabricante del producto adquirido. |
| `precio` | DECIMAL | 10,2 | CK, NN | Precio pactado de venta unitaria (> 0.0). |
| `cantidad` | INT | - | CK, NN | Cantidad de unidades vendidas (> 0). |
