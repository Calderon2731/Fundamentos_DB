CREATE DATABASE LUBRICENTRO_LOS_ANGELES;

USE LUBRICENTRO_LOS_ANGELES;

------------------ CLIENTE ------------------
CREATE TABLE CLIENTE(
id_cliente INT IDENTITY (1,1) PRIMARY KEY,
id_tipo_cliente INT  NOT NULL, --FK
nombre VARCHAR(20) NOT NULL,
apellido_1 VARCHAR(20) NOT NULL,
apellido_2 VARCHAR(20) NOT NULL,
FOREIGN KEY (id_tipo_cliente) REFERENCES TIPO_CLIENTE (id_tipo_cliente)
);

---TELEFONOS DE LOS CLIENTES
CREATE TABLE TELEFONOS_CLIENTE(
id_telefono_cliente INT IDENTITY (1,1) PRIMARY KEY,
telefono VARCHAR(20) NOT NULL
);
---TABLA INTERMEDIA
CREATE TABLE TELEFONO_CLIENTE_CLIENTE(
id_Telefono_Cliente_Cliente  INT IDENTITY(1,1) PRIMARY KEY,
id_Telefono_Cliente INT NOT NULL,
id_Cliente INT NOT NULL,
FOREIGN KEY (id_Telefono_Cliente) REFERENCES TELEFONOS_CLIENTE(id_telefono_cliente),
FOREIGN KEY (id_Cliente) REFERENCES CLIENTE(id_cliente),
);

---TABLA DE CORREO ELECTRONICO
CREATE TABLE CORREOS_CLIENTES(
id_correos_cliente INT IDENTITY (1,1) PRIMARY KEY,
correo_electronico VARCHAR(100) NOT NULL,
);
---TABLA INTERMEDIA DE CORREOS ELECTRONICOS
CREATE TABLE CORREOS_CLIENTES_CLIENTE(
id_correos_cliente_cliente INT IDENTITY (1,1) PRIMARY KEY,
id_cliente INT NOT NULL,
id_correos_cliente INT NOT NULL,
FOREIGN KEY(id_cliente) REFERENCES CLIENTE (id_cliente),
FOREIGN KEY(id_correos_cliente) REFERENCES CORREOS_CLIENTES (id_correos_cliente)
);

CREATE TABLE TIPO_CLIENTE(
id_tipo_cliente INT IDENTITY (1,1) PRIMARY KEY,
tipo VARCHAR (20) NOT NULL CHECK (tipo IN ('frecuente','ocasional'))
);
---------------------------------------------------------------------------

------------------ TRABAJADOR ------------------
---------ESCRIBIR TABLAS TRABAJADOR, TELEFONOS_TRABAJADOR, CORREOS_TRABAJADOR, ROL

 CREATE TABLE TRABAJADORES(
 id_trabajador INT IDENTITY(1,1) PRIMARY KEY,
 id_rol_trabajador INT NOT NULL,
 nombre VARCHAR(20) NOT NULL,
 apellido_1 VARCHAR(20) NOT NULL,
 apellido_2 VARCHAR(20) NOT NULL
 FOREIGN KEY (id_rol_trabajador) REFERENCES ROL_TRABAJADOR(id_rol_trabajador)
 );
 ------------------ TABLA ROL DE TRABAJADORES------------------
 CREATE TABLE ROL_TRABAJADOR(
  id_rol_trabajador INT IDENTITY(1,1) PRIMARY KEY,
  rol VARCHAR(20) NOT NULL
 );
 ------------------ TABLA TELEFONOS DE TRABAJADORES ------------------
 CREATE TABLE TELEFONOS_TRABAJADORES(
 id_telefono_trabajador INT IDENTITY(1,1) PRIMARY KEY,
 telefono INT NOT NULL
 );

 CREATE TABLE TELEFONOS_TRABAJADORES_TRABAJADORES(
  id_telefonos_trabajadores_trabajadores INT IDENTITY(1,1) PRIMARY KEY,
  id_telefono_trabajador INT NOT NULL,
  id_trabajador INT NOT NULL,
	FOREIGN KEY (id_telefono_trabajador) REFERENCES TELEFONOS_TRABAJADORES(id_telefono_trabajador),
	FOREIGN KEY (id_trabajador) REFERENCES TRABAJADORES (id_trabajador)
 );

 ------------------ TABLA EMAIL DE TRABAJADORES ------------------

 CREATE TABLE EMAIL_TRABAJADORES(
  id_email_trabajador INT IDENTITY(1,1) PRIMARY KEY,
  email VARCHAR(20) NOT NULL,
 );


 CREATE TABLE EMAIL_TRABAJADORES_TRABAJADORES(
	id_email_trabajadores_trabajadores INT IDENTITY(1,1) PRIMARY KEY,
	id_email_trabajador INT NOT NULL,
	id_trabajador INT NOT NULL,
	FOREIGN KEY (id_email_trabajador) REFERENCES EMAIL_TRABAJADORES (id_email_trabajador),
	FOREIGN KEY (id_trabajador) REFERENCES TRABAJADORES (id_trabajador)
 );



---------------------------------------------------------------------------


------------------ PROVEEDOR ------------------
---------ESCRIBIR TABLAS PROVEEDOR, TELEFONOS_PROVEEDOR, CORREOS_PROVEEDOR, PROVEEDORES_PRODUCTOS,
---------------------------------------------------------------------------
 CREATE TABLE PROVEEDOR(
  id_proveedor INT IDENTITY(1,1) PRIMARY KEY,
  nombre VARCHAR(20),
  email VARCHAR(20)
 );

 CREATE TABLE TELEFONOS_PROVEEDOR(
  id_telefonos_proveedor INT IDENTITY(1,1) PRIMARY KEY,
  id_proveedor INT,
  FOREIGN KEY (id_proveedor) REFERENCES PROVEEDOR (id_proveedor)
 );

 CREATE TABLE PROVEEDORES_PRODUCTOS(
  id_proveedor_producto INT IDENTITY(1,1) PRIMARY KEY,
  id_proveedor INT,
  codigo_producto INT,
  FOREIGN KEY (id_proveedor) REFERENCES PROVEEDOR (id_proveedor),
  FOREIGN KEY (codigo_producto) REFERENCES PRODUCTO (codigo_producto),
 )

------------------ SERVICIO ------------------
CREATE TABLE SERVICIO(
id_servicio INT IDENTITY (1,1) PRIMARY KEY,
id_vehiculo INT NOT NULL, --FK
id_trabajador INT NOT NULL, --FK
id_factura INT NOT NULL, --FK
categoria VARCHAR(20) NOT NULL, --CHECK (categoria IN ('HAY QUE VER QUE CATEGORIAS HABRAN'))
estado_servicio VARCHAR(20) NOT NULL, --CHECK (estado_servicio IN ('HAY QUE VER QUE estados HABRAN'))
FOREIGN KEY (id_vehiculo) REFERENCES VEHICULO (id_vehiculo),
FOREIGN KEY (id_trabajador) REFERENCES TRABAJADOR (id_trabajador),
FOREIGN KEY (id_factura) REFERENCES FACTURA (id_factura),
);

CREATE TABLE SERVICIO_FACTURA(
id_servicio_factura INT IDENTITY (1,1) PRIMARY KEY,
id_servicio INT NOT NULL, --FK
id_factura INT NOT NULL, --FK
FOREIGN KEY (id_servicio) REFERENCES SERVICIO (id_servicio),
FOREIGN KEY (id_factura) REFERENCES FACTURA (id_factura)
);
---------------------------------------------------------------------------

------------------ VEHICULO ------------------
CREATE TABLE VEHICULO(
id_vehiculo INT IDENTITY (1,1) PRIMARY KEY,
id_tipo_vehiculo INT NOT NULL, --FK
id_cliente INT NOT NULL, --FK
id_fecha_cambio_aceite INT NOT NULL, --FK
color VARCHAR(20) NOT NULL,
modelo VARCHAR(20) NOT NULL,
numero_puertas INT NOT NULL,
año INT NOT NULL,
marca VARCHAR(20) NOT NULL,
FOREIGN KEY (id_tipo_vehiculo) REFERENCES TIPO_VEHICULO (id_tipo_vehiculo),
FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente),
FOREIGN KEY (id_fecha_cambio_aceite) REFERENCES FECHA_CAMBIO_ACEITE (id_fecha_cambio_aceite)
);

CREATE TABLE TIPO_VEHICULO(
id_tipo_vehiculo INT IDENTITY (1,1) PRIMARY KEY,
tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('carro', 'moto')),
);

CREATE TABLE FECHA_CAMBIO_ACEITE(
id_fecha_cambio_aceite INT IDENTITY (1,1) PRIMARY KEY,
fecha DATE NOT NULL
);
---------------------------------------------------------------------------

------------------ FACTURACION ------------------
CREATE TABLE FACTURA(
id_factura INT IDENTITY (1,1) PRIMARY KEY,
id_cliente INT NOT NULL, --FK
monto_total INT NOT NULL,
estado_pago VARCHAR(10) NOT NULL CHECK (estado_pago IN ('pagado', 'pendiente')),
fecha_emision DATE NOT NULL
FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente)
);

CREATE TABLE METODOS_PAGO(
id_metodo_pago INT IDENTITY (1,1) PRIMARY KEY,
tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('efectivo','tarjeta','sinpe'))
)

CREATE TABLE FACTURA_METODOS_PAGO(
id_factura_metodos_pago INT IDENTITY (1,1) PRIMARY KEY,
id_factura INT NOT NULL, --FK
id_metodo_pago INT NOT NULL --FK
FOREIGN KEY (id_factura) REFERENCES FACTURA (id_factura),
FOREIGN KEY (id_metodo_pago) REFERENCES METODOS_PAGO (id_metodo_pago)
);
---------------------------------------------------------------------------

------------------ CITA ------------------
---------ESCRIBIR TABLA CITA
---------------------------------------------------------------------------
CREATE TABLE CITA(
 id_cita INT IDENTITY (1,1) PRIMARY KEY,
 id_cliente INT,
 estado_cita VARCHAR(20),
 fecha DATE,
 hora TIME
 FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente)
)

------------------ PRODUCTO ------------------
---------ESCRIBIR TABLAS PRODUCTO, PRODUTO_FACTURA

 CREATE TABLE PRODUCTO(
  codigo_producto INT IDENTITY(1,1) PRIMARY KEY,
  nombre VARCHAR(20)
 )

 CREATE TABLE PRODUCTO_FACTURA(
  id_producto_factura INT IDENTITY(1,1) PRIMARY KEY,
  codigo_producto INT,
  id_factura INT,
  FOREIGN KEY (codigo_producto) REFERENCES PRODUCTO (codigo_producto),
  FOREIGN KEY (id_factura) REFERENCES FACTURA (id_factura)
 )





---------------------------------------------------------------------------
